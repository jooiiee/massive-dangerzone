#!/bin/bash

# Runs a simple wordpress backup from sql and /var/www/html with no generation handeling
# Todo: Add generation handling based on backup dir size and backup failed alerts. 

# root check
if [ $(whoami) != root ] 
then
	echo "Need to be root"
	exit 1
fi

# Check if backup dir exists
# May need to be disabled if backup location os not on root partition
if [ -d /var/backup ]
then
	:
else
	mkdir /var/backup
fi

# Sql backup and compression to /var/backup
sqldump -u backup --password=$(cat /root/backuppassword) | tar -cpzf /var/backup/sql-$(date +%Y-%m-%d).tar.gz

# www folder backup and compression to /var/backup
tar -cpzf /var/backup/www-$(date +%Y-%m-%d).tar.gz /var/www/html

