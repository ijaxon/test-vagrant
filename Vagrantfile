# -*- mode: ruby -*-
# # vi: set ft=ruby :
require 'yaml'

settings = YAML.load_file 'configs.yml'

Vagrant.configure('2') do |config|
  config.vm.network "forwarded_port", guest: 80, host: 8080
    config.vm.network "forwarded_port", guest: 443, host: 8181


  # Proxy Settings
  def configure_proxy(vm_def)

    if Vagrant.has_plugin?("vagrant-proxyconf")

      vm_def.proxy.http = ENV['http_proxy']
      vm_def.proxy.https = ENV['https_proxy']
      vm_def.apt_proxy.http = ENV['http_proxy']
      vm_def.apt_proxy.https = ENV['https_proxy']
      vm_def.proxy.no_proxy = ENV['no_proxy']
    end
  end


config.vm.provider "virtualbox" do |v|
  v.memory = 4096
  v.cpus = 1
end

  vm_box = 'ubuntu/trusty64'

  # The Minion VM
  config.vm.define :minion01 do |minion01|
    configure_proxy(minion01)
    minion01.vm.box = vm_box
    minion01.vm.box_check_update = true
    minion01.vm.network :private_network, ip: '192.168.37.11'
    minion01.vm.hostname = settings['minion']['name']
  end

end
