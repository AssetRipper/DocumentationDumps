#!/bin/bash

. $(dirname "$0")/configuration.sh

is_empty_file() {
	size=$(wc -c <"$1")
	if [ $size -gt 0 ]; then
		echo false
	else
		echo true
	fi
}

check_version() {
	if ! [ -d "${path_to_UnityInstallations}/$1" ]; then
		echo $1 needs installed.
	else
		if ! [ -f "$(dirname "$0")/EngineAssets/$1.json" ]; then
			echo $1 needs its engine assets dumped.
		fi
	fi
}

check_early_version() {
	if ! [ -d "${path_to_UnityInstallations}/$1" ]; then
		echo $1 needs installed.
	else
		if ! [ -f "$(dirname "$0")/EngineAssets/$1.json" ]; then
			echo $1 needs its engine assets dumped.
		fi
	fi
}

function check_any_version() {
	if [ ${1:0:2} = "20" ]
	then
	   check_version $1
	elif [ ${1:0:1} = "5" ]
	then
	   check_version $1
	else
		check_early_version $1
	fi
}
