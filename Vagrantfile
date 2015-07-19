# Vagrant LEMP Stack
# A development platform in a box, with everything you would need to develop PHP/Laravel websites.
# See the readme file (README.md) for more information.
# Contribute to this project at : https://github.com/juy/Vagrant-LEMP-Stack-setter

# Check vagrant version
if Vagrant::VERSION < "1.5.0"
  puts "Please upgrade to vagrant 1.5+: "
  puts "https://www.vagrantup.com/downloads.html"
  exit
end

$config_file = "vagrant/config.yml"

# Check for config file
if !File.file?($config_file)
  puts "Config file is missing: #{$config_file}\n"
  puts "Please rename config.example.yml to config.yml in vagrant/ directory"
  exit
end

# Include config from config file
require 'yaml'
$config = YAML::load_file($config_file)

# Vagrant configure
Vagrant.configure(2) do |config|

  # Configure the box
  config.vm.box = "juysoft/vagrant-lemp-stack"
  #config.vm.box_check_update = false
  config.vm.boot_timeout = 60

  # Set the name of the VM. See: http://stackoverflow.com/a/17864388/100134
  config.vm.define "#{$config['machine_name']}" do |t|
  end

  # https://github.com/dotless-de/vagrant-vbguest
  config.vbguest.auto_update = false

  # SSH settings
  #config.ssh.username = "vagrant"
  #config.ssh.password = "vagrant"

  # https://github.com/dotless-de/vagrant-vbguest
  config.vbguest.auto_update = false

  # Private network IP
  config.vm.network :private_network, ip: $config['vm']['ip']
  #config.ssh.forward_agent = true

  # Allow caching to be used
  # http://fgrehm.viewdocs.io/vagrant-cachier/usage
  if $config['use_cachier']
    if Vagrant.has_plugin?("vagrant-cachier")
      config.cache.scope = :box
      config.cache.auto_detect = false
      config.cache.enable :apt
      #config.cache.enable :npm  # Make problems
      config.cache.enable :composer
      config.cache.enable :bower
      config.cache.enable :gem
      #config.cache.enable :generic, { "wget" => { cache_dir: "/var/cache/wget" } }
      #config.cache.synced_folder_opts = { type: :nfs }
      #config.cache.synced_folder_opts = { type: :nfs, mount_options: ['rw', 'vers=3', 'tcp', 'nolock'] }
    end
  end

  # Shared folder
  config.vm.synced_folder "./vagrant", "/vagrant", type: "nfs"


  # Shared project folder test
  if $config['shared_folder']
    config.vm.synced_folder "./share-test", "~/share-test", type: "nfs"
  end


  # Virtualbox settings
  config.vm.provider :virtualbox do |v|
      v.customize [
          "modifyvm", :id,
          "--memory", $config['vm']['memory'],
          "--cpus", $config['vm']['cpu'],
          "--natdnshostresolver1", "on",
          "--natdnsproxy1", "on",
          "--ioapic", "on",
          "--nestedpaging", "off",
          "--ostype", "Ubuntu_64"
      ]
  end

  # Port forwarding
  config.vm.network :forwarded_port, guest: 80,    host: 8800,  auto_correct: true
  config.vm.network :forwarded_port, guest: 8000,  host: 8888,  auto_correct: true
  config.vm.network :forwarded_port, guest: 443,   host: 44300, auto_correct: true
  config.vm.network :forwarded_port, guest: 3306,  host: 33060, auto_correct: true
  config.vm.network :forwarded_port, guest: 4040,  host: 40400, auto_correct: true  # ngrok
  config.vm.network :forwarded_port, guest: 5432,  host: 54320, auto_correct: true
  config.vm.network :forwarded_port, guest: 6379,  host: 63790, auto_correct: true  # Redis
  config.vm.network :forwarded_port, guest: 8501,  host: 8501,  auto_correct: true  # Beanstalkd console
  config.vm.network :forwarded_port, guest: 8502,  host: 8502,  auto_correct: true  # Redis commander
  config.vm.network :forwarded_port, guest: 11211, host: 11212, auto_correct: true  # Memcached
  config.vm.network :forwarded_port, guest: 35729, host: 35729, auto_correct: true  # Livereload
  config.vm.network :forwarded_port, guest: 1080,  host: 1080,  auto_correct: true  # MailCatcher

  # Ansible provisioning
  if $config['ansible']['provision']
    if Vagrant::Util::Platform.windows?
      config.vm.provision "shell" do |s|
        s.path = "./vagrant/provision/provision.sh"
        s.args = [$config['vm']['ip'], ($config['ansible']['verbose']) ? "y" : "n", "/vagrant/provision/playbook.yml"]
      end
    else
      config.vm.provision :ansible do |ansible|
        ansible.playbook = "vagrant/provision/playbook.yml"
        ansible.inventory_path = "vagrant/provision/inventories/dev"
        ansible.limit = "all"
        ansible.sudo = true
        if $config['ansible']['verbose']
          ansible.verbose = "vv"
        end
      end
    end
  end

end
