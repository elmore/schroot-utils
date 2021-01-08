#!/bin/sh

if [ -z "$1" ]
then
  echo "Please specify a jail name"
  exit
fi

jail_name=$1

echo "Unmounting chroot"
jail_id=$(schroot --list --all-sessions | grep $jail_name-.*$ -o)
if [ -z "$jail_id" ]
then
  echo "No session found"
else
  echo "Found session id $jail_id"
  schroot -e -c $jail_id
fi
