# source all the shell files
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [ ! -f $DIR/all.sh ]
then
    DIR=~/.shell
fi

os=$(uname -s)
source $DIR/alias.sh
source $DIR/functions.sh
source $DIR/ssh.sh
source $DIR/tools.sh


