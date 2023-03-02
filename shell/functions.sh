

# True if $1 is an executable in $PATH
# Works in both {ba,z}sh
function is_in_path {
  if [[ -n $ZSH_VERSION ]]; then
    builtin whence -p "$1" &> /dev/null
  else  # bash:
    builtin type -P "$1" &> /dev/null
  fi
}

function init_tools {
    DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
    . $DIR/../tools/init.sh
}

function export_env() { 
	if [ ! -f $1 ]
	then
		echo "$1 not found";
		return 1;
	fi
	cat $1 | while read p; 
	do 
	  result=$(echo "$p" | grep -E "^[ \t]*[^#]+=.*$")
	  if [ $? != 0 ]
	  then
		  continue;
	  fi
	  eval "export $p"; 
	  v=$(echo $p | grep -oE "^.*?=.{2}")
	  echo "exporting $v...";
	done 
}

function zsh_theme {

    export ZSH_THEME=$1
    omz reload 
}

listening() {
    if [ $# -eq 0 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P
    elif [ $# -eq 1 ]; then
        sudo lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
    else
        echo "Usage: listening [pattern]"
    fi
}

    # src # depends on zsh_reload

