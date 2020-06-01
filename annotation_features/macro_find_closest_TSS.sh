#!/usr/bin/bash
# Wytze Gelderloos
# 18-11-2019
# find closest UTRs of all CO regions
for crop_dir in *
do
if [[ -d $crop_dir ]]; then
for dir in $crop_dir/*
do
if [[ -d $dir ]]; then
for file in positive.all.10000.maxoverlap1kb.bed negative.all.10000.maxoverlap1kb.bed
do

awk -v OFS='\t' '{diff=int(($3-$2)/2); mid=$2+diff; print $1, mid-1, mid, $1":"$2"-"$3}' $dir/$file | sort -k1,1 -k2,2n > $dir/$file.mids.bed
awk '{print $1,$2,$3, $4}' $dir/$file.mids.bed  | sed 's/\s/\t/g' | bedtools sort  -i stdin > $dir/$file.mids.tmp
mv $dir/$file.mids.tmp $dir/$file.mids.bed
bedtools closest -nonamecheck -D b -t first -a $dir/$file.mids.bed -b $dir/ref/5_UTRs.bed | awk '{print $4"\t"$NF}'  > $dir/$file.temp
echo -e "#name\tdistanceTSS" | cat - $dir/$file.temp > $dir/$file.mids.bed.closest.tss.txt
rm $dir/$file.temp

done
fi
done

fi 
done
