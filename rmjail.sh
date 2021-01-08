#!/bin/sh

if [ -z "$1" ]
then
  echo "Please specify a jail name"
  exit
fi

jail_name=$1
jail_dir=~/Jails/$1
jail_conf=/etc/schroot/chroot.d/$jail_name.conf

echo "Unmounting chroot"
JAIL_ID=$(schroot --list --all-sessions | grep $jail_name-.*$ -o)
if [ -z "$JAIL_ID" ]
then
  echo "No session found"
else
  echo "Found session id $JAIL_ID"
  schroot -e -c $JAIL_ID
fi

echo "Removing config $jail_conf"
sudo rm $jail_conf 

echo "Removing directory $jail_dir"
rm -r $jail_dir

echo "Done"
