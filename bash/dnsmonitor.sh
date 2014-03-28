#!/bin/bash

# I got tired of waiting for DNS propogation, so I wrote this quick script to monitor it and use the notify-send function to tell me about it. 
# There is no syntax checking, run it with the domain as argument 1 and the new ip as argument 2. 

	while true
	do

		ip=$(host -t a $1 | cut -f 4 -d ' ')

		if [ $ip == $2 ]

		then 
			notify-send "DNS change done" "The DNS change is now complete, $1 now points to $2"
			play /usr/share/sounds/ubuntu/stereo/dialog-question.ogg
			exit 0
		fi
	done

exit 1
