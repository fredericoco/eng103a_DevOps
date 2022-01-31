
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