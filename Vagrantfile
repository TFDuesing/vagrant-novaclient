# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.define :novaclient do |novaclient|
    novaclient.vm.box = "Fedora-20"
    novaclient.vm.box_url = "http://files.tfduesing.net/Fedora-20-x86_64-virtualbox.box"
    novaclient.vm.network :forwarded_port, guest: 22, host: 35693,  id: "ssh", auto_correct: true
    novaclient.vm.hostname = "novaclient.vbox"
    novaclient.vm.provider "virtualbox" do |v|
      v.name = "novaclient"
    end
    novaclient.vm.provision :shell do |s|
      s.path = "bootstrap.sh"
      # assuming the values of config.ssh.default.username and config.vm.synced_folder for this box
      s.args = "vagrant /vagrant" 
    end
  end
end
