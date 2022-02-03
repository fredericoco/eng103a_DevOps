#!/bin/bash
sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo apt-get install python-software-properties
#sudo apt-get install rake -y
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
sudo apt-get install nodejs -y
#sudo apt-get install npm -y
sudo npm install pm2 -g
sudo cp /home/vagrant/app/default /etc/nginx/sites-available/
sudo systemctl restart nginx
echo "export DB_HOST='mongodb://192.168.10.150:27017/posts'" >> /home/vagrant/.bashrc
source /home/vagrant/.bashrc
cd /home/vagrant/app/app/app && npm install && node /seeds/seed.js

#cd /home/vagrant/app/app/app
#npm install forever -g
#
#forever start app.js