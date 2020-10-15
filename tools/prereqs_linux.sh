#! /bin/bash

packages=("git" "python")



if ! which sudo >/dev/null
then
   apt install -yq sudo
fi

if ! dpkg -s $packages > /dev/null
then
   sudo apt update
   sudo apt install -yq $packages
fi

