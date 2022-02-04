#!/bin/bash


infile=$1
ref='/home/abenj93/projects/RelictDace/data/de_novo/RD_alignment/ref_contigs/RD_ref_final_contigs_300.fasta'
loci='/home/iksaglam/relictdace/RD.loci'
n=$(wc -l $infile | awk '{print $1}')

mkdir results_diversity  ### All output goes here ###


### Calculate saf files and the ML estimate of the sfs using the EM algorithm for each population ###

x=1
while [ $x -le $n ] 
do

	pop=$(sed -n ${x}p $infile)

		echo "#!/bin/bash" > $pop.sh
		echo "" >> $pop.sh
		echo "angsd -bam $pop.bamlist -ref $ref -anc $ref -rf $loci -out results_diversity/$pop -pest results_folded_sfs/${pop}.folded.sfs -GL 1 -doThetas 1 -doSaf 1 -fold 1 -doCounts 1 -minMapQ 10 -minQ 20" >> $pop.sh
		echo "realSFS saf2theta results_folded_sfs/$pop.folded.saf.idx -outname results_diversity/$pop -sfs results_folded_sfs/${pop}.folded.sfs -fold 1" >> $pop.sh
		echo "thetaStat do_stat results_diversity/$pop.thetas.idx" >> $pop.sh

		sbatch -J iksdiv -p high --mem=60G -t 2880 -c 1 $pop.sh

	x=$(( $x + 1 ))

done


