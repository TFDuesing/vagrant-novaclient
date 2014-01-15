#!/usr/bin/env sh

user="$1"
user_dir="/home/$user"
synced_dir="$2"


echo ""
echo "*************************************************************************"
echo "  Updating and Installing Prerequisite Packages"
echo "*************************************************************************"
echo ""

yum --assumeyes update yum
yum --assumeyes --exclude=kernel* update

# python-devel is required to build the (optional) C extension for simplejson
yum --assumeyes install git python-devel python-pip


echo ""
echo "*************************************************************************"
echo "  Installing novaclient and supernova"
echo "*************************************************************************"
echo ""

# install rackspace-novaclient
pip install rackspace-novaclient

# install the latest python-novaclient from trunk
pip install --upgrade git+https://git.openstack.org/openstack/python-novaclient.git@master#egg=python-novaclient

# install supernova
pip install git+https://github.com/major/supernova.git@master#egg=supernova

# add symlink from supernova config file (with or withour the dot)
# to ~/.supernova file
if [ -f "$synced_dir/supernova" ]; then
  /usr/bin/ln --symbolic $synced_dir/supernova $user_dir/.supernova
elif [ -f "$synced_dir/.supernova" ]; then
  /usr/bin/ln --symbolic $synced_dir/.supernova $user_dir/.supernova
else
    echo "Whoops! No supernova file found."
fi

# add “sn” as a bash alias to “supernova”
echo -e '\nalias sn=/usr/bin/supernova' >> $user_dir/.bash_profile


echo ""
echo "*************************************************************************"
echo "  There.  Now we’re done."
echo "*************************************************************************"
echo ""
