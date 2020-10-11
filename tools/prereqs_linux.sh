if ! which sudo < /dev/null
then
   apt update
   apt install -yq sudo
else
   sudo apt update
fi

sudo apt install -yq sudo git python