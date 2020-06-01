#!/usr/bin/bash
# Author: Wytze Gelderloos
#3-11-2019
#  This will process all fimo output 



for crop_dir in *
do
if [[ -d $crop_dir ]]; then

        for author_dir in ${crop_dir}/*
        do
        if [[ -d $author_dir ]]; then
        python3 //lustre/BIF/nobackup/gelde036/Scripts/process_fimo.py $author_dir/positive_fimo/fimo.tsv $author_dir/positive.all.10000.maxoverlap1kb.bed > $author_dir/positive_fimo/positive.all.10000.maxoverlap1kb.bed.fimo.txt
	python3 //lustre/BIF/nobackup/gelde036/Scripts/process_fimo.py $author_dir/negative_fimo/fimo.tsv $author_dir/negative.all.10000.maxoverlap1kb.bed > $author_dir/negative_fimo/negative.all.10000.maxoverlap1kb.bed.fimo.txt



        fi
        done
fi
done

