#!/usr/bin/bash
# Author: Wytze Gelderloos
#19-11-2019
# This will  make the negative set from gene dense regions and sort them.
# It is again a Macro

current_dir=$PWD
for crop_dir in *
do
if [[ -d $crop_dir ]]; then

        for author_dir in ${crop_dir}/*
        do
        if [[ -d $author_dir ]]; then
	cd $author_dir
	cat positive.all.10000.maxoverlap1kb.bed ref/NN.bed | sort -k1,1 -k2,2n > exclude_region.bed
	bedtools merge -i exclude_region.bed | sort -k1,1 -k2,2n > exclude_region.merged.bed
	python3 //lustre/BIF/nobackup/gelde036/Scripts/neg_gene_dense.py  positive.all.10000.maxoverlap1kb.bed ref/lengths.genome exclude_region.merged.bed ref/gene.mid.txt ./
        	
	awk '{OFS="\t"; print $1,$2,$3+1}' sampled.bed | sort -k1,1 -k2,2 > negative.all.10000.maxoverlap1kb.bed
        sort -k1,1 -k2,2 positive.all.10000.maxoverlap1kb.bed > temp
        mv temp positive.all.10000.maxoverlap1kb.bed
        bedtools getfasta -fi ref/*genome.fa -bed negative.all.10000.maxoverlap1kb.bed -fo negative.all.10000.maxoverlap1kb.fasta
        bedtools getfasta -fi ref/*genome.fa -bed positive.all.10000.maxoverlap1kb.bed -fo positive.all.10000.maxoverlap1kb.fasta
        sed 's/g/G/g' positive.all.10000.maxoverlap1kb.fasta | sed 's/a/A/g' | sed 's/t/T/g' | sed 's/c/C/g' > positive.all.10000.maxoverlap1kb.tmp
	mv positive.all.10000.maxoverlap1kb.tmp positive.all.10000.maxoverlap1kb.fasta
	sed 's/g/G/g' negative.all.10000.maxoverlap1kb.fasta | sed 's/a/A/g' | sed 's/t/T/g' | sed 's/c/C/g' > negative.all.10000.maxoverlap1kb.tmp
        mv negative.all.10000.maxoverlap1kb.tmp negative.all.10000.maxoverlap1kb.fasta
        cd $current_dir
        

        fi
        done
fi
done

