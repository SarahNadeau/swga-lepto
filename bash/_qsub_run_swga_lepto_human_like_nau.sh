#!/bin/bash -l

# This script is to run the SWGA software to find primers a la NAU methods used for Cocking et al. 2020.

TARGET_GENOME=$1
WORKDIR=$2

singularity exec $SINGULARITY_CACHEDIR/snads-swga@sha256-776a2988b0ba727efe0b5c1420242c0309cd8e82bff67e9acf98215bf9f1f418.img \
  $HOME/swga-lepto/bash/_score_sets_on_secondary_targets.sh $TARGET_GENOME $WORKDIR