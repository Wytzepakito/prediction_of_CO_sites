
#!/usr/bin/bash
# Author: Wytze Gelderloos
# 1-11-2019
# This will copy all features
# This is called a macro because its tun from CO_ready
#

for crop_dir in *
do
if [[ -d $crop_dir ]]; then

        for author_dir in ${crop_dir}/*
        do
        if [[ -d $author_dir ]]; then
        outname="${author_dir/\//\.}"
        out_pos_loc="${outname}.pos.feat"
        out_neg_loc="${outname}.neg.feat"
	echo $author_dir
        cp $author_dir/positive.features.txt ~/RESULTS_GENE_DENSE/run1/$out_pos_loc
        cp $author_dir/negative.features.txt ~/RESULTS_GENE_DENSE/run1/$out_neg_loc

        fi
        done
fi
done

