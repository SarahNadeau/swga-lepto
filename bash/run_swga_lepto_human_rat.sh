#!/bin/bash -l
#$ -M svu7@cdc.gov
#$ -m ae

module load nextflow

mkdir -p $HOME/swga-lepto/swga_results

cat $HOME/swga-lepto/background_human.fasta $HOME/swga-lepto/background_norway_rat.fasta >> \
  $HOME/swga-lepto/background_human_norway_rat.fasta

# Calculate length of input genomes
TARGET_LEN=$(wc -c $HOME/swga-lepto/target_lepto.fasta | awk '{print $1}')
BACKGR_LEN=$(wc -c $HOME/swga-lepto/background_human_norway_rat.fasta | awk '{print $1}')
echo "Target genome length calculated to be $TARGET_LEN"
echo "Background genome length calculated to be $BACKGR_LEN"

nextflow run \
        -profile singularity $HOME/wf-swga/main.nf \
        --outpath $HOME/swga-lepto/swga_results/lepto_human_rat_no_downsample_fg_bind_rate0.00005 \
        --target $HOME/swga-lepto/target_lepto.fasta \
        --background $HOME/swga-lepto/background_human_norway_rat.fasta \
        --set_find_workers 4 \
        --max_bg_bind_rate 0.000005 \
        --min_fg_bind_rate 0.00005 \
        --backgr_length $BACKGR_LEN \
        --target_length $TARGET_LEN