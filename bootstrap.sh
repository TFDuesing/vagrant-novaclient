#!/usr/bin/env bash

user="$1"
user_dir="/home/$user"
source_dir="$user_dir/code"
synced_dir="$2"


echo ""
echo "*************************************************************************"
echo "  Updating and Installing Prerequisite Packages"
echo "*************************************************************************"
echo ""

/usr/bin/yum --assumeyes --quiet update yum
/usr/bin/yum --assumeyes --quiet --exclude kernel* update

# python-devel is required to build the (optional) C extension for simplejson
/usr/bin/yum --assumeyes --quiet install vim git python-pip python-devel


echo ""
echo "*************************************************************************"
echo "  Installing novaclient and supernova"
echo "*************************************************************************"
echo ""

# install rackspace-novaclient
/usr/bin/pip install --upgrade --quiet rackspace-novaclient

/usr/bin/mkdir --parents $source_dir

# install python-novaclient
if [ -d "$source_dir/python-novaclient" ]; then
    cd $source_dir/python-novaclient
    /usr/bin/git pull --quiet
    /usr/bin/pip install --quiet \
        --requirement $source_dir/python-novaclient/requirements.txt
    /usr/bin/python $source_dir/python-novaclient/setup.py --quiet install
    cd
else
    /usr/bin/git clone --quiet \
        https://github.com/openstack/python-novaclient.git \
        $source_dir/python-novaclient
    cd $source_dir/python-novaclient
    /usr/bin/pip install --quiet \
        --requirement $source_dir/python-novaclient/requirements.txt
    /usr/bin/python $source_dir/python-novaclient/setup.py --quiet install
    cd
fi

# install supernova
if [ -d "$source_dir/supernova" ]; then
    cd $source_dir/supernova
    /usr/bin/git pull --quiet
    /usr/bin/pip install --quiet \
        --requirement $source_dir/supernova/requirements.txt
    /usr/bin/python $source_dir/supernova/setup.py --quiet install
    cd
else
    /usr/bin/git clone --quiet https://github.com/major/supernova.git \
        $source_dir/supernova
    cd $source_dir/supernova
    /usr/bin/pip install --quiet \
        --requirement $source_dir/supernova/requirements.txt
    /usr/bin/python $source_dir/supernova/setup.py --quiet install
    cd
fi

/usr/bin/chown --recursive $user:$user $source_dir

# add symlink to .supernova file
if [ -f "$synced_dir/supernova" ]; then
    if [ ! -h "$user_dir/.supernova" ]; then
        /usr/bin/ln -s $synced_dir/supernova $user_dir/.supernova
    fi
elif [ -f "$synced_dir/.supernova" ]; then
    if [ ! -h "$user_dir/.supernova" ]; then
        /usr/bin/ln -s $synced_dir/.supernova $user_dir/.supernova
    fi
else
    echo "[Whoops!] No supernova file found."
fi

# add "sn" as a bash alias to "supernova "
echo -e '\nalias sn="/usr/bin/supernova"' >> $user_dir/.bash_profile


echo ""
echo "*************************************************************************"
echo "  There.  Now we’re done."
echo "*************************************************************************"
echo ""