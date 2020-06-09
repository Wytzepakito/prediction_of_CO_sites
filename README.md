Guide to using Wytzes scripts along with those of Sevgin
Dependencies
Bedtools v2.92.2
FIMO obtained from the MEME suite
Samtools 1.7
RepeatMasker version open-4.0.9
Python 3.6.8 with packages:nan
	Numpycd 
	Pandas
	Subprocess
	Shlex
	Matplotlib
	Sklearn.neighbours
	Regex
	biopython
R 3.6.1	with packages:
	DNAshapeR
	randomForest
	plot.matrix
	ggplot2
	stringr
	viridis
	ROCR
	Adabag
	Caret

Hardcoding some locations
Macro_dinuc_freqs.sh: location to script folder as wel as obtain_dinuc_freqs.py should be added
Macro_DNA_shape: location to R installation folder should be added in front of DNAshape.r as well as location to DNAshape.r script
Macro_extract_gene.sh: location to extract_gene_content.py script should be added
Macro_fimo_process.sh: location to process_fimo.py should be added
Macro_gene_dense.sh: location to neg_gene_dense.py should be added 
Macro_annotate_repeat.sh: location to extract_repeat.py should be added
Annotation of features
To make my scripts more easily scalable while also being able to check during the annotation of features I worked with the following format. 
All studies with their annotation files were put in folders like [research_folder]/[species]/[study].
All scripts starting with macro- use this folder format and should be run from [research folder]
[study] was then the name of the author, in this folder a reference genome folder titled ‘ref’ should be added. This ‘ref’ folder should at least include the following files titled in the following way:
Ref folder input:
A reference genome fasta file ending with ‘genome.fa’. This file should have its chromosome entries labeled as ‘>Chr[number of chromosome] | [any other text]’. So for chromosome 1 for Arabidopsis this would be ‘>Chr1 ’.
Using this command:
sed -i -E 's/>([[:digit:]]{1,2})/>Chr\1   |/g' [ genome fasta file]
will do this for arabidopsis
A reference genome annotation file ending with ‘.gff’
A gene.mid.txt file created by:
awk '$3=="gene" { diff=int(($5-$4)/2); mid=$4+diff; len=int($5-$4); print $1"\t"mid"\t"len}' [reference genome annotation .gff file ] > gene.mid.txt
A lengths.genome file created by running: 
python3 [script location]/write_genome_lengths.py [genome fasta file] | grep -E ‘Chr[[:digit:]]+’ |  > lengths.genome
preferentially remove all non-numbered chromosomes from this file so probably ‘ChrUn’ and all contigs
A NN.bed file created by:
Python3 predNN.py [reference fasta file] | '^[[:digit:]]'  | sed -E 's/^([[:digit:]]{1,2})/Chr\1/g' > NN.bed
Note this script is an improvement of Sevgins script in that it also annotates all possible other letters in a reference genome as an exclusion region. Sevgin only annotated ‘N’, this script annotates : ‘NMKWRYSD’
A samtools index file created by:
Samtools faidx [reference fasta file]
A 5_UTRs bed file created by:
awk '$3 ~ /five_prime_UTR/' *.gff | awk -v OFS='\t' '{ print $1, $4, $5}'| sort -V -k1,1 -k2,2   > 5_UTRs.bed
Study folder input:
CO.10000.bed, the positive or CO regions obtained which should be extended from their input by the following command:
awk '$3-$2 <= 2000' [input CO bed file] | awk -F'\t' -v OFS='\t' '{mid=int(($3-$2)/2)+$2; $2=mid-(10000/2)-1; $3=mid+(10000/2); print $0}' | sort -k1,1 -k2,2n | uniq | sed -E ‘s/^([[:digit:]]{1,2})/Chr\1/g’ > CO.10000.bed

Order of scripts
Once all these files are in place for every study one has to decide whether one wants to do random sampling from the whole genome or sample based on the densitykernel explained by Sevgin. If one wants to do the random sampling choose the red script when possible.

Run all these scripts from the [research folder] in the following order:
bash macro_positive_sets.sh
bash macro_gene_dense.sh or bash macro_negative_set.sh
bash macro_dinuc_freqs.sh		
bash macro_DNAshape.sh
bash macro_find_closest_TSS.sh
bash macro_extract_gene.sh
bash macro_fimo.sh
bash macro_fimo_process.sh
bash macro_annotate_repeat.sh 2x
This last command will probably spew some naming convention errors by bedtools. These do not cause an issue. Do run it two times to make sure the positive and negative regions contain the same repeats
bash macro_FUSION.sh

Features now have been annotated and are in the [research folder]/[species]/[study]/.
As positive.features.txt and negative.features.txt. On these features one can now do machine learning.

I always used my macro_copy_learned.sh script to copy the positive and negative features of all datasets into the ‘machine learning’ same folder, this also changed their names to [species].[author].pos.feat and [species].[author].neg.feat. Then inside this machine learning folder I created the same format as the research folder so [machine learning folder]/[species]/[author].
The main scripts I used for all RF machine learning were macro_machinelearner_CV.sh, machinelearner_CV.r and cross_validation_functions.r. Macro_machinelearner_CV.sh was written to run machinelearner_CV.r on every [species].[author].[pos/neg].feat. It does need [species].[author] hardcoded as a list of space delimited input for the for loop.  And has to be ran inside your [machine learning folder]. 
To only keep the intersecting columns, so columns that appear in every dataset, use the intersecting_cols.py script which should be run inside the [machine learning folder]. It has  a hardcoded output location, ‘OUTPUT_LOC’, and the ‘files_dic’ should contain all species as keys and a list of authors for every species key as values. 
The same hardcoding has to be done for super_cols.py, this script reads all features all the datasets have and then provides a 0 for every region which does not have the feature annotated but other studies did contain this feature.
To split out the results of the all-species model into results per species or results per author 


