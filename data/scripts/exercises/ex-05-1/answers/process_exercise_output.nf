process EXTRACT_IDS {
  input:
	path transcriptome
	each chr

	//add output block here to capture the file "${chr}_seqids.txt"
  output:
	path "*_seqids.txt"

  script:
	"""
	zgrep '^>Y'$chr $transcriptome > ${chr}_seqids.txt
	"""
}

transcriptome_ch = channel.fromPath("${projectDir}/data/yeast/s_cerevisiae_transcriptome.fa.gz")
chr_ch = channel.of('A'..'P')

workflow {
  EXTRACT_IDS(transcriptome_ch, chr_ch)
  EXTRACT_IDS.out.view()
}