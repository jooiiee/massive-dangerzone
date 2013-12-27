#!/bin/bash

# Script that writes a expect that configures cisco 3500 switches for a lan party in school
# Ports had to be configured one by one and as a good sysadmin, I wasnt taking any of it. 
# Some switch had 24 and some 48 ports, hence $lastport


# trap
trap SIGTERM


# make start of expect file
	
	expect=`which expect`
	echo "#!$expect" > switchconf.exp

# read starting and ending port

	read -p "First port:" firstport
	read -p "Last port:" lastport

# create switch loggin

	echo 'send  ""' >> switchconf.exp
	echo "sleep 5" >> switchconf.exp
	echo 'send  ""' >> switchconf.exp
	echo 'expect ">"' >> switchconf.exp
	echo 'send  "en"' >> switchconf.exp
	echo 'expect "#"' >> switchconf.exp
	echo 'send  "conf t"' >> switchconf.exp

# create interface config

	port=$firstport

	while [ $port -le $lastport]
	do
		echo 'expect "(config)#"' >> switchconf.exp
		echo "send \"interface fa0/$port\""  >> switchconf.exp
		echo 'expect "(config-if)#"' >> switchconf.exp
		cat switchport.conf >> switchconf.exp
		echo "exit" >> switchconf.exp
		
		port=$[$port + 1]
	done

# exit script
exit 0
