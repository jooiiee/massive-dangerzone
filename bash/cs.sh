#!/bin/bash

# I have no idea why I wrote this


# read -p "encrypt" $string

key=ETAOINSHRDLUBCFGJMQPVWZYXK
keylow=etaoinshrdlubcfgjmqpvwzyxk

echo
echo


#echo $1 | tr "$key" "A-Z" | tr "$keylow" "a-z" 
echo $1 | tr "A-Z" "$key" | tr "a-z" "$keylow" 
