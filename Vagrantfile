# Vagrant LEMP Stack
# A development platform in a box, with everything you would need to develop PHP/Laravel websites.
# See the readme file (README.md) for more information.
# Contribute to this project at : https://github.com/juy/Vagrant-LEMP-Stack-setter

# Include config from config file
$config_file = "config.yml"
require 'yaml'
$config = YAML::load_file($config_file)

# Vagrant configure
Vagrant.configure(2) do |config|

  # Configure the box
  config.vm.box = "vagrant-lemp-stack" # hostname is vagrant
  #config.vm.box_url = "file:///c:/path/to/vm.box"
  config.vm.box_check_update = false
  config.vm.boot_timeout = 60
  #config.vm.hostname = $config['hostname'] # Disable reason: https://github.com/mitchellh/vagrant/issues/5673

  # https://github.com/dotless-de/vagrant-vbguest
  config.vbguest.auto_update = false

  # Private network IP
  config.vm.network :private_network, ip: $config['box_ipaddress']

  # Allow caching to be used
  # http://fgrehm.viewdocs.io/vagrant-cachier/usage
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.scope = :box
    config.cache.auto_detect = false
    config.cache.enable :apt
    config.cache.enable :npm
    config.cache.enable :composer
    config.cache.enable :bower
    config.cache.enable :gem
    #config.cache.enable :generic, { "wget" => { cache_dir: "/var/cache/wget" } }
    #config.cache.synced_folder_opts = { type: :nfs }
    #config.cache.synced_folder_opts = { type: :nfs, mount_options: ['rw', 'vers=3', 'tcp', 'nolock'] }
  end

  # Shared folder
  config.vm.synced_folder "./", "/vagrant", type: "nfs"

  # Virtualbox settings
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", $config['box_memory']]
    vb.customize ["modifyvm", :id, "--cpus", $config['box_cpu']]
    vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
    vb.customize ["modifyvm", :id, "--nestedpaging", "off"]
    vb.customize ["modifyvm", :id, "--ostype", "Ubuntu_64"]
  end

  # Port forwarding
  config.vm.network :forwarded_port, guest: 80,    host: 8000,  auto_correct: true
  config.vm.network :forwarded_port, guest: 443,   host: 44300, auto_correct: true
  config.vm.network :forwarded_port, guest: 3306,  host: 33060, auto_correct: true
  config.vm.network :forwarded_port, guest: 5432,  host: 54320, auto_correct: true
  config.vm.network :forwarded_port, guest: 6379,  host: 63790, auto_correct: true  # Redis
  config.vm.network :forwarded_port, guest: 8501,  host: 8501,  auto_correct: true  # Beanstalkd console
  config.vm.network :forwarded_port, guest: 8502,  host: 8502,  auto_correct: true  # Redis commander
  config.vm.network :forwarded_port, guest: 11211, host: 11212, auto_correct: true  # Memcached
  config.vm.network :forwarded_port, guest: 35729, host: 35729, auto_correct: true  # Livereload
  config.vm.network :forwarded_port, guest: 1080,  host: 10800, auto_correct: true  # MailCatcher

end
