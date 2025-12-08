#!/bin/bash

LOG="$1"
IOC="$2"

> /etc/tmp/report.txt

grep-Ff "$IOC" "$LOG" \
| awk '{print $1, $4$5, $7}' \
| sed 's/\[//g; s/\]//g' \
>> /etc/tmp/report.txt

# run as bash /etc/tnp/finalc2.bash /etc/tmp/IOC.txt /etc/tmp/access.log
