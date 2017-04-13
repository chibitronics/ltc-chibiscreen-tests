#!/bin/sh -e
max=3

source ./00-test-lib.sh

for i in $(seq 1 ${max})
do
    echo "resetting"
    echo "reset" | ncat localhost 4444 > /dev/null

    echo "Waiting for banner..."
	wait_for_banner

	sleep 1 # in case the system needs a little time from boot to waiting for input

	echo "Serial test:"
	echo "    Sending"
	echo '#VER' > ${uart}  # initiate manual test with call to #VER
	
	# Check to see if serial is working.  Look for the string
	# 'LTC factory test is running', and echo back 'q'.
	echo "Waiting for manual test to complete:"
	if timeout 120 grep -q "PASS" ${uart}
	then
		echo q > ${uart}
		echo "Serial OK"
		exit 0
	fi
	echo "Timed out, trying again..."
done

echo "Failed to talk to serial port."
exit 1
