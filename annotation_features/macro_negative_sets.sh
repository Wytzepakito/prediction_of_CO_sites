#!/usr/bin/bash
# Author: Wytze Gelderloos
#13-11-2019
# This is also supposed to be ran inside the species folder
# it will make the negative set until it makes the fasta files

for crop_dir in *
do
if [[ -d $crop_dir ]]; then
for dir in $crop_dir/*
do
if [[ -d $dir ]]; then
	cat $dir/positive.all.10000.maxoverlap1kb.bed $dir/ref/NN.bed | sort -k1,1 -k2,2n > $dir/exclude_region.bed
 	bedtools merge -i $dir/exclude_region.bed | sort -k1,1 -k2,2n > $dir/exclude_region.merged.bed	
	
	bedtools shuffle -excl $dir/exclude_region.merged.bed -chrom -noOverlapping -g $dir/ref/*.genome -maxTries 10000000  -i $dir/positive.all.10000.maxoverlap1kb.bed | sort -k1,1 -k2,2n > $dir/negative.all.10000.maxoverlap1kb.bed
	bedtools getfasta -fi $dir/ref/*genome.fa -bed $dir/negative.all.10000.maxoverlap1kb.bed -fo $dir/negative.all.10000.maxoverlap1kb.fasta
	bedtools getfasta -fi $dir/ref/*genome.fa -bed $dir/positive.all.10000.maxoverlap1kb.bed -fo $dir/positive.all.10000.maxoverlap1kb.fasta

	sed 's/g/G/g' $dir/negative.all.10000.maxoverlap1kb.fasta | sed 's/a/A/g' | sed 's/t/T/g' | sed 's/c/C/g' > $dir/negative.all.10000.maxoverlap1kb.tmp

 	mv $dir/negative.all.10000.maxoverlap1kb.tmp $dir/negative.all.10000.maxoverlap1kb.fasta
fi

done
fi
done
