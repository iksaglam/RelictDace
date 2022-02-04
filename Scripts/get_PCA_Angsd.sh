#!/bin/bash

#SBATCH -t 2880
#SBATCH -p bigmemh
#SBATCH -n 10
#SBATCH -N 1

##############################################

pop=$1
ref='/home/abenj93/projects/RelictDace/data/de_novo/RD_alignment/ref_contigs/RD_ref_final_contigs_300.fasta'
loci='/home/iksaglam/relictdace/RD.loci'
nInd=$(wc -l ${pop}.bamlist | awk '{print $1}')
mInd=$((${nInd}/2))
mkdir results_pca_${pop}

#############################################

### Build Geno file in beagle format ###


	angsd -bam ${pop}.bamlist -ref $ref -out results_pca_${pop}/${pop} -rf $loci  -GL 1 -doCounts 1 -doMajorMinor 1 -doMaf 1 -doGlf 2 -minMapQ 10 -minQ 20 -minInd $mInd -SNP_pval 1e-12 -minMaf 0.05 -nThreads 10

### Calculate covariance matrix ###

	python ~/bin/pcangsd-0.973/pcangsd.py -beagle results_pca_${pop}/${pop}.beagle.gz -o results_pca_${pop}/${pop} -threads 10

### Calculate admixture proportions ###

	~/bin/pcangsd-0.973/pcangsd.py -beagle results_pca_${pop}/${pop}.beagle.gz -admix -o results_pca_${pop}/${pop} -threads 10

### Calculate inbreeding, kinship and  sites effected by inbreeding ###

	python ~/bin/pcangsd-0.973/pcangsd.py -beagle results_pca_${pop}/${pop}.beagle.gz -inbreed 3 -o results_pca_${pop}/${pop} -threads 10
	python ~/bin/pcangsd-0.973/pcangsd.py -beagle results_pca_${pop}/${pop}.beagle.gz -kinship -o results_pca_${pop}/${pop} -threads 10
	python ~/bin/pcangsd-0.973/pcangsd.py -beagle results_pca_${pop}/${pop}.beagle.gz −inbreedSites -o results_pca_${pop}/${pop} -threads 10

### Conduct selection scan

	python ~/bin/pcangsd-0.973/pcangsd.py -beagle results_pca_${pop}/${pop}.beagle.gz -HWE_filter $pop.lrt.sites.gz -selection 1 -sites_save -o results_pca_${pop}/${pop} -threads 10



