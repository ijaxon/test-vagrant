#!/usr/bin/env bash

sudo add-apt-repository -y ppa:saltstack/salt
sudo aptitude update
sudo aptitude -y install salt-master
