#!/usr/bin/bash
# Wytze Gelderloos
# 9-6-2020
# This will annotate all repeat inside the positive or negative regions


for crop_dir in *
do
if [[ -d $crop_dir ]]; then


	for author_dir in  ${crop_dir}/*
	do
	if [[ -d $author_dir ]]; then

	bedtools intersect -wo -a $author_dir/positive.all.10000.maxoverlap1kb.bed -b $author_dir/ref/*repeat.bed > $author_dir/positive.all.10000.maxoverlap1kb.bed.repeat.overlap.out
	python3 //lustre/BIF/nobackup/gelde036/Scripts/extract_repeats.py $author_dir/positive.all.10000.maxoverlap1kb.bed.repeat.overlap.out $author_dir/positive.all.10000.maxoverlap1kb.bed > $author_dir/positive.all.10000.maxoverlap1kb.bed.repeat.ann
	
        bedtools intersect -wo -a $author_dir/negative.all.10000.maxoverlap1kb.bed -b $author_dir/ref/*repeat.bed > $author_dir/negative.all.10000.maxoverlap1kb.bed.repeat.overlap.out
        python3 //lustre/BIF/nobackup/gelde036/Scripts/extract_repeats.py $author_dir/negative.all.10000.maxoverlap1kb.bed.repeat.overlap.out $author_dir/negative.all.10000.maxoverlap1kb.bed > $author_dir/negative.all.10000.maxoverlap1kb.bed.repeat.ann
	fi
	done

fi
done
