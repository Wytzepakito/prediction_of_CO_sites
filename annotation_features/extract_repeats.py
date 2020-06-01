#!/usr/bin/python3
# Wytze Gelderloos
# 19-4-2020
# This will extract the overlap of CO's of repeat regions with all possible regions
import sys
arg = sys.argv[1]
arg2 = sys.argv[2]
def expand_feature_list_with_other_mood(arg):
    if "posi" in arg:
        new_arg = arg.replace("posi", "nega")
    elif "nega" in arg:
        new_arg = arg.replace("nega", "posi")
    more_features = []
    file= open(new_arg,"r")
    for line in file.readlines():
        line_list = line.strip("\n").split()
        if line_list[6] not in more_features:
            more_features.append(line_list[6])
    file.close()
    return more_features

def extract_COs_and_repeat_feature_and_init_dic(arg,arg2):
    file = open(arg, "r")
    CO_list =[]
    repeat_feature = []
    for line in file.readlines():
        line_list = line.strip("\n").split()
        CO_tag =  line_list[0]+":"+line_list[1]+"-"+line_list[2]
        if CO_tag not in CO_list:
            CO_list.append(CO_tag)
        if line_list[6] not in repeat_feature:
            repeat_feature.append(line_list[6])
    file.close()

    CO_file = open(arg2, "r")
    for line in CO_file.readlines():
        line_list = line.strip("\n").split()
        CO_tag = line_list[0]+":"+line_list[1]+"-"+line_list[2]
        if CO_tag not in CO_list:
            CO_list.append(CO_tag)
    CO_file.close()
    # finding the features in the other mood's 
    more_feature =  expand_feature_list_with_other_mood(arg)
    repeat_feature = list(set(repeat_feature+more_feature))
    super_dic ={}
    for CO in CO_list:
        super_dic[CO]= {}
        for feature in repeat_feature:
            super_dic[CO][feature]= 0
    return super_dic,repeat_feature


def fill_super_dic(super_dic, arg):
    file = open(arg,"r")
    for line in file.readlines():
        line_list = line.strip("\n").split()
        CO_tag =  line_list[0]+":"+line_list[1]+"-"+line_list[2]
        feature = line_list[6]
        super_dic[CO_tag][feature] += int(line_list[7])
    return super_dic



super_dic,repeat_feature = extract_COs_and_repeat_feature_and_init_dic(arg,arg2)
repeat_feature.insert(0,"sequence_id")
super_dic = fill_super_dic(super_dic, arg)


# features is the dictionary with all possible features
#which could overlap the current CO
print("\t".join(repeat_feature))
repeat_feature.remove("sequence_id")
for key, features in super_dic.items():
    line_list = [key]
    for feature in repeat_feature:
        line_list.append(str(features[feature]))
    print("\t".join(line_list))
