#!/bin/bash -l

# This wrapper script is to call a script to run the SWGA software to score primer sets on secondary target genomes.

WORKDIR=$HOME/swga-lepto/swga_results/like_nau_try_2

export TMPDIR=$HOME/tmp
export SINGULARITY_CACHEDIR=/scicomp/scratch/$USER/singularity.cache

# Iterate through other Lepto species genomes, score set on each one
for TARGET_GENOME in $HOME/swga-lepto/lepto_species_assemblies/ncbi-genomes-2022-03-09/*.fna.gz; do

  # Submit job
  qsub \
    -N score_sets \
    $HOME/swga-lepto/bash/_qsub_run_swga_lepto_human_like_nau.sh $TARGET_GENOME $WORKDIR

done




