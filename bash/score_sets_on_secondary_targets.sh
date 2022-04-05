#!/bin/bash -l

# This wrapper script is to call a script to run the SWGA software to score primer sets on secondary target genomes.

WORKDIR=$HOME/swga-lepto/swga_results/like_nau_try_2

export TMPDIR=$HOME/tmp
export SINGULARITY_CACHEDIR=/scicomp/scratch/$USER/singularity.cache

# Iterate through other Lepto species genomes, score set on each one
for TARGET_GENOME in $HOME/swga-lepto/lepto_species_assemblies/ncbi-genomes-2022-03-09/*.fna.gz; do
  for PRIMER_FILE in $WORKDIR/set_to_score_size_*_idx_*_primers.txt; do

    # Define job-specific outfile
    TARGET_PREFIX="$(basename $TARGET_GENOME .fna.gz)"
    PRIMER_PREFIX="$(basename $PRIMER_FILE _primers.txt)"
    OUTFILE=$WORKDIR/${PRIMER_PREFIX}__${TARGET_PREFIX}.txt

    # Submit job
    qsub \
      -N score_sets \
      $HOME/swga-lepto/bash/_qsub_run_swga_lepto_human_like_nau.sh $PRIMER_FILE $TARGET_GENOME $OUTFILE

  done
done




