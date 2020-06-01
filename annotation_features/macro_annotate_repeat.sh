#!/usr/bin/bash
# Wytze Gelderloos
# 1-6-2020
# This script will use bedtools to find intersection with repeat and sum these up for each region
for crop_dir in *
do
if [[ -d $crop_dir ]]; then
	for author_dir in $crop_dir/*
	do
	if [[ -d $author_dir ]]; then
	echo $author_dir
	sed -i -E 's/^([[:digit:]])/Chr\1/g' $file
#	sed -i -E 's/^([[:digit:]])/Chr\1/g' //lustre/BIF/nobackup/gelde036/gene_dense/$species/$author/ref/*repeat.bed
	bedtools intersect -wo -a $author_dir/positive.all.10000.maxoverlap1kb.bed -b $author_dir/ref/*repeat.bed > $author_dir/positive.all.10000.maxoverlap1kb.bed.repeat.overlap.out
        bedtools intersect -wo -a $author_dir/negative.all.10000.maxoverlap1kb.bed -b $author_dir/ref/*repeat.bed > $author_dir/negative.all.10000.maxoverlap1kb.bed.repeat.overlap.out

	python3 //lustre/BIF/nobackup/gelde036/Scripts2/extract_repeats.py $author_dir/positive.all.10000.maxoverlap1kb.bed.repeat.overlap.out $author_dir/positive.all.10000.maxoverlap1kb.bed > $author_dir/positive.all.10000.maxoverlap1kb.bed.repeat.ann
        python3 //lustre/BIF/nobackup/gelde036/Scripts2/extract_repeats.py $author_dir/negative.all.10000.maxoverlap1kb.bed.repeat.overlap.out $author_dir/negative.all.10000.maxoverlap1kb.bed > $author_dir/negative.all.10000.maxoverlap1kb.bed.repeat.ann

	fi
	done
fi
done
