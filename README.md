# Vagrant LEMP Stack

----------

## Contributing

### Issues, bug tracker

You can open issue on [Vagrant-LEMP-Stack-setter](https://github.com/juy/Vagrant-LEMP-Stack-setter/issues) repo issue page. We have two repo, one for create a ubuntu box and provision it, other is customize a development ready box (user part).

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

#### *Small note for vagrant shared folders*

> We don't use vagrant shared folder for project, and for now not put any code on Vagrantfile for this. We use SFTP remote access on PhpStorm IDE. We run all commands on server machine, like artisan, composer, npm, bower, gulp.

### Where put project files

Put your project in virtual machine `~/www` directory. For example `~/www/mylaravel`.

### How to access them on web browser

`http://mylaravel.app:8800` or `http://mylaravel.site:8800`, we explain this on "wildcard system" section. Web port is `8800`, we keep different from 8000, because sometimes maybe we run `php artisan serve` outside virtual machine.

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
	- [x] Ubuntu Server 15.04 Vivid Vervet (64-bit) - [boxcutter/ubuntu1504](https://atlas.hashicorp.com/boxcutter/boxes/ubuntu1504)
- **Base Packages**
	- [x] Ansible
	- [x] Nginx
	- [x] PHP 5.6.* (php-fpm)
	- [x] Git, git-flow, git-extras
	- [x] Composer
	- [x] Ruby
	- [x] HHVM (We use for composer speed up with "composerh" command)
	- [x] VirtualBox Guest Additions
- **Databases**
	- [x] MySQL 5.6.*
	- [x] PostgreSQL 9.4.*
	- [x] SQLite
- **In-Memory Stores**
	- [x] Redis
	- [x] Memcached
- **Utility**
	- [x] Mailcatcher
	- [x] Beanstalkd
	- [x] Supervisord
	- [x] Blackfire profiler
	- [x] Ngrok
- **Asset tools**
	- [x] node.js 5.5.*, npm
	- [x] bower
	- [x] gulp
- **Composer global packages**
    - [x] Laravel installer
	- [x] Lumen installer
	- [x] Spark installer
	- [x] Laravel envoy
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



[mit-url]: http://opensource.org/licenses/MIT