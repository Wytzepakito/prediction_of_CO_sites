#!/usr/bin/bash
# do dinuc freq python script for every Author inside species folder

for crop_dir in *
do
if [[ -d $crop_dir ]]; then


for dir in $crop_dir/*
do
if [[ -d $dir ]]; then
	python3 //lustre/BIF/nobackup/gelde036/Scripts/obtain_dinuc_freqs.py $dir/positive.all.10000.maxoverlap1kb.fasta > $dir/positive.all.10000.maxoverlap1kb.dinuc.txt
	python3 //lustre/BIF/nobackup/gelde036/Scripts/obtain_dinuc_freqs.py $dir/negative.all.10000.maxoverlap1kb.fasta > $dir/negative.all.10000.maxoverlap1kb.dinuc.txt
fi
done
fi 
done
