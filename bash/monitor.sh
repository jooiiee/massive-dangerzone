#!/bin/bash

# Monitors network connection

trap SIGTERM

host=8.8.8.8
logfile=/var/log/ping

function networktest {
	ping -c 1 $host > /dev/null
}

function response {

	notify-send -u critical "Network down!" "Ping to $host failed 3 times. Incident logged in $logfile"
	
	 echo "PING to $host failed at $(date "+%b %d %T")" >> $logfile
		 if [[ $? != 0 ]]; then
			echo "Critical error! Could not write log!" 
			exit 1
		fi
}

while true
do
	trap SIGTERM

	networktest || networktest || networktest || response
done
