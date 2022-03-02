# Lepto SWGA

This repository is to record efforts at primer design for selective whole-genome amplification for pathogenic Leptospira.

It uses the [swga](https://github.com/eclarke/swga) tool implemented in https://github.com/SarahNadeau/wf-swga.

Clone repo
```
git clone git@github.com:SarahNadeau/swga-lepto.git
```

Get data
```
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/014/858/895/GCF_014858895.1_ASM1485889v1/GCF_014858895.1_ASM1485889v1_genomic.fna.gz -O swga-lepto/target_lepto.fasta.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.29_GRCh38.p14/GCA_000001405.29_GRCh38.p14_genomic.fna.gz -O swga-lepto/background_human.fasta.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/015/227/675/GCF_015227675.2_mRatBN7.2/GCF_015227675.2_mRatBN7.2_genomic.fna.gz -O swga-lepto/background_norway_rat.fasta.gz
gunzip swga-lepto/*.gz
```

Run swga with various levels of down-sampling* for lepto/human on Aspen:
``` 
for n in 10 100 1000 10000 100000 1000000 5000000; do 
    qsub swga-lepto/bash/run_swga_lepto_human_downsample.sh $n
done
```
*Unit of down-sampling is 80bp chunks

Run swga searching different numbers of total sets before reporting best found
``` 
for n in 10000 1000000 5000000; do 
    qsub swga-lepto/bash/run_swga_lepto_human_whole_genome.sh $n
done
```
Run swga with human and Norway rat background sequences down-sampled to a little less than half their combined lengths, search some small number of sets
```
qsub swga-lepto/bash/run_swga_lepto_human_rat_downsample.sh
```

Compress .txt results (trace, primers) from swga for download, including directory structure: 
```
find swga-lepto/swga_results -name "*.txt" | tar -cf swga_results.tar -T -
```
