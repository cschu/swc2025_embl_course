#!/usr/bin/env nextflow



/*
========================================================================================
    Workflow parameters are written as params.<parameter>
    and can be initialised using the `=` operator.
========================================================================================
*/

params.input = "data/yeast/reads/ref1_1.fq.gz"

/*
========================================================================================
    Input data is received through channels
========================================================================================
*/

input_ch = Channel.fromPath(params.input)


/*
========================================================================================
    A Nextflow process block.
========================================================================================
*/
process count_lines {

    input:
    path read

    output:
    stdout

    script:
    """
    # Print file name
    printf '${read}\\t'

    # Unzip file and count number of lines
    gunzip -c ${read} | wc -l
    """
}



/*
========================================================================================
   Main Workflow
========================================================================================
*/

workflow {
    //  The process to execute is called by its process name, and input is provided between brackets.
    count_lines(input_ch)

    /*  Process output is accessed using the `out` channel.
        The channel operator view() is used to print process output to the terminal. */
    count_lines.out.view()

}
