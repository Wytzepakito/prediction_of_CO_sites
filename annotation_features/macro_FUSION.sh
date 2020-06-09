#!/usr/bin/bash
# Wytze Gelderloos
#4-12-2019
# This script fuses all feature files into a main positve or negative features file

for crop_dir in *
do
if [[ -d $crop_dir ]]; then

        for author_dir in ${crop_dir}/*
        do
        if [[ -d $author_dir ]]; then
        cut -f1 $author_dir/positive_fimo/positive.all.10000.maxoverlap1kb.bed.fimo.txt > $author_dir/positive.index
	cut -f2- $author_dir/positive.all.10000.maxoverlap1kb.fasta.fromSeq.txt > $author_dir/positive.Seq.txt
	cut -f2- $author_dir/positive.all.10000.maxoverlap1kb.bed.fromAnn.txt > $author_dir/positive.Ann.txt
	cut -f2- $author_dir/positive_fimo/positive.all.10000.maxoverlap1kb.bed.fimo.txt > $author_dir/positive.fimo.txt
	cut -f2- $author_dir/positive.all.10000.maxoverlap1kb.bed.repeat.ann > $author_dir/positive.repeat.txt
	paste $author_dir/positive.index $author_dir/positive.Seq.txt $author_dir/positive.Ann.txt $author_dir/positive.fimo.txt $author_dir/positive.repeat.txt > $author_dir/positive.features.txt
#	rm  $author_dir/positive.index $author_dir/positive.Ann.txt $author_dir/positive.fimo.txt $author_dir/positive.Seq.txt

        cut -f1 $author_dir/negative_fimo/negative.all.10000.maxoverlap1kb.bed.fimo.txt > $author_dir/negative.index
        cut -f2- $author_dir/negative.all.10000.maxoverlap1kb.fasta.fromSeq.txt > $author_dir/negative.Seq.txt
        cut -f2- $author_dir/negative.all.10000.maxoverlap1kb.bed.fromAnn.txt > $author_dir/negative.Ann.txt
        cut -f2- $author_dir/negative_fimo/negative.all.10000.maxoverlap1kb.bed.fimo.txt > $author_dir/negative.fimo.txt
	cut -f2- $author_dir/negative.all.10000.maxoverlap1kb.bed.repeat.ann > $author_dir/negative.repeat.txt
        paste $author_dir/negative.index $author_dir/negative.Seq.txt $author_dir/negative.Ann.txt $author_dir/negative.fimo.txt $author_dir/negative.repeat.txt > $author_dir/negative.features.txt
#        rm  $author_dir/negative.index $author_dir/negative.Ann.txt $author_dir/negative.fimo.txt $author_dir/negative.Seq.txt



        fi
        done
fi
done

