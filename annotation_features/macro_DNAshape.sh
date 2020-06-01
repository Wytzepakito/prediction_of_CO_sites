
#!/usr/bin/bash
# Author: Wytze Gelderloos
#19-11-2019
# This will do the DNAshapeR analysis for all files from CO_ready


CO_dir=$PWD
for crop_dir in *
do
if [[ -d $crop_dir ]]; then

        for author_dir in ${crop_dir}/*
        do
        if [[ -d $author_dir ]]; then

	for file in positive.all.10000.maxoverlap1kb.fasta negative.all.10000.maxoverlap1kb.fasta
	do
	echo $author_dir/$file
	/mnt/scratch/dijk097/software/R-3.6.1/bin/Rscript /lustre/BIF/nobackup/gelde036/Scripts/DNAshapeR.r $author_dir/$file
	paste $author_dir/${file/.fasta/}.dinuc.txt $author_dir/$file.HelT.txt $author_dir/$file.MGW.txt $author_dir/$file.ProT.txt $author_dir/$file.Roll.txt > $author_dir/$file.fromSeq.txt
	done
	fi
	done
fi
done

	
