#!/bin/bash

# Simple script to snap and upload a screenshot to server web via rsync


# Variables

prefix=http://jooiiee.se/files/
host=192.168.1.105
directory=/var/www/files/
user=johan


filename=/tmp/Screenshot$(date +%x_%X).png
basefilename=$(basename $filename)

gnome-screenshot -f $filename
rsync -av $filename $user@$host:$directory

echo $prefix$basefilename | xclip -selection c

exit 0
