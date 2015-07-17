#!/usr/bin/env bash

# Variables
BOX_IP=$1;
VERBOSE=$2;
ANSIBLE_PLAYBOOK=$3

# Ansible provision

sudo rm -rf /etc/ansible/hosts
sudo cp /vagrant/provision/inventories/dev /etc/ansible/hosts -f
sudo chmod 666 /etc/ansible/hosts
sudo sed -i "s/ip/$BOX_IP/g" /etc/ansible/hosts

echo "Ansible provision start..."

# Run the playbook
if [ "$VERBOSE" = "y" ]; then
    sudo -i ansible-playbook $ANSIBLE_PLAYBOOK --connection=local -v
else
    sudo -i ansible-playbook $ANSIBLE_PLAYBOOK --connection=local
fi
