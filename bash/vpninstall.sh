#!/bin/bash

# A script I wrote to show how another script could be done better. 

#
# Will attempts to install OpenVPN and VPNBook OpenVPN servers on a debian system. 
#

# Check if root
	if [ $(whoami) != "root" ]
		then
		echo "Run as root."
		exit 1
	fi

# Information to user
	echo "** Attempting to install the OpenVPN package and VPNBook OpenVPN servers. **"
	echo "** The following operations requires a network connection. **"
	echo "** A logfile will be avalible after the Installation. **"
	echo

# Prompt user for install location
	unset dir
	read -p "Enter install directory [$HOME/openvpn]:" dir

# Check if $dir exists and assign it to users home folder if not
	if [ $dir == "" ]
		then
		dir=$HOME/openvpn
	fi

# Install openvpn via aptitude
	echo "Installing the OpenVPN package."
	 apt-get install -y openvpn >> openvpninstall.log

# Make files executable
	 chmod +x ./run/VPNBook*.sh >> openvpninstall.log

# Copy files to install directory
	cp ./run/VPNBook*.sh $dir >> openvpninstall.log

# Copy etc files to /etc/
	 cp -r ./etc/* /etc/openvpn/ >> openvpninstall.log

# Ask user if logfile should be saved
	read -n 1 -p "Delete logfile? [Y/n]:" reply

# Delete logfile if $reply is Y/y
	if [ $reply == "{y|Y}" ]
	then
		rm openvpninstall.log
	else
		echo "Logfile is avalible at $(pwd)/openvpninstall.log"

	fi

# Prompt user for quit
	echo "Installation complete, press any key to exit."
	read -s -n 1 reply
