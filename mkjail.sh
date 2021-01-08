#!/bin/sh

if [ -z "$1" ]
then
  echo "Please specify a jail name"
  exit
fi


user_name=$SUDO_USER
jail_name=$1
base_dir=~/Jails
conf_dir=/etc/schroot/chroot.d/$jail_name.conf
cache_dir=$base_dir/cache
jail_dir=$base_dir/$jail_name
jail_home=$jail_dir/home/$user_name


if [ -d $jail_dir ]
then
  echo "$jail_name already exists. To start over run 'sudo ./rmjail.sh $jail_name' and retry."
exit
fi

echo "Checking for cache folder.."
if [ ! -d $cache_dir ]
then 
  "No cache found. Creating folder.. "
  mkdir $cache_dir
  echo "Downloading ubuntu .."
  sudo debootstrap --arch=amd64 bionic $cache_dir
fi

echo "Creating dir $jail_name"
mkdir $jail_name

echo "Copying fs from cache.."
# using rsync and -a for archive to keep the permissions
rsync -a $cache_dir/. $jail_dir

echo "Making a new home for configs of packages installed in the chroot ($jail_home)"
mkdir $jail_home

# profile=minimal means base system home is not mounted inside the chroot
echo "Writing config to $conf_dir for user $user_name"
cat >> $conf_dir <<EOL
[$jail_name]
description=ubuntu_18.04
type=directory
directory=$jail_dir
profile=minimal
groups=$user_name
root-users=$user_name
EOL

echo "Done"
echo "Run './jail.sh $jail_name' to start a session then logout to end it"
echo "Run 'sudo ./rmjail.sh $jail_name' to completely remove the jail"



