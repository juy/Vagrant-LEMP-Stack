# Vagrant LEMP Stack

#### Help support this project
If you'd like to support this and other our creations projects, donate via [PayPal][paypal-donate-url].

[![Support via PayPal][paypal-donate-img]][paypal-donate-url]


----------


## What is Vagrant LEMP Stack
A development platform in a box, with everything you would need to develop PHP/Laravel websites.



## Dependencies
* [Vagrant](http://www.vagrantup.com/downloads.html) `1.5.0`+ (Use `vagrant version` to check your version)
* [Virtualbox](https://www.virtualbox.org/wiki/Downloads)



## Installation
Verify that you have the recommended Vagrant version for Vagrant LEMP Stack.

```shell
vagrant version
```

### 1. Clone or download Vagrant LEMP Stack GitHub Repository

**Clone**
```shell
git clone https://github.com/juy/Vagrant-LEMP-Stack.git new-project
```

**Downlaod**
https://github.com/juy/Vagrant-LEMP-Stack/archive/master.zip


### 2. Add Vagrant Box
Add the Vagrant LEMP Stack Box to Vagrant.

```shell
vagrant box add juysoft/vagrant-lemp-stack
```
This will take several minutes so feel free to grab a coffee or a sandwich depending on your internet speed.

### 3. Install vagrant-cachier plugin (optional)
The [vagrant-cachier](https://github.com/fgrehm/vagrant-cachier/) plugin helps you reduce the amount of coffee you drink while waiting for boxes to be provisioned by sharing a common package cache among similiar VM instances.

```shell
vagrant plugin install vagrant-cachier
```

### 4. Configure your Vagrant LEMP Stack Box
Rename `vagrant/config.example.yml` file to `config.yml`. This is config file, fell free to change any variable.


### 5. Run the virtual machine
Run command inside Vagrant LEMP Stack.
```shell
vagrant up && vagrant ssh
```


## Web, project usage

#### Small note for vagrant shared folders

We don't use shared folder for project, and for now not put any code on Vagrantfile for this. We use SFTP remote access on PhpStorm IDE.

### Where put project files

Put your project in `~/www` directory. For example `~/www/mylaravel`.

### How to access them on browser

`http://mylaravel.app:8800` or `http://mywordpress.site:8800`, we explain this on "wildcard system" section. Web port is `8800`, we keep different from 8000, because sometimes maybe we run `php artisan serve` outside virtual machine.


### Wildcard system

Vagrant LEMP Stack is use Nginx wildcard system for infinite project. You don't need configure any virtualhost or edit some Nginx files. At the same time don't need Nginx config reload or restart any service.

There is two domain extension, `.app` and `.site`. `.app` extension is usable for laravel project, this extension search a extra `public` directory on project root. `.site` extension is usable for normal site project, like wordpress, or any kind of project direct run on `root/index.php` file. 

Domain name is same as project directory name, our before example is `mylaravel`. If we use `http://mylaravel.app:8800`, Nginx look a `public/` directory, if we use `http://mylaravel.site:8800`, Nginx dont look `public/` directory.

**Important:**

For windows we need add every single project on `C:\Windows\System32\drivers\etc\hosts` file, example:

```
127.0.0.1    mylaravel.app   # http://mylaravel.app:8800
127.0.0.1    testlaravel.app # http://testlaravel.app:8800
127.0.0.1    wordpress.site  # http://wordpress.site:8800
```

**Shema of wildcard system**
```
*.app:8800 -> www/*/public
*.site:8800 -> www/*
```


## Access and Ports

**Simple dashboard**
```
http://127.0.0.1:8800
```

**MailCatcher**
```
http://127.0.0.1:1080
http://machine-ip:1080
```

**Beanstalkd console**
```
http://127.0.0.1:8501
http://machine-ip:8501
```

**Redis commander**
```
http://127.0.0.1:8502
http://machine-ip:8081
```

**MySQL credentials for remote access**
```
IP          127.0.0.1
Port        33060
Database    homestead
User        root        homestead
Password    secret
```


**PostgreSQL credentials for remote access**
```
IP          127.0.0.1
Port        54320
Database    homestead
User        root
Password    secret
```

**Shell-SSH**
```
IP          127.0.0.1
Port        2222
User        vagrant
Password    vagrant
```

## Vagrant box update commands

**Check outdated box**
```shell
vagrant box outdated
```

**Update box**
```shell
vagrant box update
```


## Virtual machine update commands
This commands for virtual ubuntu, need connect via ssh or `vagrant ssh`

### Ubuntu update

```shell
apt-get update
apt-get upgrade
apt-get dist-upgrade
```

### Composer self and global package update

```shell
composer self-update
composer global update
```

### Npm global package update
```shell
npm update -g 
```

----------


## Provisioned Content
- **OS**
	- [x] Ubuntu Server 15.04 Vivid Vervet (64-bit) - [boxcutter/ubuntu1504](https://atlas.hashicorp.com/boxcutter/boxes/ubuntu1504) v1.1.0
- **Base Packages**
	- [x] Ansible 1.9.2
	- [x] Nginx 1.8.0
	- [x] PHP 5.6.11 (php-fpm)
	- [x] Git 2.4.6, git-flow, git-extras
	- [x] Composer
	- [x] Ruby 2.1.2p95
	- [x] HHVM 3.8.0 (Only for composer speed up)
	- [x] VirtualBox Guest Additions 4.3.28
- **Databases**
	- [x] MySQL 5.6.24
	- [x] PostgreSQL 9.4.4
	- [x] SQLite 3.8.7.4
- **In-Memory Stores**
	- [x] Redis 3.0.3
	- [x] Memcached 1.4.14
- **Utility**
	- [x] Mailcatcher 0.6.1
	- [x] Beanstalkd 1.10
	- [x] Supervisord 3.0
	- [x] Blackfire profiler 0.27.0
	- [x] Ngrok 2.0.19
- **Asset tools**
	- [x] node.js 0.10.40, npm 1.4.28
	- [x] bower 1.4.1
	- [x] gulp 3.9.0
- **Composer global packages**
    - [x] Laravel Installer 1.2.1
	- [x] Lumen Installer 1.0.1
	- [x] Laravel Envoy 1.0.24
- **SSH tools**
	- [x] htop
	- [x] mytop
	- [x] pgtop
	- [x] ngxtop
	- [x] autojump
	- [x] screen
- **Web GUI tools**
	- [x] Beanstalkd console - https://github.com/ptrofimov/beanstalk_console
	- [x] Redis Commander - https://github.com/joeferner/redis-commander


### License
This project is open-sourced software licensed under the [MIT license][mit-url].



[paypal-donate-img]: https://img.shields.io/badge/PayPal-donate-brightgreen.svg?style=flat-square
[paypal-donate-url]: http://bit.ly/donateAngelside

[mit-url]: http://opensource.org/licenses/MIT