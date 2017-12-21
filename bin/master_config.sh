#!/usr/bin/env bash
echo "auto_accept: True" | sudo tee /etc/salt/master.d/master.conf
cat /vagrant/master.short | tee -a /etc/salt/master.d/master.conf
sudo service salt-master restart
