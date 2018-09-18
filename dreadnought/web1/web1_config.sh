VAGRANT_USER=$1

#!/usr/bin/env bash
apt update

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

# Install Apache
apt install apache2 -y

# Disable default site
a2dissite 000-default.conf

# Enable mod_rewrite
a2enmod rewrite

# Install mysql-client
apt install mysql-client -y

# Get wordpress cli
curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /usr/local/bin/wp
chmod +x /usr/local/bin/wp

# Make wp dir
mkdir /var/www/blog.dreadnaught.com
chown -R $VAGRANT_USER:www-data /var/www/blog.dreadnaught.com

# Get wordpress core files
sudo -iu $VAGRANT_USER wp core download --path=/var/www/blog.dreadnaught.com

# Generate wp-config file
sudo -iu $VAGRANT_USER wp config create \
    --path=/var/www/blog.dreadnaught.com \
    --dbname=wordpress \
    --dbuser=wordpressuser \
    --dbpass=password \
    --dbhost=data \

# Install wp site
sudo -iu $VAGRANT_USER wp core install \
    --path=/var/www/blog.dreadnaught.com \
    --url=blog.dreadnaught.com \
    --title=Dreadnaught \
    --admin_user=administrator \
    --admin_password=password \
    --admin_email=admin@dreadnaught.com \
    --skip-email
