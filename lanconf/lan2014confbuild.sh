#!/bin/bash

# Script that writes a expect script that configures cisco 3500 switches for a lan party in school
# Ports had to be configured one by one and as a good sysadmin, I wasn't taking any of it. 
# Some switches had 24 and some 48 ports, hence $lastport


# trap
trap SIGTERM


# make start of expect file
	
	expect=$(which expect)
	echo "#!$expect" > lan2013conf.exp
	echo "timeout 400" >> lan2013conf.exp

# read starting and ending port

	read -p "hostname:" hostname
	read -p "ip:" ip
	read -p "netmask:" netmask
	read -p "Last port:" lastport
	firstport=3

# create switch loggin

	echo 'send  ""' >> lan2013conf.exp
	echo 'expect ">"' >> lan2013conf.exp
	echo 'send  "en"' >> lan2013conf.exp
	echo 'expect "#"' >> lan2013conf.exp
	echo 'send  "conf t"' >> lan2013conf.exp
	echo 'expect "(config)#"' >> lan2013conf.exp
	echo "send \"hostname $hostname\""  >> lan2013conf.exp
	echo 'expect "(config)#"' >> lan2013conf.exp
	echo 'send "enable secret 5 $1$mERr$mRJN71OixzSS4WDmKbe."'  >> lan2013conf.exp
	echo 'expect "(config)#"' >> lan2013conf.exp
	echo 'send "spa vlan 1"'  >> lan2013conf.exp
	echo 'expect "(config)#"' >> lan2013conf.exp
	echo 'send "spanning-tree mode rapid-pvst"' >> lan2013conf.exp
	echo 'expect "(config)#"' >> lan2013conf.exp
	echo 'send "vlan 1"'  >> lan2013conf.exp
	echo 'expect "(config-vlan)#"' >> lan2013conf.exp
	echo 'send "exit"'  >> lan2013conf.exp
	echo 'expect "(config)#"' >> lan2013conf.exp
	echo 'send "interface vlan 1"'  >> lan2013conf.exp
	echo 'expect "(config-if)#"' >> lan2013conf.exp
	echo "send \"ip add $ip $netmask\""  >> lan2013conf.exp
	echo 'expect "(config-if)#"' >> lan2013conf.exp
	echo 'send "no shut"'  >> lan2013conf.exp
	echo 'expect "(config-if)#"' >> lan2013conf.exp
	echo 'send "exit"'  >> lan2013conf.exp
	echo 'expect "(config)#"' >> lan2013conf.exp
	echo 'send "line console 0"'  >> lan2013conf.exp
	echo 'expect "(config-line)#"' >> lan2013conf.exp
	echo 'send "logging synchronous"'  >> lan2013conf.exp
	echo 'send "exit"'  >> lan2013conf.exp
	echo 'expect "(config)#"' >> lan2013conf.exp
	echo 'send "service password-encryption" "'  >> lan2013conf.exp
	echo 'expect "(config)#"' >> lan2013conf.exp
	echo 'send "line vty 0 15"'  >> lan2013conf.exp
	echo 'expect "(config-line)#"' >> lan2013conf.exp
	echo 'send "password 7 0822455D0A1"'  >> lan2013conf.exp
	echo 'expect "(config-line)#"' >> lan2013conf.exp
	echo 'send "login"'  >> lan2013conf.exp
	echo 'expect "(config-line)#"' >> lan2013conf.exp
	echo 'send "interface fa0/1"'  >> lan2013conf.exp
	echo 'expect "(config-if)#"' >> lan2013conf.exp
	echo 'send "switch mode dynamic auto"'  >> lan2013conf.exp
	echo 'expect "(config-if)#"' >> lan2013conf.exp
	echo 'send "description uplink"'  >> lan2013conf.exp
	echo 'expect "(config-if)#"' >> lan2013conf.exp
	echo 'send "exit"'  >> lan2013conf.exp
	echo 'expect "(config)#"' >> lan2013conf.exp
	echo 'send "interface fa0/2"'  >> lan2013conf.exp
	echo 'expect "(config-if)#"' >> lan2013conf.exp
	echo 'send "switch mode dynamic auto"'  >> lan2013conf.exp
	echo 'expect "(config-if)#"' >> lan2013conf.exp
	echo 'send "description downlink"'  >> lan2013conf.exp
	echo 'expect "(config-if)#"' >> lan2013conf.exp
	echo 'send "exit"'  >> lan2013conf.exp


# create interface config

	port=$firstport

	while [ $port -le $lastport ]
	do
		echo 'expect "(config)#"' >> lan2013conf.exp
		echo "send \"interface fa0/$port\""  >> lan2013conf.exp
		echo 'expect "(config-if)#"' >> lan2013conf.exp
		cat switchport.conf >> lan2013conf.exp
		echo 'send "exit"' >> lan2013conf.exp
		
		port=$[$port + 1]
	done

# Write mem and exit

	echo 'expect "(config)#"' >> lan2013conf.exp
	echo 'send "exit"'  >> lan2013conf.exp
	echo 'expect "#"' >> lan2013conf.exp
	echo 'send "wr mem"' >> lan2013conf.exp
	echo 'expect "#"' >> lan2013conf.exp
	echo 'send "exit"'  >> lan2013conf.exp

# exit script
exit 0
