#!/usr/bin/env nextflow

ids = ['ERR908507', 'ERR908506', 'ERR908505']


workflow {

	value_ch = channel.value(ids).view()
	queue_ch = channel.fromList(ids).view()

}
