#!/bin/bash

pop1=$1
pop2=$2
n=$(wc -l $loci | awk '{print $1}')

### Calculate index for fst and pbs analysis###

	realSFS fst index -fold 1 results_folded_sfs/${pop1}.folded.saf.idx results_folded_sfs/${pop2}.folded.saf.idx -sfs results_folded_sfs/${pop1}.${pop2}.folded.2dsfs -fstout results_fst/${pop1}.${pop2}.folded

### Calculate global fst and pbs statistics ###

	realSFS fst stats -fold 1 results_fst/${pop1}.${pop2}.folded.fst.idx 2> results_fst/${pop1}.${pop2}.folded.global.fst

