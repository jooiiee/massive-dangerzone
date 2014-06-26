#!/bin/bash

# Quick and dirty fix to monitor some switches for a lan party in school

trap SIGTERM

while true
do
	for each in $(cat hostlist)
	do
		ping -c 1 $each >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S)"
	done

done
