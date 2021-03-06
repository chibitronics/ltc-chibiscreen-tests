#!/bin/sh -e

source ./00-test-lib.sh

# Export all pins so that we can use them
for pin in ${all_pins}
do
	export_pin ${pin}
done

# Set up UART to 9600 baud
stty -F ${uart} ${baud} -icrnl -imaxbel -opost -onlcr -isig -icanon -echo

# Start out by setting all pins low.
# The bootloader does this, so we're not
# really fighting it here.
set_output 0
set_output 1
set_output 2
set_output 3
set_output 4
set_output 5
set_low 0
set_low 1
set_low 2
set_low 3
set_low 4
set_low 5
set_input ${status_green}
set_input ${status_red}
#set_input ${reset_level}

echo "Test jig configured"
