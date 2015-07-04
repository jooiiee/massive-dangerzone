#!/bin/bash

# Simple script to snap and upload a screenshot to server web via rsync


# Variables

# The prefix of the link you will send people
prefix=http://jooiiee.se/files/
# The server that your client will connect to
host=192.168.1.105
# The directory on the server that the file will be uploaded to
directory=/var/www/files/
# The user used for connecting
user=johan

# Naming of screenshots
filename=/tmp/Screenshot$(date +%x_%X).png
basefilename=$(basename $filename)

# The actuall screenshot function
gnome-screenshot -f $filename
# Uploading to server
rsync -av $filename $user@$host:$directory

# Copying the link
echo $prefix$basefilename | xclip -selection c

exit 0
