#!/bin/bash

. $(dirname "$0")/configuration.sh

vers=($(./get_unity_versions.sh | sed s/a/.a./g | sed s/b/.b./g | sed s/f/.f./g | sed s/p/.p./g | sort -t. -k1,1n -k2,2n -k3,3n -k4,4d -k5,5n | sed s/.a./a/g | sed s/.b./b/g | sed s/.f./f/g | sed s/.p./p/g))

# First argument is the file
# Second argument is the reference script
# Third argument is the command to be used on each version
function generate() {
	echo "#!/bin/bash" > "$1"
	echo ". \$(dirname \"\$0\")/$2" >> "$1"
	for ((i=0; i<${#vers[@]}; i++)); 
	do
		echo "$3 ${vers[i]}" >> "$1"
	done
}

# First argument is the file
# Second argument is the reference script
# Third argument is the command to be used on each version
function generate_forced() {
	echo "#!/bin/bash" > "$1"
	echo ". \$(dirname \"\$0\")/$2" >> "$1"
	for ((i=0; i<${#vers[@]}; i++)); 
	do
		echo "$3 ${vers[i]} --force" >> "$1"
	done
}

generate check_all.sh check_functions.sh check_any_version

generate dump_all_engine_assets.sh dump_engine_assets_functions.sh dump_engine_assets

generate install_all.sh install_functions.sh extract

generate_forced dump_all_engine_assets_forced.sh dump_engine_assets_functions.sh dump_engine_assets

generate_forced install_all_forced.sh install_functions.sh extract