#!/bin/sh

if [ -z "$1" ]
then
  echo "Please specify a jail name"
  exit
fi

schroot -c $1
