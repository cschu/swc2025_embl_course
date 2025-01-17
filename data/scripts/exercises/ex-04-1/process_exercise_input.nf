params.chr = "A"
params.transcriptome = "${projectDir}/data/yeast/s_cerevisiae_transcriptome.fa.gz"
process CHR_COUNT {

script:
	"""
	printf  'Number of sequences for chromosome '${params.chr}':'
	zgrep  -c '^>Y'${params.chr} ${params.transcriptome}
	"""
}

workflow {
	CHR_COUNT()
}