#!/bin/bash

. $(dirname "$0")/configuration.sh

if [ -f "${path_to_EngineFileExtractor}" ]; then
	echo EngineFileExtractor Exists
else
	echo EngineFileExtractor doesnt exist
fi
if [ -d "${path_to_UnityInstallations}" ]; then
	echo Unity Folder Exists
else
	echo Unity Folder doesnt exist
fi


function make_directories() {
	mkdir -p "$(dirname "$0")/EngineAssets"
}

function dump_engine_assets() {
	if [ $# = 0 ]
	then
		echo At least one argument required
		exit 2
	elif [ $# = 1 ]
	then
		force_dump=false
	elif [ $2 = "-f" ] || [ $2 = "--force" ]
	then
		force_dump=true
	else
		force_dump=false
	fi

	if [ -d "${path_to_UnityInstallations}/$1" ]; then
		if [ $force_dump = false ] && [ -f "$(dirname "$0")/EngineAssets/$1.json" ]; then
			echo Already Dumped $1
		else
			echo Dumping $1...
			rm -f ${path_to_EngineAssetsJson}
			"${path_to_EngineFileExtractor}" "`wslpath -w ${path_to_UnityInstallations}`"/$1 --silent
			cp ${path_to_EngineAssetsJson} $(dirname "$0")/EngineAssets/$1.json
		fi
	else
		echo Unity $1 missing, skipped
	fi
}

# Make Directories
echo Making Directories
make_directories