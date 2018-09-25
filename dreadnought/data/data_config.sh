#!/usr/bin/env bash
apt update

# MySQL set root password
echo "mysql-server mysql-server/root_password password rootpassword" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password rootpassword" | debconf-set-selections

# Install MySQL
apt install mysql-server -y

# Mysql listen on all ips
sed -i "/bind-address/c\bind-address = *" /etc/mysql/mysql.conf.d/mysqld.cnf

# Create wordpress db
mysql -u root -prootpassword -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -u root -prootpassword -e "GRANT ALL ON wordpress.* TO 'wordpress_user'@'web1' IDENTIFIED BY 'password';"

# Create magento db
mysql -u root -prootpassword -e "CREATE DATABASE magento;"
mysql -u root -prootpassword -e "GRANT ALL ON magento.* TO 'magento_user'@'web1' IDENTIFIED BY 'password';"
mysql -u root -prootpassword -e "FLUSH PRIVILEGES;"

# Restart mysql
service mysql restart

# Get mongo DB and install
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2930ADAE8CAF5059EE73BB4B58712A2291FA4AD5
echo "deb [ arch=amd64,arm64  ] http://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.6 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.6.list
apt update
apt install -y mongodb-org
