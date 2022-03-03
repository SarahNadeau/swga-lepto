* [ ] check that primers cover as many of the 545 genes suggested for cgMLST by [Guglielmini et al. 2019](https://doi.org/10.1371/journal.pntd.0007374) as possible
* [ ] and the 7 genes used for traditional MLST (see [Caimi et al. 2017](https://www.sciencedirect.com/science/article/pii/S1567134817302708?via%3Dihub))
* [ ] compare sum of amplicon size from SWGA to sum of amplicon size from traditional (~7 gene) MLST schemes
* [ ] could calculate number of unique (non-overlapping) bases contributed assuming 5kb extension from each predicted touchdown location as in Coxiella paper

General approach
* Developed a method to down-sample FastA files (randomly select some # chunks of some specified size) - useful for testing out resources needed, runtime but messes up the swga algorithm, which needs to know the avg distance between primer binding sites in the genome
* Concatenate multiple target genomes/background genomes (if desired) before inputting to swga
* Workflow has parameters to specify min/max binding rates on target/background genomes - narrow these down so that some smallish number of candidate primers pass, should help the find sets step run faster
* Export sets and set bedfile, use bedfile to assess coverage of loci of interest (e.g. MLST loci)

Questions

* Why would [Guglielmini et al. 2019](https://doi.org/10.1371/journal.pntd.0007374) remove loci from previously defined Leptospira MLST schemes? Seems like these would still be informative.

Points to consider

* Order primers with extra strong bonds on the 3' end to prohibit primer degredation leading to too many matches in background genome(s)
* May want/need to break up or use as exclusion seqs eukaryotic mitochondrial DNA to avoid rolling-circle amplification (?) due to primer match - coxiella paper did this
* What kind of samples are good candidates for rapid genomic diagnostics? Should inform target, background genome choices
* Sequence pre- and post-swga samples in order to assess how successful swga was

Supplies needed

* Primers with 3' end thiophosphate modified to withstand phi29 polymerase
* phi29 polymerase
* restriction endonuclease for mitochondrial DNA?
* A PCR purification kit that can handle really long (ideally >10000pb) amplicons
