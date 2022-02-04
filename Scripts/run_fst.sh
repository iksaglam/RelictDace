#!/bin/bash

mkdir results_fst2

### infiles ###
F1=$1 ### list containing population names ###
n=$(wc -l $F1 | awk '{print $1}')

### calculate all pairwise Fst's ###

x=1
while [ $x -le $n ] 
do
	y=$(( $x + 1 ))
	while [ $y -le $n ]
	do
	
	str1=$( (sed -n ${x}p $F1) )  
	str2=$( (sed -n ${y}p $F1) )

		sbatch -p high -t 1440 --mem=32G get_fst.sh $str1 $str2

	y=$(( $y + 1 ))
	
	done

x=$(( $x + 1 ))

done

