#!/bin/bash

# Update system
apt update

# Install Apache
apt install apache2 -y

# MySQL set root password
echo "mysql-server mysql-server/root_password password rootpassword" | debconf-set-selections
echo "mysql-server mysql-server/root_password_again password rootpassword" | debconf-set-selections

# Install MySQL
apt install mysql-server -y

# Create wordpress db
mysql -u root -prootpassword -e "CREATE DATABASE wordpress DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"
mysql -u root -prootpassword -e "GRANT ALL ON wordpress.* TO 'wordpressuser'@'localhost' IDENTIFIED BY 'password';"
mysql -u root -prootpassword -e "FLUSH PRIVILEGES;"

# Install PHP
apt install -y php \
    libapache2-mod-php \
    php-mcrypt \
    php-mysql \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-xmlrpc

# Index php files first
echo "
<IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.cgi index.pl index.xhtml index.htm
</IFModule>
" > /etc/apache2/mods-enabled/dir.conf

# PHPmyadmin config questions
echo 'phpmyadmin phpmyadmin/dbconfig-install boolean true' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/app-password-confirm password phpmyadminpass' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/admin-pass password rootpassword' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/mysql/app-pass password rootpassword' | debconf-set-selections
echo 'phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2' | debconf-set-selections

# PHPmyadmin Install
apt install -y phpmyadmin php-gettext

# Enable PHP Mods
phpenmod mcrypt
phpenmod mbstring

# Restart apache
service apache2 restart
