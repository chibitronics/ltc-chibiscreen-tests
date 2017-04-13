#!/bin/sh -e
max=3

source ./00-test-lib.sh

for i in $(seq 1 ${max})
do
    echo "resetting to extract verison string"
    echo "reset" | ncat localhost 4444 > /dev/null
    
    if timeout 3 grep -q "Chibiscreen build 873000deb3bb06d64056db415f51ee53a24b6b76" ${uart}
    then
	echo q > ${uart}
	echo "Version OK"
	exit 0
    fi
    echo "Timed out, trying again..."
done

echo "Failed to get correct version."
exit 1
