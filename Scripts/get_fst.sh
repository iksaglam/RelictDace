#!/bin/bash

pop1=$1
pop2=$2
n=$(wc -l $loci | awk '{print $1}')

### Calculate index for fst and pbs analysis###

#	realSFS fst index results_sfs/${pop1}.saf.idx results_sfs/${pop2}.saf.idx -sfs results_sfs/${pop1}.${pop2}.2dsfs -fstout results_fst2/${pop1}.${pop2}

### Calculate global fst and pbs statistics ###

	realSFS fst stats results_fst2/${pop1}.${pop2}.fst.idx 2> results_fst2/${pop1}.${pop2}_global.fst

