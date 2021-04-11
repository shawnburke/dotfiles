#! /bin/bash

packages=("git" "python")


export DEBIAN_FRONTEND="noninteractive"

if ! which sudo >/dev/null
then
   apt update
   apt install -yq sudo
fi

if ! dpkg -s $packages > /dev/null
then
   sudo apt install -yq $packages
fi

