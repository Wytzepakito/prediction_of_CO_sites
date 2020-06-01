#!/usr/bin/bash
# Wytze Gelderloos
# 5-12-2019
# This script extracts all the first exons from the gene or pseudogene entries in the reference genome.
import sys

file = open(sys.argv[1], "r")

grab_exon = False 
for line in file.readlines():
    if not line.startswith("#"):
## This is the column with the feature gen, exon etc..
        if line.split()[2]=="gene" or line.split()[2]=="pseudogene" or line.split()=="mRNA":
            grab_exon = True
        elif (grab_exon==True and line.split()[2]=="exon"):
            str_list = [line.split("\t")[0], line.split("\t")[3], line.split("\t")[4]]
            print("\t".join(str_list))
            grab_exon = False
