source_mappings=mappings
source_config=config.raw

dest_path=~/.config/i3
dest_file=config

config: ${source_config} ${source_mappings}
	mkdir -p ${dest_path}
	rm -rf ${dest_path}/${dest_file}
	config-parse ${source_config} ${source_mappings} > ${dest_path}/${dest_file}
