
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
### Development Env
https://github.com/fredericoco/eng103a_DevOps/issues/1#issue-1122141616
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


### Useful commands for git bash
- create a VM `vagrant up`
- check status `vagrant status`
- delete VM `vagrant destroy`
- pause `vagrant halt`
- to update `vagrant reload`
- how to access VM `vagrant ssh`
- log out of VM `logout`


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
- How to check running processes `top` and ctrl c to get terminal back

#### Permissions
- READ Write executable only
- how to check permissions `ll`
- change permission `chmod permission -file`

### Bash scripting
  - to run updates `sudo apt-get update -y`
  - run upgrades `sudo apt-get upgrade -y`
  - to install nginx `sudo apt-get install nginx -y`


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

