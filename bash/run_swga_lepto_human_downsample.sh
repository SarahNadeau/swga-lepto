#!/bin/bash -l
#$ -M svu7@cdc.gov
#$ -m ae

N_LINES=$1
CHUNK_SIZE=80  # number of lines in a row of the FastA file
echo "$N_LINES chunks of lenth $CHUNK_SIZE used"

module load nextflow

mkdir -p $HOME/swga_lepto/swga_results

nextflow run \
	-profile singularity $HOME/wf-swga/main.nf \
	--outpath $HOME/swga_lepto/swga_results/lepto_human_downsample${N_LINES} \
	--target $HOME/swga_lepto/target_lepto.fasta \
	--background $HOME/swga_lepto/background_human.fasta \
	--target-chunk-size $CHUNK_SIZE \
	--backgr-chunk-size $CHUNK_SIZE \
	--target-n-chunks $N_LINES \
	--backgr-n-chunks $N_LINES
