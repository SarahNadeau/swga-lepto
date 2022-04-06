#!/bin/bash -l

# This wrapper script is to call a script to run the SWGA software to score primer sets on secondary target genomes.

WORKDIR=$1

# Iterate through other Lepto species genomes, score set on each one
for TARGET_GENOME in $HOME/swga-lepto/lepto_species_assemblies/ncbi-genomes-2022-03-09/GCF_006874765.1_ASM687476v1_genomic.fna.gz $HOME/swga-lepto/lepto_species_assemblies/ncbi-genomes-2022-03-09/GCF_016919165.1_ASM1691916v1_genomic.fna.gz; do

  # Submit job
  qsub \
    -N score_sets \
    $HOME/swga-lepto/bash/_qsub_run_swga_lepto_human_like_nau.sh $TARGET_GENOME $WORKDIR

done




