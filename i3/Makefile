source_mappings=mappings
source_config=config.raw

dest_path=~/.config/i3
dest_file=config

all: ${source_config} ${source_mappings}
	config-parse ${source_config} ${source_mappings} > .out

install: .out
	mkdir -p ${dest_path}
	rm -rf ${dest_path}/${dest_file}
	mv .out ${dest_path}/${dest_file}
