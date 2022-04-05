# This script is to run the DSK software to count 7- and 8-mers in the Lepto and human genomes.
# It uses this information to calculate a bias ratio to find the most selective primers for SWGA.
# It follows the method used by Mark from DBD (publication in press).
# It was run using Docker on Sarah's laptop.

docker pull snads/dsk:0.0.100

OUTDIR=results/dsk_lepto_human
mkdir $OUTDIR

docker run \
  --rm \
  -it \
  --mount type=bind,src=$PWD/target_lepto.fasta.gz,dst=/data/target_lepto.fasta.gz \
  --mount type=bind,src=$PWD/background_human.fasta,dst=/data/background_human.fasta \
  --mount type=bind,src=$PWD/$OUTDIR,dst=/outdir \
  snads/dsk:0.0.100

# These commands were run inside the container in interactive mode

gunzip /data/target_lepto.fasta.gz

# count kmers for lepto
for k in 7 8; do
  dsk \
    -nb-cores 3 \
    -file /data/target_lepto.fasta \
    -kmer-size ${k} \
    -out /outdir/target_lepto_${k}mers.h5

  dsk2ascii \
    -file /outdir/target_lepto_${k}mers.h5 \
    -out /outdir/target_lepto_${k}mers.txt
done

# count kmers for human
# this was estimated to take 90min for pass 1/2 on my laptop. Killed it, running on Aspen instead.
# using workflow in nextflow/dsk.nf this took ~3min for each k-mer size (requested 8 cores, 16GB memory)
for k in 7 8; do
  dsk \
    -nb-cores 3 \
    -file /data/background_human.fasta \
    -kmer-size ${k} \
    -out /outdir/background_human_${k}mers.h5

  dsk2ascii \
    -file /outdir/background_human_${k}mers.h5 \
    -out /outdir/background_human_${k}mers.txt
done
