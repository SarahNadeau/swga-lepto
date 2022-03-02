#!/bin/bash -l
#$ -M svu7@cdc.gov
#$ -m ae

N_SETS_TO_SEARCH=$1  # number of sets swga should consider (-1 means all)
N_WORKERS=4
echo "Limiting swga to evaluating $N_SETS_TO_SEARCH sets with $N_WORKERS workers"

module load nextflow

mkdir -p $HOME/swga-lepto/swga_results

nextflow run \
	-profile singularity $HOME/wf-swga/main.nf \
	--outpath $HOME/swga-lepto/swga_results/lepto_human_sets${N_SETS_TO_SEARCH} \
	--target $HOME/swga-lepto/target_lepto.fasta \
	--background $HOME/swga-lepto/background_human.fasta \
	--max_sets_search $N_SETS_TO_SEARCH \
	--set_find_workers $N_WORKERS
