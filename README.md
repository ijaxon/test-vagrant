Vagrant Salt REN-ISAC
=====================

These scripts will quickly allow you to setup a simple Salt Master and Minion using Vagrant.
To get started create the `configs.yml` file and set your values, then run the commands:

```
$ cd vagrant-salt
$ vagrant up
```

This used to use the [Salt Bootstrap](https://github.com/saltstack/salt-bootstrap), but that was having issues.
Now using the [Salt Ubuntu PPA](http://docs.saltstack.com/en/latest/topics/installation/ubuntu.html).

The `saltmaster` will have IP `192.168.37.10` and `minion01` will have IP
`192.168.37.11`


**Settings**

  * copy the `configs.yml.example` to `configs.yml` and make your changes there
    * `configs.yml` is in .gitignore. This way, by default, a pull won't wipe it out, and you won't push it to the repo
  * `master.short` is config file for the saltmaster. It's the one pulled from cfg02 with the comments stripped.
    * note that `auto_accept: True` is prepended to the above config file, this is so we can just take the file from cfg02 and don't have to remember to add this setting.

**Scripts and files called by the Vagrantfile**

  * `bin/master_bootstrap.sh`
    * This installs the Salt server
  * `bin/master_config.sh`
    * copies `master.short` to `/etc/salt/master.d/master.conf` on `saltmaster`, then restarts the service
  * `minion_bootstrap.sh`
    * installs salt on the minion and sets config to point to the server
  * `minion_set_grains.sh`
    * file so you can set grains. Runs a loop for 300 seconds to ensure that the grains get registered.
    * node_type vagrant_box_build
      * custom grain so that certain salt code isn't ran that would break vagrant (e.g. firewall rules, minion config, ssh server).
      * in the salt code, see base/top.sls for example of how to exclude specifc salt states
    * role $config_minion_role
      * some items (such as logstash) need to have a role grain set in order to be applied. This is set in the `configs.yml` file.
    * environment $config_minion_environment
      * sets the environment grain. Also set in the `configs.yml` file.

**Other scripts**

  * `rebuild_boxes.sh`
    * runs `vagrant destroy -f && vagrant up` to quickly destroy and rebuild the boxes

**Usage**

  * Once the boxes are up, you can either log onto the server `vagrant ssh saltmaster` or the client `vagrant ssh minion01`
  * once logged in, you should be able to run salt/salt-call commands as expected

**Additional things**

  * This uses a public box. Periodically you'll want to update the box. When the box is shut down / destroyed, run the command:
    * `vagrant box update --force`
