#!/usr/bin/env bash
VAGRANT_USER=$1

# Get node v8
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt update
apt install nodejs -y

# Get nodebb
cd /home/$VAGRANT_USER
sudo -iu $VAGRANT_USER git clone -b v1.10.x https://github.com/NodeBB/NodeBB.git nodebb

# Add config.json and execute setup
cp /vagrant/web2/config.json /home/$VAGRANT_USER/nodebb/
cd nodebb/
chown $VAGRANT_USER:$VAGRANT_USER config.json
su - $VAGRANT_USER -c "cd /home/$VAGRANT_USER/nodebb;./nodebb setup"

# Start nodebb
su - $VAGRANT_USER -c "cd /home/$VAGRANT_USER/nodebb;./nodebb start"
