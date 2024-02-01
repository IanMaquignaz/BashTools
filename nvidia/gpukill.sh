#!/bin/bash

# Get command line arguments
SIGNAL=9
TARGET_ALL=false
OPTIONS=aAs:hH   # -a all, -h help
OPTIND=1 # Holds the number of options parsed by the last call to getopts. Reset in case getopts has been used previously in the shell
while getopts $OPTIONS opt; do
    case "${opt}" in
        a|A) # kill all
            TARGET_ALL=true
            ;;
	s) # kill signal (see kill -l)
	    SIGNAL="$OPTARG"
	    ;;
        \?) # Invalid option
            echo "Invalid option: -$opt" >&2
            exit 1
            ;;
        h|help) # Help
            echo "Need help? There is no help. Read the code."
            exit 0 
            ;;
    esac
done
shift $((OPTIND-1)) # remove options that have already been handled from $@

function _gpu_process_kill {
	local PIDs="$1"
	if [[ -z "$PIDs" ]]; then
		echo -e "\t--> No PIDs to kill.."
	else
		echo -e "\t--> Killing PIDs... $PIDs"
		echo $PIDs | xargs -n1 kill -$SIGNAL
	fi
}


if [[ $TARGET_ALL == true ]]; then
	PIDs=nvidia-smi -q -x | grep pid | sed -e 's/<pid>//g' -e 's/<\/pid>//g' -e 's/^[[:space:]]*//'
else
	for gpuID in "$@"; do
		echo "Purgin processes on GPU:$gpuID"
		PIDs=$(nvidia-smi -i $gpuID -q -x | grep pid | sed -e 's/<pid>//g' -e 's/<\/pid>//g' -e 's/^[[:space:]]*//')	
		_gpu_process_kill $PIDs
	done
fi
echo "Done!"


