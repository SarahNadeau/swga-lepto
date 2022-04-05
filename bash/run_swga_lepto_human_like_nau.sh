#!/bin/bash -l

# This wrapper script is to call a script to run the SWGA software to find primers a la NAU methods used for Cocking et al. 2020.

# Run swga to generate primer sets for a variety of set sizes
# Will evaluate best sets later
for N_PRIMERS in 9; do
  qsub \
    -N lepto_human_like_nau_${N_PRIMERS}_primers_18_minTm_30_maxTm \
    $HOME/swga-lepto/bash/_run_swga_lepto_human_like_nau.sh $N_PRIMERS 18 30
#  qsub \
#    -N lepto_human_like_nau_${N_PRIMERS}_primers_30_minTm_42_maxTm \
#    $HOME/swga-lepto/bash/_run_swga_lepto_human_like_nau.sh $N_PRIMERS 30 42
done