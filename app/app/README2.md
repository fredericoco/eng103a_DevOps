### Env Testing 

```
#!/bin/bash

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-get install nginx -y
sudo apt-get install python-software-properties
curl -sl https://deb.nodesource.com/setup_6.x sudo -E bash-
sudo apt-get install -y nodejs
sudo apt install python-software-properties
sudo npm install pm2 -g
npm install
npm start
```
`rake spec` to start testing