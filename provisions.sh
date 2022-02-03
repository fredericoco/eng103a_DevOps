#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo apt-get install python-software-properties
sudo apt-get install nodejs -y
sudo apt-get install npm -y
#sudo apt-get install rake -y
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo npm install pm2 -g


cd /home/vagrant/app/app/app
#npm install forever -g
npm install
#forever start app.js