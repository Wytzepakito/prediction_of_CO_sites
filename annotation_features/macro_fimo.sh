#!/usr/bin/bash
# Author: Wytze Gelderloos
#1-11-2019
# This will run the fimo motifs for all authors



for crop_dir in *
do
if [[ -d $crop_dir ]]; then

        for author_dir in ${crop_dir}/*
        do
        if [[ -d $author_dir ]]; then
	
	fimo --max-stored-scores 2000000 --oc $author_dir/positive_fimo/ --verbosity 1 --thresh 1.0E-4 ~/motifs_to_find/motifs.meme $author_dir/positive.all.10000.maxoverlap1kb.fasta
        fimo --max-stored-scores 2000000 --oc $author_dir/negative_fimo/ --verbosity 1 --thresh 1.0E-4 ~/motifs_to_find/motifs.meme $author_dir/negative.all.10000.maxoverlap1kb.fasta

        fi
        done
fi
done

