
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
 - ![Screenshot_(231) (1)](https://user-images.githubusercontent.com/39882040/152503482-d4b8505c-458a-4f65-9fe6-0398cd50d203.png)
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
- On AWS to launch an instance, after signing in, search for `Ubuntu Server 18.04 LTS`, Select the `64-Bit x86` option
- Use the command `ssh` . This `ssh` command is found in the instance part of the AWS, click on the connect button and copy the ssh link example. If this command is put in the git bash terminal it should enter the interactive environment.Thiss should be done in the same directory as the ssh file.
- Note this link can change so initialise the the instance on the website, click on the link starting with i and then copy the ssh link under example.
- All of the same commands work in this git environment, so have fun.  There's no need to use vagrant since there already is a virtual environment.

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

# Accessing the DB through AWS
- Set up an EC2 instance for DB through AWS.
- Ubuntu Server 18.04.64 bit (x86), default instance type, configure it to have 1 instance set to Default eu-west-1a, Enable, default storage, add eng103a to value to make it easier to find and add name to make sure it's named after you, change security group name to the one you used earlier, change the type to custom TCP, Protocol to TCP,port range 27017, source Anywhere, description should be used for writing up. Make sure to set the key pair to the eng103a.
- Access the VM by using gitbash and the command from the connect window discussed earlier.
-  Install Mongodb on this VM following the instructions given earlier.
-  Go the app VM follow the intructions from earlier, but change the IP in the `export` variable to the one on AWS for the DB VM. `node seed/seeds.js` and then `npm start`,  this should create the webpage.
-  One issue I had was that I forgot to change the IP on `DB_HOST` first time around so I had to edit it using `nano`.
- I also had to put the app folder on again.
# Two Tier Architecture diagram and explanation
  ![image](https://user-images.githubusercontent.com/39882040/152561273-c586e338-4216-43bb-b6ec-ecddce674788.png)
Two tier architecture systems are defined as a piece of software where the presentation layer (what you see) and data layer (where the information comes from) are stored on a server, but are in two different locations. Two different virtual machines.

There are some advantages assosiated with a two tier system:
- Relatively easy to maintain and modify
- Communication is faster
  
 There are also some disadvantages associated with this type of architecture:
- Performance is degraded when the amount of users increases
- Cost-ineffective
  
There is a Quora post which discusess this in a lot of detail.Specifically for databases. https://www.quora.com/What-are-the-advantages-and-disadvantages-of-architecture-1-tier-2-tier-3-tier-and-n-tier

# Amazon machine image (AMI)
AWS Amazon machine images is a service which contains configuration for an instance. It provides the information to launch an instance. AMI need to be specified on launch and you can launch multiple instances if you use AMIs from the same configuration.

Benefits:
 - So it helps us save the data. 
- It Helps automate the deployment on the cloud.
### Creating an AMI and launching an instance from it
- click on action -> Image and template -> Create image
- name it using the same convention "eng103a_Name_VM_name_ami" and add tag with same information.
- Go to Images/AMI to see the created AMI
- Select the AMI you want to copy and launch an instance, change the subnet to to 1a
- Add name and tag normally to the Tag section
- On the security group section choose the one created earlier with the other instances
- Make sure the key pair is the same 

## Issues today
- ssh command had the wrong IP so I changed the security group rules so that port 22 would update. This was done to accomadate my dynamic IP.
- On the ssh link, change the root to ubuntu
- Make sure the `/etc/nginx/sites-available` file works, if there are persistent issues with it try checking the file and reposting the file content. 
- Be mindful when you send code via discord

# Monitoring software with cloudwatch
What should we monitor:
- Number of uers-network
- CPU utilisation
- Memory availability
- Status 200 - API call to check health of the instance
We need a system that can monitor networks to see if it's handling the demand well.

We can use Cloudwatch for this. For example, we can use it to say if CPU usage is greater than 50%. This will send a notification and a log to someone responsible.

An AWS service called SNS(simple notification service) can be used to notify those who know what to do. This can also be used for Auto Scaling. This will scale out and increase the CPU supply to accomadate for the command.

- scaling out: same amount of servers with multiple instances
- scaling up: increasing 

Add pc example - Scaling out is adding more computers / CPUs to deal with the load (autoscaler, spinning up more VMs to handle the load).
- Scaling up is increasing the minimum requirement by improving hardware in the beginning. (Going from T2.micro to T2.medium)

We can create an alarm for various metrics on cloudwatch. Make sure you use your istance ID and the metric you want to find to locate the correct data. For example, for CPU utilization search this term and istance ID to find the correct metric. There should be data on the correct metric

# Alert Management
If one of the conditions is met and there is an issue, someone on shift will 

# S3
S3 is a simple storage service. A database available on AWS. It's available globally and you can store anything. Used for disaster recovery (DR). We can apply Create bucket/object , read,update and delete (CRUD) actions. If there were a disaster in the location where our instances are located (Ireland for us) we would lose a lot of work.So we need to back them up. We need AWS SEC and ACCESS KEYs to access the S3. 

S3 storage classes:
- standard: You can access data anytime
- Glacier: infrequent data access(pay less)
- research rest in own time