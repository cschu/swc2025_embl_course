#!/usr/bin/env nextflow


workflow {

	value_ch = channel.value("GRCh38").view()
	queue_ch = channel.of(1..4).view()

}
