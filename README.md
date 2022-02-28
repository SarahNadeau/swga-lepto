# Lepto SWGA

This repository is to record efforts at primer design for selective whole-genome amplification for pathogenic Leptospira.

It uses the [swga](https://github.com/eclarke/swga) tool implemented in https://github.com/SarahNadeau/wf-swga.

Run swga with various levels of down-sampling* on Aspen:
``` 
# Clone this repository, then:
for d in 100000 1000000 50000000; do 
    qsub bash/run_swga_lepto_human_downsample.sh $d
done
```
*Requires FastA to have one entry and be multi-line, unit of down-sampling is a line in the FastA file

Compress .txt results (trace, primers) from swga for download, including directory structure: 
```
find ./<results_dir> -name "*.txt" | tar -cf swga_results.tar -T -
```