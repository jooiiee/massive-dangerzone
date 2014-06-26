#!/bin/bash

# Will prepare map files for source fastdl servers
# This script is dumb as fuck but gets the job done

trap SIGTERM


mkdir /tmp/css
mkdir /tmp/css/cstrike
mkdir /tmp/css/cstrike/maps

echo "Move your files to the /tmp/css/cstrike folder"
read -p "Press any key to continue" -n 1 NULL


cd /tmp/css/

for each in $(find /tmp/css/cstrike/maps -name *.bsp)
do
	bzip2 -k -z $each
done


zip -r cstrike cstrike

ls /tmp/css/cstrike/maps/ | grep -i  .bsp$ > /tmp/css/maplist.txt
ls /tmp/css/cstrike/maps/ | grep -i  .bsp$ | cut -d'.' --complement -f2- > /tmp/css/maplistnobsp.txt
