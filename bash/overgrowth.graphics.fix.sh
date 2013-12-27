#!/bin/bash


# Fixes the intel integrated graphics problems in Overgrowth
# http://wiki.wolfire.com/index.php/Overgrowth_Linux#Errors_about_GLSL_appear.2C_mentioning_GLSL_versions.
# Edit OGPATH to your install path if you did a non steam install

OGPATH=$HOME/.steam/steam/SteamApps/common/Overgrowth/Data/GLSL

for EACH in $(find $OGPATH -iname "*.vert" -print -o -iname "*.frag" -print)
do
	cat $EACH > tempfile
	echo "#version 130" > $EACH
	cat tempfile >> $EACH

done

rm tempfile

exit 0
