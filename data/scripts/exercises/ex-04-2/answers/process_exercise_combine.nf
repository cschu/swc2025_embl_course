#!/usr/bin/env nextflow

params.chr = "A"
params.transcriptome = "${projectDir}/data/yeast/s_cerevisiae_transcriptome.fa.gz"


process CHR_COUNT {

input:
	path(transcriptome)
	val(chr)

script:
	"""
	printf  'Number of sequences for chromosome '${chr}':'
	zgrep  -c '^>Y'${chr} ${transcriptome}
	"""
}


workflow {

	transcriptome_ch = channel.fromPath(params.transcriptome)
	chr_ch = channel.of(params.chr)

	CHR_COUNT(transcriptome_ch, chr_ch)

}
