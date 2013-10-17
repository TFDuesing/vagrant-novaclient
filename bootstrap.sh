#!/usr/bin/env bash

user="$1"
user_dir="/home/$user"
synced_dir="$2"


echo ""
echo "*************************************************************************"
echo "  Updating and Installing Prerequisite Packages"
echo "*************************************************************************"
echo ""

/usr/bin/yum --assumeyes update yum
/usr/bin/yum --assumeyes --exclude=kernel* update

# python-devel is required to build the (optional) C extension for simplejson
/usr/bin/yum --assumeyes install git python-devel python-pip

# pycrypto is required for CryptedFileKeyring support,
# which is necessary for supernova-keyring to encrypt passwords
/usr/bin/pip install --quiet pycrypto


echo ""
echo "*************************************************************************"
echo "  Installing novaclient and supernova"
echo "*************************************************************************"
echo ""

# install rackspace-novaclient
/usr/bin/pip install rackspace-novaclient

# install python-novaclient
/usr/bin/pip install --upgrade git+https://git.openstack.org/openstack/python-novaclient.git@master#egg=python-novaclient

# install supernova
/usr/bin/pip install git+https://github.com/major/supernova.git@master#egg=supernova

# add symlink from supernova config file (with or withour the dot)
# to ~/.supernova file
if [ -f "$synced_dir/supernova" ]; then
  /usr/bin/ln --symbolic $synced_dir/supernova $user_dir/.supernova
elif [ -f "$synced_dir/.supernova" ]; then
  /usr/bin/ln --symbolic $synced_dir/.supernova $user_dir/.supernova
else
    echo "[Whoops!] No supernova file found."
fi

# add “sn” as a bash alias to “supernova”
echo -e '\nalias sn=/usr/bin/supernova' >> $user_dir/.bash_profile


echo ""
echo "*************************************************************************"
echo "  There.  Now we’re done."
echo "*************************************************************************"
echo ""
