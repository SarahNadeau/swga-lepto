# Lepto SWGA

This repository is to record efforts at primer design for selective whole-genome amplification for pathogenic Leptospira.

It uses the [swga](https://github.com/eclarke/swga) tool implemented in https://github.com/SarahNadeau/wf-swga.

Get data
```
mkdir $HOME/lepto_swga
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/014/858/895/GCF_014858895.1_ASM1485889v1/GCF_014858895.1_ASM1485889v1_genomic.fna.gz -O $HOME/lepto_swga/target_lepto.fasta.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCA/000/001/405/GCA_000001405.29_GRCh38.p14/GCA_000001405.29_GRCh38.p14_genomic.fna.gz -O $HOME/lepto_swga/background_human.fasta.gz
wget https://ftp.ncbi.nlm.nih.gov/genomes/all/GCF/015/227/675/GCF_015227675.2_mRatBN7.2/GCF_015227675.2_mRatBN7.2_genomic.fna.gz -O $HOME/lepto_swga/background_norway_rat.fasta.gz
gunzip $HOME/lepto_swga/*.gz
```

Run swga with various levels of down-sampling* for lepto/human on Aspen:
``` 
git clone git@github.com:SarahNadeau/swga-lepto.git
for d in 100000 1000000 50000000; do 
    qsub swga-lepto/bash/run_swga_lepto_human_downsample.sh $d
done
```
*Requires FastA to have one entry and be multi-line, unit of down-sampling is a line in the FastA file

Compress .txt results (trace, primers) from swga for download, including directory structure: 
```
find ./<results_dir> -name "*.txt" | tar -cf swga_results.tar -T -
```