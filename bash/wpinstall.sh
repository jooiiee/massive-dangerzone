#!/bin/bash

# Downloads and installs wordpress on a centos machine


mysqluser=root


# root check
if [ $(whoami) != root ] 
then
	echo "Need to be root"
	exit 1
fi

# Download, install and configure LAMP 

yum install -y httpd mysql mysql-server php

chconfig mysqld on
chconfig httpd on

service mysqld start
service httpd start


echo "Configure mysql with a secure password and answer yes to the other questions"
read -s -n 1 -p "Press any key to continue" none
echo ""

mysql_secure_installation

# Download wordpress

curl http://wordpress.org/latest.tar.gz >  /tmp/wordpress.tar.gz

tar -xzf /tmp/wordpress.tar.gz -C /var/www/
mv /var/www/wordpress /var/www/html


# Set up sql

mysqlpassword=$(dd if=/dev/urandom bs=1 count=32 2>/dev/null | base64 -w 0 | rev | cut -b 2- | rev)

echo "CREATE USER \"wordpress\"@\"localhost\" IDENTIFIED BY '$(echo $mysqlpassword)';" > /tmp/setup.sql
echo 'GRANT ALL ON wordpress.* TO "wordpress"@"localhost";' >> /tmp/setup.sql
echo "FLUSH PRIVILEGES;" >> /tmp/setup.sql

echo "The next prompt is for the mysql password you set earlier"
mysql -u root -p < /tmp/setup.sql

rm /tmp/setup.sql

echo 'The database for wordpress is "wordpress"'
echo "The password for wordpress is \"$mysqlpassword\""
echo "The password is availible in the file /tmp/password"
echo "Dont forget to remove the password file"
echo $mysqlpassword > /tmp/password
chmod 600 /tmp/password


echo "Open a browser and run the installer"

exit