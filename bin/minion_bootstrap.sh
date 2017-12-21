#!/usr/bin/env bash

sudo add-apt-repository -y ppa:saltstack/salt
sudo apt-get update
sudo apt-get -y install salt-minion

cat <<EOF >/etc/salt/minion
# The user to run salt.
user: root
file_client: local
environment: development
file_roots:
  base:
    - /srv/salt/base
  development:
    - /srv/salt/development
  production:
    - /srv/salt/production

pillar_roots:
  base:
    - /srv/pillar/base
  development:
      - /srv/pillar/development
  production:
    - /srv/pillar/production

mysql.default_file: '/etc/mysql/debian.cnf'
EOF

service salt-minion restart
