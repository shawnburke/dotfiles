#! /bin/bash

set -e


function run_test {
   cd ~/
   source dotfiles/tools/prereqs_linux.sh
   export CHSH=no
   export RUNZSH=no
   source dotfiles/tools/init.sh
   dotfiles/install <<< "exit\n"
   zsh <<< "exit"
   echo '{"foo":"bar", "baz":1}' | jq . | grep "baz"
}


if [ "$1" == "run" ]
then 
  run_test
  exit 0
fi

function setup_docker_test {

 
  image_name=$1
  container_name=sb_dotfiles_test_${image_name/:/__}

  echo "### 🤔 STARTING $image_name"

  echo "Starting container..."
  # Start a docker instance, mapping in this directory
  DIR=${VOLUME_DIR:-$HOME/dotfiles}

  if ! docker run -d -v $DIR:/root/dotfiles --name $container_name -it $image_name sleep 1d  
  then
    echo "Failed to start docker container"
    exit 1
  fi


  printf "Waiting for ready"
  # wait for container to be ready
  END=10
  x=$END 
  while [ $x -gt 0 ]; 
  do 
    if docker inspect $container_name | grep -i running
    then
      printf "\tDone\n"
      x=0
    else
      printf "."
      x=$(($x-1))
      sleep 1
    fi
  done

  function cleanup {
    echo "Shutting down $container_name"
    docker rm -f $container_name
    
    [[ -n "$1" ]] && echo "$1"
  }

  echo "Running test"
  if ! docker exec -i $container_name /root/dotfiles/test.sh run
  then
    cleanup "### ❌❌❌ FAIL ❌❌❌ $image_name"
    exit 1
  fi 

  cleanup "### ✅ PASS $image_name\n"
}

setup_docker_test "ubuntu:latest"
setup_docker_test "debian"

