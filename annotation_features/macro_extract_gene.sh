 #!/usr/bin/bash
# Wytze Gelderloos
# 2-12-2019
# This will give all the genes that overlap with the CO region and annotate them as a percentage.

for crop_dir in *
do
if [[ -d $crop_dir ]]; then

        for author_dir in ${crop_dir}/*
        do
        if [[ -d $author_dir ]]; then
	# in the gff files the chromosomes are again called Chr##

        bedtools intersect -nonamecheck -wo -a $author_dir/positive.all.10000.maxoverlap1kb.bed -b $author_dir/ref/*.gff > $author_dir/positive.all.10000.maxoverlap1kb.bed.genes.overlap.out
        sed -i 's/#/_/g' $author_dir/positive.all.10000.maxoverlap1kb.bed.genes.overlap.out
        sed -i 's/%/_/g' $author_dir/positive.all.10000.maxoverlap1kb.bed.genes.overlap.out
	python3 //lustre/BIF/nobackup/gelde036/Scripts/extract_gene_content.py $author_dir/positive.all.10000.maxoverlap1kb.bed $author_dir/positive.all.10000.maxoverlap1kb.bed.genes.overlap.out > $author_dir/positive.all.10000.maxoverlap1kb.bed.gene.content.txt
        paste $author_dir/positive.all.10000.maxoverlap1kb.bed.mids.bed.closest.tss.txt $author_dir/positive.all.10000.maxoverlap1kb.bed.gene.content.txt | cut -f1,2,4- > $author_dir/positive.all.10000.maxoverlap1kb.bed.fromAnn.txt



	bedtools intersect -nonamecheck -wo -a $author_dir/negative.all.10000.maxoverlap1kb.bed -b $author_dir/ref/*.gff > $author_dir/negative.all.10000.maxoverlap1kb.bed.genes.overlap.out
        sed -i 's/#/_/' $author_dir/negative.all.10000.maxoverlap1kb.bed.genes.overlap.out
        sed -i 's/%/_/g' $author_dir/negative.all.10000.maxoverlap1kb.bed.genes.overlap.out

	python3 /lustre/BIF/nobackup/gelde036/Scripts/extract_gene_content.py $author_dir/negative.all.10000.maxoverlap1kb.bed $author_dir/negative.all.10000.maxoverlap1kb.bed.genes.overlap.out >  $author_dir/negative.all.10000.maxoverlap1kb.bed.gene.content.txt
	paste $author_dir/negative.all.10000.maxoverlap1kb.bed.mids.bed.closest.tss.txt $author_dir/negative.all.10000.maxoverlap1kb.bed.gene.content.txt | cut -f1,2,4- > $author_dir/negative.all.10000.maxoverlap1kb.bed.fromAnn.txt

        fi
        done
fi
done

