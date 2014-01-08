vagrant-novaclient
==================

A configuration and bootstrap file for a Vagrant machine running python-novaclient in Fedora 19 on VirtualBox.


Prerequisites
-------------

* [VirtualBox](https://www.virtualbox.org)
* [Vagrant](http://www.vagrantup.com)


Installation
------------

	git clone https://github.com/TFDuesing/vagrant-novaclient.git
	cd vagrant-novaclient
	vagrant up

If Vagrant is new to you, you might want to read the [Up And SSH](http://docs.vagrantup.com/v2/getting-started/up.html) section of Vagrant’s Getting Started documentation for what to do next.


Configuration
-------------

Copy or move your supernova file into your project directory (which is most likely this very directory), with or without the dot in front of the file name.  Without the dot, it’s much easier to edit your supernova file in your host computer’s GUI.

If you don’t have a supernova file yet, just create one in your project directory.

For more information on creating your .supernova file, see the Configuration section of [supernova’s README](https://github.com/major/supernova/blob/master/README.md).


Usage Notes
-----------

Since typing “supernova” is too long, an alias “sn” has been added for /usr/bin/supernova.

You’ll also notice that the SSH forwarding port is static (it’s been set to a random unused port number, and told to work around any collisions).  This way, you can add this machine to your SSH config as a bit of a shortcut.  You can even run `vagrant ssh-config` to generate a SSH config blob for just this purpose.
