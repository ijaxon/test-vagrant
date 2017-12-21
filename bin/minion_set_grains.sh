#!/usr/bin/env bash

source /vagrant/bin/parse_yaml.sh

eval $(parse_yaml /vagrant/configs.yml "config_")

i="0"
while [ $i -lt 20 ]
do
    # This grain doesn't need to be set, the type is determined by
    # a default grain called "virtual"
    # virtual: VMware
    # virtual: VirtualBox
    # salt-call grains.setval node_type vagrant_build_box

    salt-call grains.setval role $config_minion_role
    salt-call grains.setval environment $config_minion_environment

    sleep 30
    9=[$i+1]
done
