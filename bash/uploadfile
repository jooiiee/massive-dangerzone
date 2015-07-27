#!/bin/bash

# Simple script to upload file to server web via rsync

# uploadfiles FILE [FILENAME]

# First argument is file to be uploaded, second argument is new filename. 


# Variables

prefix=http://network.jooiiee.se/files/
host=192.168.1.105
directory=/var/www/files/
user=johan
tempdirectory=/tmp/uploadfiles/

if [[ -z "$1" ]]
	then
	echo "uploadfiles: missing operand"
	echo "usage: uploadfiles FILE... [FILENAME]... "
	exit 1
fi

if [[ -z "$2" ]]
	then
		mkdir $tempdirectory
		cp $1 $tempdirectory$2
		rsync -av $tempdirectory$2 $user@$host:$directory
	else
		rsync -av $1 $user@$host:$directory
fi


echo -n $prefix
echo $1 | awk -F/ '{print $(NF)}'


exit 0
