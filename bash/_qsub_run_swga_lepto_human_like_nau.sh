#!/bin/bash -l

# This script is to run the SWGA software to find primers a la NAU methods used for Cocking et al. 2020.

TARGET_GENOME=$1
WORKDIR=$2

singularity exec docker://snads/swga:0.4.4 $HOME/swga-lepto/bash/_score_sets_on_secondary_targets.sh $TARGET_GENOME $WORKDIR