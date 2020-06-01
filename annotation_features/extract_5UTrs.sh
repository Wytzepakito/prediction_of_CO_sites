#!usr/bin/bash
# extracts 5 UTRS from genome annotation file and outputs as bed

for dir in *
do
if [[ -d $dir ]]; then


 awk '$3 ~ /five_prime_UTR/' $dir/ref/*.gff* | awk '{print $1, $4, $5}' > $dir/ref/5_UTRs.bed
fi
done

