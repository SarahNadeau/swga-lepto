# This script is to run the SWGA software to generate primer stats for a fixed primer set on new genomes.
# It was run using Docker on Sarah's laptop.

docker pull snads/swga:0.4.4

OUTDIR=results/swga_results_lepto_human_fg_bind_rate0.000025_min_tmp_35/genus_coverage/set_38
mkdir -p $OUTDIR

echo "AACGAATCG
ATTTTACGAAC
CAACAACTCTAA
CGTAAAATCG
CGTCTAACG
TAGGAACTCATA
TCGGAATCG
TTGTAGGAACTA" > $OUTDIR/primers.txt

docker run \
  -it \
  --rm \
  --mount type=bind,src=$PWD/lepto_species_assemblies,dst=/data \
  --mount type=bind,src=$PWD/$OUTDIR,dst=/outdir \
  snads/swga:0.4.4

# These commands were run inside the container in interactive mode

# Iterate through other Lepto species genomes, score set on each one
for FILE in /data/ncbi-genomes-2022-03-09/*.fna.gz; do

  mkdir /tmp
  cd /tmp

  # We don't care about background frequency (already calculated) and don't want to waste time counting more k-mers
  echo ">dummy background genome
  CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC" > background.fasta

  # No exclusionary sequences
  echo ">empty exclude sequence" > exclude.fasta

  FILE_PREFIX="$(basename $FILE .fna.gz)"
  echo "Scoring set on $FILE_PREFIX"
  gunzip -c $FILE > target.fasta

  # Remove any blank lines in target
  awk NF target.fasta >> target.fasta.noblanks

  swga init \
    -f target.fasta.noblanks \
    -b background.fasta \
    -e exclude.fasta

  #swga count \
  #  --input primers.txt
  # CGATTCGT does not exist in foreground genome, skipping...
  # GTTCGTAAA does not exist in foreground genome, skipping...
  # But they do! Can see it with grep!

  # Does a full count catch them? Yes, it does.
  # Try not to waste time by only counting k-mers of same lengths as ones in set
  swga count \
    --min_size 9 \
    --max_size 12

  # Activate the primers and score them as a set
  swga activate \
    --input /outdir/primers.txt
  swga score \
    --input /outdir/primers.txt \
    --force  # don't prompt to add to database

  # By default the first manually added set has ID -1
  swga export sets --id -1 >> /outdir/set_score_$FILE_PREFIX.txt

  rm -r /tmp

done




