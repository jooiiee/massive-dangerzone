#!/bin/bash

# Quick and dirty fix to monitor some switches for a lan party in school

trap SIGTERM

while true
do

	switch=switch1
	ping -c 1 172.20.1.1 >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S) $(date +%H:%M:%S)"

	switch=switch2
	ping -c 1 172.20.1.2 >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S)"

	switch=switch2
	ping -c 1 172.20.1.2 >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S)"

	switch=switch3
	ping -c 1 172.20.1.3 >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S)"

	switch=switch4
	ping -c 1 172.20.1.4 >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S)"

	switch=switch5
	ping -c 1 172.20.1.5 >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S)"

	switch=switch6
	ping -c 1 172.20.1.6 >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S)"

	switch=switch7
	ping -c 1 172.20.1.7 >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S)"

	switch=switch8
	ping -c 1 172.20.1.8 >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S)"

	switch=switch9
	ping -c 1 172.20.1.9 >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S)"

	# switch=psuedoswitch
	# ping -c 1 172.20.1.10 >> /dev/null || echo "$switch is down!!! $(date +%H:%M:%S)"

done
