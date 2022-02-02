
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

## Troubleshooting
