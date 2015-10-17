#!/usr/bin/env bash

# Variables
ANSIBLE_PLAYBOOK=$1
BOX_IP=$2;
VERBOSE=$3;

# Ansible provision

# Setup hosts file; only need to show correct ip address on provisioning.
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
