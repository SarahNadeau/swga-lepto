#!/usr/bin/env nextflow


/*
==============================================================================
                              wf-dsk
==============================================================================
*/

version = "1.0.0"
nextflow.enable.dsl=2

/*
==============================================================================
                            Run the main workflow
==============================================================================
*/

workflow {

    params.infile = ""  // must be provided on the command line
    params.outpath = ""  // must be provided on the command line
    params.k = 7

    infile = Channel.fromPath(params.infile, checkIfExists: true)

    process RUN_DSK {
        cpus 8
        memory '64 GB'
        publishDir "${params.outpath}", mode: "copy"
        container "snads/dsk:0.0.100"

        input:
            path(infile)

        output:
            path("${params.k}mers.h5")
            path("${params.k}mers.txt")

        script:
        """
        dsk \
            -nb-cores 8 \
            -file ${params.infile} \
            -kmer-size ${params.k} \
            -out ${params.k}mers.h5

        dsk2ascii \
            -file ${params.k}mers.h5 \
            -out ${params.k}mers.txt
        """
    }

}
