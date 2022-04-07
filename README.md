# Lepto SWGA

This repository is to record efforts at primer design for selective whole-genome amplification for Leptospira.

It uses the [swga](https://github.com/eclarke/swga) tool, called by the Nextflow workflow https://github.com/SarahNadeau/wf-swga.
It was run on a Univa Grid Engine cluster and thus relies on the `qsub` command in scripts.

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

Run swga a la NAU (Cocking et al. 2020) - swga is run independently for different set sizes. 
This reduces the set search space within each run sufficiently to get results out.
```
bash swga-lepto/bash/run_swga_lepto_human_like_nau.sh
```

Compress .txt results (trace, primers) from swga for download, including directory structure: 
```
find swga-lepto/swga_results -name "*.txt" | tar -cf swga_results.tar -T -
```

Get binding frequency of candidate sets in other Lepto species genomes:
```
bash swga-lepto/bash/score_sets_on_secondary_targets.sh
```
Evaluate candidate primer sets, generate figures:
* `R/get_top_3_distinct_sets.R` takes the sets output of the swga program and returns the top 3 high-scoring sets that are at least 30% unique
* `R/get_top_set_binding_sites.R` takes the sets_to_score.txt output of R/get_top_3_distinct_sets.R and returns target genome binding sites of the sets
* `R/assess_coverage.rmd` assesses candidate primer sets for target genome MLST loci coverage
* `R/genus_coverage.rmd` assesses candidate primer sets for coverage of other Lepto species genomes

Final results are in:
* `swga_results/like_nau_try_2` for primer melting temps 30-42 degree C, targeted for EquiPhi29 polymerase
* `swga_results/like_nau_try_3` for primer melting temps 18-30 degree C, targeted for Phi29 polymerase
