#!/bin/bash -l
#$ -M svu7@cdc.gov
#$ -m ae

N_LINES=$1
echo "Number of lines used: $N_LINES"

module load nextflow

mkdir -p $HOME/lepto_swga/swga_results

nextflow run \
	-profile singularity $HOME/wf-swga/main.nf \
	--outpath $HOME/lepto_swga/swga_results/lepto_human_downsample${N_LINES} \
	--target $HOME/lepto_swga/target_lepto.fasta \
	--background $HOME/lepto_swga/background_human.fasta \
	--downsample $N_LINES
