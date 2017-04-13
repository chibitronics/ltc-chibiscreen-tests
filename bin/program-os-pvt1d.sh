#!/bin/sh
max=5
for i in $(seq 1 5)
do
	echo "Programming test OS (try ${i}/${max})"
	echo "resetting"
	echo "reset" | ncat localhost 4444 > /dev/null
	echo "halting"
	echo "halt" | ncat localhost 4444 > /dev/null
	echo "sending program to openocd"
	if echo program $(pwd)/chibiscreen-os-pvt1d.elf | ncat localhost 4444 | grep -q "Programming Finished" 2> /dev/null
	then
		echo "Programmed successfully"
		exit 0
	fi
	echo "Failed to program.  Trying a mass_erase"

	# This sleep seems required, otherwise it will fail if called
	# immediately after a "program" has failed.
#	sleep .5
	echo "kinetis mdm mass_erase" | ncat localhost 4444 > /dev/null
#	echo "Failed to program."
done

echo "Failed to program OS after ${max} tries"
exit 1
