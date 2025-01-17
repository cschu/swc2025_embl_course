 process calculate_statistic {
    publishDir "${params.output_dir}/stats", mode: "copy"
    tag "${data.getSimpleName()}-${which_stat}"

    input:
    tuple val(which_stat), path(data)

    output:
    tuple val(which_stat), path("*_${which_stat}.txt"), emit: "stat"

    script:
    
    fn = data.name

    """
    calc_stats.py --${which_stat} ${data} > ${fn}_${which_stat}.txt
    """

}


process collate_statistic {
    publishDir "${params.output_dir}/collated", mode: "copy"
    tag "${which_stat}"

    input:
    tuple val(which_stat), path(data)

    output:
    tuple val(which_stat), path("*.collated.txt")

    script:
    
    """
    ls ${data} | cut -f 1 -d . | tr "\\n" "\\t" | sed "s/\$/\\n/" > ${which_stat}.collated.txt
    paste ${data} >> ${which_stat}.collated.txt
    """


}

workflow {
    which_stat_ch = Channel.of(params.which_stat.split(","))
        .filter { it == "max" || it == "min" || it == "mean" }
    
    input_ch = Channel.fromPath(params.input_data)
    
    calculations_ch = which_stat_ch.combine(input_ch)
    
    stats_ch = calculate_statistic(calculations_ch).stat
    
    collate_input_ch = stats_ch.groupTuple(by: 0)
    
    collated_ch = collate_statistic(collate_input_ch)
}

workflow.onComplete {
    log.info ( workflow.success ? "\nDone! Your results are in ${params.output_dir}/collated\n" : "Oops .. something went wrong" )
}
