VAGRANT_USER=$1

#!/usr/bin/env bash
apt update

# Install PHP
apt install -y\
    php \
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

# Disable default site and remove
a2dissite 000-default.conf
rm -rf /var/www/html

# Enable mod_rewrite
a2enmod rewrite

# Install mysql-client
apt install mysql-client -y

# Get wordpress cli
curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar > /usr/local/bin/wp
chmod +x /usr/local/bin/wp

# Make wordpress dir
mkdir /var/www/blog.dreadnaught.com
chown -R $VAGRANT_USER:www-data /var/www/blog.dreadnaught.com

# Get wordpress core files
sudo -iu $VAGRANT_USER wp core download --path=/var/www/blog.dreadnaught.com

# Generate wp-config file
sudo -iu $VAGRANT_USER wp config create \
    --path=/var/www/blog.dreadnaught.com \
    --dbname=wordpress \
    --dbuser=wordpress_user \
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

# Install magento/composer dependencies
apt install -y \
    zip \
    unzip \
    php7.0-intl \
    php7.0-zip

# Make magento dir
mkdir /var/www/shop.dreadnaught.com

# Get magento/composer and unpack
wget -P /tmp https://github.com/magento/magento2/archive/2.1.15.tar.gz
tar zxf /tmp/2.1.15.tar.gz -C /var/www/shop.dreadnaught.com --strip=1
wget -P /var/www/shop.dreadnaught.com https://getcomposer.org/composer.phar
cd /var/www/shop.dreadnaught.com
php composer.phar install

# Install magento
/var/www/shop.dreadnaught.com/bin/magento setup:install \
    --base-url='http://shop.dreadnaught.com' \
    --db-host='data' \
    --db-name='magento' \
    --db-user='magento_user' \
    --db-password='password' \
    --admin-firstname='Magento' \
    --admin-lastname='User' \
    --admin-email='admin@dreadnaught.com' \
    --admin-user='admin' \
    --admin-password='admin123'

# Change permissions to www-data
chown -R www-data:www-data /var/www/shop.dreadnaught.com

# Copy virtualhost files
cp /vagrant/web1/{blog.conf,shop.conf} /etc/apache2/sites-available/

# Enable virtualhosts
a2ensite blog.conf shop.conf

# Restart apache
service apache2 restart
