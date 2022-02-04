
# What is devops?
## Why should we use DevOps?
### Benefits of DevOps

**Four pillars of Devops beat practice**
-Ease of Use
-Flexibility
-Robustness - faster delivery of product
-Cost - cost effective

### Ruby, vagrant and virtual machine
In order to use a VM install, ruby, vagrant and virtual machine. See notes from week 3 eng103a.

### Monolith, 2 tier and Microservices Architectures
## Questions
- What dependencies are required?
- Which operating system can it be tested on ir deployed on?
- Which port di we need to allow?
- What hardware specs to we need to run on it?
### Development Env
![Screenshot_(185)](https://user-images.githubusercontent.com/39882040/152195680-931443ea-5cb1-401d-83b8-f9c40b0dbc77.png)

```

Vagrant.configure("2") do |config|

 config.vm.box = "ubuntu/xenial64"

# creating a virtual machine ubuntu 

end
```
### Starting up VM

- To start VM, `cd` in the file containing `Vagrant file` and run `vagrant up`

- To check the status of the machine `vagrant status`
  
 - To go into the VM `vagrant ssh`
-  `ls -a` in gitbash and it will list all directories in your folder (even the hidden ones)
-  `git status` This will show us whether the gitignore file is correct 
### Useful commands for git bash
- create a VM `vagrant up`
- check status `vagrant status`
- delete VM `vagrant destroy`
- pause `vagrant halt`
- to update `vagrant reload`
- how to access VM `vagrant ssh`
- log out of VM `logout`
- `sudo` is very important it gives permission for installation (admin)
- `systemctl status` will check in the VM whether a package is running
### Setting up Ubuntu
- Downloads and installs available updates `apt-get update `
- Upgrades all packages that have available upgrades `apt get upgrade`
- Install nginx `apt get install nginx`
- `exit` will exit the VM

### Linux basics
- Who am I (computer wise) `uname -a`
- Where am I `pwd`
- list dir/file `ls`
- list all including hidden folder/files `ls -a`
- make dir (directory) `mkdir name-of-dir`
- navigate to dir `cd name-of-dir`
- how to create a file `touch file-name` or `nano file-name`
- How to display content of the file `cat file-name`
- how to remove file `rm -rf file-name`
- How to copy file `cp file-destination-name final`
- Research on google how to move a file `test.txt `inside `move` folder
- To move a file into a location `mv file-moving destination`
- How to check running processes `top` and `ctrl c` to get terminal back

#### Permissions
- READ Write executable only
- how to check permissions `ll`
- change permission `chmod permission -file`

### Bash scripting
  - to run updates `sudo apt-get update -y`
  - run upgrades `sudo apt-get upgrade -y`
  - to install nginx `sudo apt-get install nginx -y`
  - `rm -rf` is used to destroy the file in the terminal 


### Automating the process of installation of the dependencies (1st Febuary 2021 task)
- put the commands listed in the provisions file
  
`#!/bin/bash`

`sudo apt-get update -y`

`sudo apt-get upgrade -y`

`sudo apt-get install nginx -y`

`sudo apt-get install npm -y`

`sudo apt-get install rake -y`

`sudo apt-get install` `python-software-properties`

`curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -`

`sudo apt-get install nodejs -y`

`sudo npm install pm2 -g`


`cd /home/vagrant/app/app/app`

`npm install forever -g`
`npm install`

`forever start app.js`

- When you execute vagrant up in the termina, make sure to call `vagrant up --provision`
### Setting up 
- navigate to the app folder where app.js is located
- `npm install` and then `npm start`
- Should say on the terminal `your app is running and listening on port 3000`
- Go to browser `192.168.10.100` to see if it works
### Linux Variables
Similar to python but different
- Create Linux Var `FIRST_NAME=FREDERICK` 
- How to check the Var `echo $FIRST_NAME`
  
### Environment Variables
- How to check `env var`
- command: `printenv key` or `env`
- create env var `export`
- `export LAST_NAME=JOHNSON`
- how to delete `env var`
-  command: `unset VAR_NAME`
- How to make env var persistent? 
- how to set permenant variables `sudo nano ~/.bashrc`, input the variable you want into the file using the wording `LAST_NAME=JOHNSON`
- Exit the file using `Ctrl x and enter`
- `source ~/.bashrc` to refresh the terminal
- `unset KEY_NAME` to delete variable
- `ps aux` To list all the processes
- `sudo kill PROCESS NUMBER` to kill a specific process
```
if(process.env.DB_HOST) {
  mongoose.connect(process.env.DB_HOST);

  app.get("/posts" , function(req,res){
      Post.find({} , function(err, posts){
        if(err) return res.send(err);
        res.render("posts/index" , {posts:posts});
      })
  });
}
```
## Reverse Proxy with Nginx
- Normally users won't know what port to go onto so in the modern world this has to be resolved
- In order to make sure this happens the Nginx file needs to be configured
- This is done by gutting the command `sudo nano /etc/nginx/sites-available/default` inside the VM
- In this file you put the piece of code(make sure each line is indented properly):
```
      proxy_pass http: localhost:3000;
      proxy_http_version 1.1;
      proxy_set_header Upgrade $http_upgrade;
      proxy_set_header Connection 'upgrade';
      proxy_set_header Host $host;
      proxy_cache_bypass $http_upgrade;
```
- To access the browser, search `192.168.10.100` without the port at the end(3000)
- To access fibonacci we enter /fibonacci at the end
- `sudo nginx -t` This will test whetger everythign is correct
- `sudo systemctl restart nginx` will restart nginx
  # Creating 2 VMs
  - Return to the vagrantfile code and update it with the following code bellow
```
Vagrant.configure("2") do |config|
  config.vm.define "db" do |db|
 
    db.vm.box = "ubuntu/xenial64"

    db.vm.network "private_network", ip: "192.168.10.150"

  end  

    config.vm.define "app" do |app|
 
     app.vm.box = "ubuntu/xenial64"
 
     app.vm.network "private_network", ip: "192.168.10.100"
 
 
 
     app.vm.synced_folder ".", "/home/vagrant/app"
 
     #app.vm.synced_folder ".", "/home/vagrant/environment"
 
     app.vm.provision "shell", path: "provisions.sh", privileged: false
 
    end
 end  
 ```
 - Indentation and spelling are crucial so be extremely careful
 - `vagrant up` will run both VMs
 - If they boot us sucessfully `vagrant status` will show them both running
 - And to enter the VM you have to type `vagrant ssh VM-name` VM-name using to be specific if there are more than one VM
## Setting up Mongdb
- Create 2 VMs (see earlier steps)
- export DB_Host = db_ip:27017/posts
- Mongodb IP: 192.168.10.150
- Mongodb dependencies
- go into db
-  do `sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927`
-  then do `echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list`
-  Then do `sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20`
-  check the status of mongod by `sudo systemctl status mongod`
-  Restart it `sudo systemctl restart mongod`
-  check status again
-  Go to `cd /etc`
-  edit the mongod file using `nano mongod.conf`
-  check it using `cat mongod.conf` and put the below information in
```
network interfaces
net:
  port: 27017
  bindIp: 0.0.0.0
```
  - go to the directory where app.js is located
- `npm start`
- export `export  DB_HOST='mongodb://192.168.10.150:27017/posts'`
- `printenv DB_HOST`
- node seeds/seed.js
- npm start
  
### Multi Machine Task and automation
Create a provisions_db file in which is linked the vagrant file, this is shown below. 
```
#!/bin/bash
sudo apt-get update -y 
sudo apt-get upgrade -y
sudo sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv D68FA50FEA312927
echo "deb https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/3.2 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-3.2.list
sudo apt-get update -y 
sudo apt-get install -y mongodb-org=3.2.20 mongodb-org-server=3.2.20 mongodb-org-shell=3.2.20 mongodb-org-mongos=3.2.20 mongodb-org-tools=3.2.20
sudo cp /home/vagrant/db/mongod.conf /etc/
sudo systemctl restart mongod
``` 
- bin/bash is used to say that it is a shell structure.
- `sudo apt-get` `update` and `upgrade` to update and upgrade the environment
- The next lines are used to install mangodb 3.20, note some of the variables are mangod(processes in linux whcih are running in the background are called deamons)
- `sudo cp /home/vagrant/db/mongod.conf /etc/` is a complicated command. The `cp` is copy, the next part is the directory of where the `mongod.conf` file is the source and `/etc/` is the destionation.
- `sudo systemctl restart mongod` restart the mongod (daemon)

The vagrant file is also updated. It now contains a line to link it to a provisions.sh file `provisions_db.sh` and a line which syncs it to the folder `/home/vagrant/db`.
```
Vagrant.configure("2") do |config|
  config.vm.define "db" do |db|
 
    db.vm.box = "ubuntu/xenial64"

    db.vm.network "private_network", ip: "192.168.10.150"
    db.vm.synced_folder ".", "/home/vagrant/db"
    db.vm.provision "shell", path: "provisions_db.sh", privileged: false

  end  

    config.vm.define "app" do |app|
 
     app.vm.box = "ubuntu/xenial64"
 
     app.vm.network "private_network", ip: "192.168.10.100"
 
 
 
     app.vm.synced_folder ".", "/home/vagrant/app"
 
     #app.vm.synced_folder ".", "/home/vagrant/environment"
 
     app.vm.provision "shell", path: "provisions.sh", privileged: false
     
 
    end
 
 
 
   
 end  
```
The provisions file for the app is also updated to make sure it includes the automatic setup of the proxy server and attributing the variable to the `DB_HOSt` so that it does it automatically appends it to the bashrc script (see linux variables for why this is done). The last line is used install npm in the correct location and 
```
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
```
## AMAZON WEB SERVICES (AWS)
Amazon web services is a service which allows companies to outsource computing power to larger computers in the cloud, the computing power is housed in several warehouses around the world.More warehouses will be built in the future in various locations around the world. According to Amazon's Q3 report, AWS accounted for approximately 15% of their total revenue at $16.8 billion.
- Use the command `ssh -i "~/.ssh/eng103a.pem" ubuntu@ec2-54-75-106-215.eu-west-1.compute.amazonaws.com` is used to to get into the environment in the git bash terminal. All of the same commands work in this git environment, so have fun.  There's no need to use vagrant since there already is a virtual environment.

- Make sure the access key is avialable when you call the acess command above, in the ~/.ssh file directory. In the console you type.
```
sudo apt update -y
sudo apt upgrade -y
sudo apt install nginx
sudo systemctl status nginx
```  
- when you set up the nginx web page, you have to install EVERYTHING in order to get it to work. See the provisions file notes from earlier. Ironically, see the automating the process of installing for further instructions.
- After the installation of all the necessary packages make sure you set up an access port, on the AWS website. Click on `security`,click on the `security groups` link, then you `add rule`> `customer TCP` > Port Range : `3000` > Source :`anywhere-IPv4` > Description `content is optional but useful for documentation`.]
-If everything is done correctly it should work.

