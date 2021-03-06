#!/bin/bash -l

# This script is to run the SWGA software to score a primer set on a secondary target genome.

TARGET_GENOME=$1
WORKDIR=$2

for PRIMER_FILE in $WORKDIR/set_to_score_size_*_idx_*_primers.txt; do

  # Define job-specific outfile
  TARGET_PREFIX="$(basename $TARGET_GENOME .fna.gz)"
  PRIMER_PREFIX="$(basename $PRIMER_FILE _primers.txt)"
  OUTFILE=$WORKDIR/${PRIMER_PREFIX}__${TARGET_PREFIX}.txt

  # Remove any blank lines in target
  TMPDIR=swga_tmpdir_$RANDOM
  echo "TMPDIR: $TMPDIR"
  mkdir -p $TMPDIR && cd $TMPDIR

  gunzip -c $TARGET_GENOME > target.fasta
  awk NF target.fasta >> target.fasta.noblanks

  # We don't care about background frequency (already calculated) and don't want to waste time counting more k-mers
  echo ">dummy background genome
  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC" > background.fasta

  # No exclusionary sequences
  echo ">empty exclude sequence" > exclude.fasta

  swga init \
    -f target.fasta.noblanks \
    -b background.fasta \
    -e exclude.fasta

  # Count kmers
  swga count

  # Activate the primers and score them as a set
  swga activate \
    --input $PRIMER_FILE
  swga score \
    --input $PRIMER_FILE \
    --force  # don't prompt to add to database

  # By default the first manually added set has ID -1
  swga export sets --id -1 >> $OUTFILE

  cd ../
  rm -r $TMPDIR

done



