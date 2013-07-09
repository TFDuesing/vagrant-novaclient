vagrant-novaclient
==================

A configuration and bootstrap file for a Vagrant machine running python-novaclient in Fedora 18 on VirtualBox.

Requirements
------------
* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://www.vagrantup.com)

Installation
------------

	git clone https://github.com/TFDuesing/vagrant-novaclient.git
	cd vagrant-novaclient
	vagrant init
	vagrant up

Configuration
-------------

Copy or move your .supernova file into this directory, making sure to remove the dot from the front of the file name.  This way, you can easily edit your supernova config file on your host computer.

Usage
-----

Since typing “supernova” is too long, an alias “sn” has been added for /usr/bin/supernova.

You’ll also notice that the SSH forwarding port is static (it’s been set to a random unused port number, and told to work around any collisions).  This way, you can add this machine to your SSH config as a bit of a shortcut.