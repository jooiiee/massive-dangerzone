#!/bin/bash

# Downloads and installs wordpress on a centos machine


mysqluser=root


# root check
if [ $(whoami) != root ] 
then
	echo "Need to be root"
	exit 1
fi
# Warn user
echo "This script will install a LAMP server and wordpress to /var/www/html"
echo "Files in /var/www/html will be overwritten!"

read -n 1 -p "Continue? Y/N: " REPLY
if [[ ! $REPLY =~ ^[Nn]$ ]]
then
	echo "Exiting"
    exit 1
fi


# Download, install and configure LAMP 
yum install -y httpd mysql mysql-server php > /dev/null
chconfig mysqld on
chconfig httpd on
service mysqld start
service httpd start

# Configure mysql
echo "Configure mysql with a secure password and answer yes to the other questions"
read -s -n 1 -p "Press any key to continue" none
echo ""

# The secure installation script could be replaced, but that would be a hassle. This is quick n dirty. 
mysql_secure_installation

# Download wordpress
curl http://wordpress.org/latest.tar.gz >  /tmp/wordpress.tar.gz
tar -xzf /tmp/wordpress.tar.gz -C /var/www/
mv /var/www/wordpress /var/www/html

# Adjust file permissions
chmod -R 760 /var/www/http 
chown -R www-data:www-data
adduser root www-data

# Set up sql for wordpress
	# Generate passwords
	mysqlpassword=$(dd if=/dev/urandom bs=1 count=32 2>/dev/null | base64 -w 0 | rev | cut -b 2- | rev) 
	backuppassword=$(dd if=/dev/urandom bs=1 count=10 2>/dev/null | base64 -w 0 | rev | cut -b 2- | rev)

	# Write command file
	echo "CREATE USER \"wordpress\"@\"localhost\" IDENTIFIED BY '$(echo $mysqlpassword)';" > /tmp/setup.sql
	echo 'GRANT ALL ON wordpress.* TO "wordpress"@"localhost";' >> /tmp/setup.sql
	echo "CREATE USER \"backup\"@\"localhost\" IDENTIFIED BY '$(echo $backuppassword)';" > /tmp/setup.sql
	echo 'GRANT SELECT ON wordpress.* TO "backup"@"localhost";' >> /tmp/setup.sql
	echo "FLUSH PRIVILEGES;" >> /tmp/setup.sql

	# Execute comand file
	echo "The next prompt is for the mysql password you set earlier"
	mysql -u root -p < /tmp/setup.sql

	# Remove command file
	# The command file contains the sql password in clear text
	rm /tmp/setup.sql

	# Echo sql info to user
	echo 'The database for wordpress is "wordpress"'
	echo "The password for wordpress is \"$mysqlpassword\""
	echo "The backup password is located in /root/backuppassword"
	echo $backuppassword > /root/backuppassword
	chmod 600 /root/backuppassword


echo "If no errors were reported, wordpress core should be installed and ready for configuration"
echo "Continue the install from a browser"

exit 0
