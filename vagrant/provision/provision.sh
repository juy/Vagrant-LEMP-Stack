#!/usr/bin/env bash

# Variables
box_ipaddress=$1;
verbose=$2;

# Check if ansible installed
if ! which ansible > /dev/null; then
	# Ansible does't exist, install it
	echo "Installing ansible";
	sudo apt-get update
	sudo apt-get install -y software-properties-common
	sudo apt-get install -y ansible
fi

# Ansible provision

sudo cp /vagrant/provision/inventories/dev /etc/ansible/hosts -f
sudo chmod 666 /etc/ansible/hosts
sudo sed -i "s/ip/$box_ipaddress/g" /etc/ansible/hosts

echo "Ansible provision start..."

if [ "$verbose" = "y" ]; then
	sudo -i ansible-playbook /vagrant/provision/playbook.yml --connection=local -v
else
	sudo -i ansible-playbook /vagrant/provision/playbook.yml --connection=local
fi
