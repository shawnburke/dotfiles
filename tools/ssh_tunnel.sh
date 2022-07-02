host=$1
port=$2


function check_port {
   nc -vz localhost $1 &>/dev/null
}

pidfile="/tmp/${host}-${port}-tunnel.pid"

function finish_it {
        echo "Exiting..."
        if [ -f $pidfile ]
        then
                pid=$(cat $pidfile)
                rm $pidfile
                echo "Killing ssh..."
                kill $pid
        fi
	exit
}

function start_tunnel {
  echo "Starting tunnel to ${host}:${port}"

  if check_port ${port}
  then
		 echo "Existing tunnel detected"
  fi

  trap finish_it SIGINT SIGTERM
  while true
  do
    if ! check_port ${port}
    then
     echo "Connecting to ${host}:${port}..."
     ssh -NL ${port}:localhost:${port} ${host} &
     echo "$!" >$pidfile
     sleep 2
     if check_port ${port}
     then
       echo "Connected!"
     fi
    fi
    sleep 5
  done
}

start_tunnel
