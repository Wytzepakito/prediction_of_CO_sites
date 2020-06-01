#!/bin/bash
# Author: Wytze Gelderloos
#13-11-2019
# This script makes sure that the CO_locations are not too close too eachother and if they are too close it will choose one
# it will also discard CO locations which are too close to each other
# It is supposed to be ran inside the species folder
for crop_dir in *
do
if [[ -d $crop_dir ]]; then
for dir in $crop_dir/*
do
if [[ -d $dir ]]; then
	echo $dir
 	bedtools sort -i $dir/CO.10000.bed  | bedtools intersect -v -a stdin  -b $dir/ref/NN.bed > $dir/positive.bed


	bedtools merge -d -1000 -i $dir/positive.bed | awk '$3-$2 >= 4001' > $dir/positive.bed.overlapping.bed

	bedtools merge -d -1000 -i $dir/positive.bed | awk ' $3-$2 == 10000' > $dir/positive.bed.non-overlapping.mrthn1kb.bed

	awk -v OFS='\t' 'function roll(n) {return 1+ int(rand()*n)} {if (roll(2)==1) print $1, $2, $2+10000; else print $1, $3-10000, $3}' $dir/positive.bed.overlapping.bed > $dir/positive.bed.overlapping_selected.bed

	cat $dir/positive.bed.overlapping_selected.bed $dir/positive.bed.non-overlapping.mrthn1kb.bed | sort -k1,1 -k2,2n| uniq   > $dir/positive.all.10000.maxoverlap1kb.bed
	bedtools getfasta -fi $dir/ref/*.genome.fa -bed $dir/positive.all.10000.maxoverlap1kb.bed -fo $dir/positive.all.10000.maxoverlap1kb.fasta

	#for genomes that are masked and replaced with lower-case letters
	sed 's/g/G/g' $dir/positive.all.10000.maxoverlap1kb.fasta | sed 's/a/A/g' | sed 's/t/T/g' | sed 's/c/C/g' > $dir/positive.all.10000.maxoverlap1kb.tmp

	mv $dir/positive.all.10000.maxoverlap1kb.tmp $dir/positive.all.10000.maxoverlap1kb.fasta
fi
done
fi
done
