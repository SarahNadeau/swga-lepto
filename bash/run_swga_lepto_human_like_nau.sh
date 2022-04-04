#!/bin/bash -l
#$ -M svu7@cdc.gov
#$ -m ae

# This script is to run the SWGA software to find primers a la NAU methods used for Cocking et al. 2020.

module load nextflow

mkdir -p $HOME/swga-lepto/swga_results

# Calculate length of input genomes
TARGET_LEN=$(wc -c $HOME/swga-lepto/target_lepto.fasta | awk '{print $1}')
BACKGR_LEN=$(wc -c $HOME/swga-lepto/background_human.fasta | awk '{print $1}')
echo "Target genome length calculated to be $TARGET_LEN"
echo "Background genome length calculated to be $BACKGR_LEN"

# Run swga to generate 10000 candidate primer sets for a variety of set sizes
# Will evaluate best sets later
for N_PRIMERS in 20 25 30 35 40; do
nextflow run \
  -profile singularity,sge $HOME/wf-swga/main.nf \
  --outpath $HOME/swga-lepto/swga_results/lepto_human_like_nau_${N_PRIMERS}_primers \
  --target $HOME/swga-lepto/target_lepto.fasta \
  --background $HOME/swga-lepto/background_human.fasta \
  --set_find_workers 1 \
  --backgr_length $BACKGR_LEN \
  --target_length $TARGET_LEN \
  --max_sets_search 10000 \
  --find_sets_min_size $N_PRIMERS \
  --find_sets_max_size $N_PRIMERS
done