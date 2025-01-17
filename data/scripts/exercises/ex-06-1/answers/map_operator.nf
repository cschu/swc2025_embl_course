workflow {
	channel
 		.fromPath( 'data/yeast/reads/*.fq.gz' )
		.map { file -> [file.getName(), file] }
 		.view()
}
