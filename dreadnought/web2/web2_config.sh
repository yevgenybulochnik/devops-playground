#!/usr/bin/env bash
VAGRANT_USER=$1

# Get node v8
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
apt update
apt install nodejs -y

# Get nodebb
cd /home/$VAGRANT_USER
sudo -iu $VAGRANT_USER git clone -b v1.10.x https://github.com/NodeBB/NodeBB.git nodebb
cd nodebb
