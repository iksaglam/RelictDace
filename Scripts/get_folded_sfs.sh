#!/bin/bash

#SBATCH -t 2880
#SBATCH -p high
#SBATCH -n 1
#SBATCH -N 1

mkdir results_folded_sfs  ### All output goes here ###

pop=$1
ref='/home/abenj93/projects/RelictDace/data/de_novo/RD_alignment/ref_contigs/RD_ref_final_contigs_300.fasta'
loci='/home/iksaglam/relictdace/RD.loci'
nInd=$(wc -l ${pop}.bamlist | awk '{print $1}')
minInd=$((${nInd}/2))
minDepth=$(((${nInd}/2)*6))

		angsd -bam $pop.bamlist -ref $ref -anc $ref -rf $loci -out results_folded_sfs/$pop.folded -GL 1 -doSaf 1 -fold 1 -doCounts 1 -minMapQ 10 -minQ 20
#		angsd -bam $pop.bamlist -ref $ref -anc $ref -rf $loci -out results_folded_sfs/$pop.folded -remove_bads 1 -C 50 -baq 2 -GL 1 -doSaf 1 -fold 1 -doCounts 1 -minMapQ 10 -minQ 20 -minInd $minInd -setMinDepth $minDepth
		realSFS results_folded_sfs/$pop.folded.saf.idx -maxIter 100 > results_folded_sfs/$pop.folded.sfs
		Rscript ~/bin/ngsTools/Scripts/plotSFS.R results_folded_sfs/$pop.folded.sfs $pop 0 results_folded_sfs/$pop.folded.sfs.pdf
