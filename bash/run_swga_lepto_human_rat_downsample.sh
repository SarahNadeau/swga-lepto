#!/bin/bash -l
#$ -M svu7@cdc.gov
#$ -m ae

N_CHUNKS=100000
CHUNK_SIZE=20000
echo "$N_CHUNKS chunks of length $CHUNK_SIZE used for the human and rat genomes combined"

module load nextflow

mkdir -p $HOME/swga-lepto/swga_results

cat $HOME/swga-lepto/background_human.fasta $HOME/swga-lepto/background_norway_rat.fasta >> \
  $HOME/swga-lepto/background_human_norway_rat.fasta

nextflow run \
	-profile singularity $HOME/wf-swga/main.nf \
	--outpath $HOME/swga-lepto/swga_results/lepto_human_downsample${N_LINES} \
	--target $HOME/swga-lepto/target_lepto.fasta \
	--background $HOME/swga-lepto/background_human_norway_rat.fasta \
	--backgr-chunk-size $CHUNK_SIZE \
	--backgr-n-chunks $N_CHUNKS \
	--max_sets_search 1000
