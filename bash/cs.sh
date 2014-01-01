#!/bin/bash

# I have no idea why I wrote this


read -p "Decrypt: " string

#key=ZABCDEFGHIJKLMNOPQRSTUVWXY
#keylow=zabcdefghijklmnopqrstuvwxy

# key=VWXYZABCDEFGHIJKLMNOPQRSTU
# keylow=vwxyzabcdefghijklmnopqrstuvwxyz

key=YZABCDEFGHIJKLMNOPQRSTUVWX
keylow=yzabcdefghijklmnopqrstuvwx

#echo $1 | tr "$key" "A-Z" | tr "$keylow" "a-z" 
echo $string | tr "A-Z" "$key" | tr "a-z" "$keylow" 
