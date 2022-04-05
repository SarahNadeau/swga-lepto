#!/bin/bash -l

# This script is to run the SWGA software to find primers a la NAU methods used for Cocking et al. 2020.

PRIMER_FILE=$1
TARGET_GENOME=$2
OUTFILE=$3

singularity exec docker://snads/swga:0.4.4 $HOME/swga-lepto/bash/_score_sets_on_secondary_targets.sh $PRIMER_FILE $TARGET_GENOME $OUTFILE