

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
    local kill_flag=false
    local pattern=""
    local force_flag=false
    
    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -k|--kill)
                kill_flag=true
                shift
                ;;
            -f|--force)
                force_flag=true
                shift
                ;;
            -h|--help)
                echo "Usage: listening [options] [pattern]"
                echo "Options:"
                echo "  -k, --kill    Kill all processes matching the pattern"
                echo "  -f, --force   Skip confirmation prompt when killing"
                echo "  -h, --help    Show this help message"
                echo ""
                echo "Examples:"
                echo "  listening                 # Show all listening processes"
                echo "  listening 8080            # Show processes listening on port 8080"
                echo "  listening -k 8080         # Kill processes listening on port 8080"
                echo "  listening -k -f 8080      # Kill without confirmation"
                return 0
                ;;
            -*)
                echo "Unknown option: $1"
                echo "Use -h or --help for usage information"
                return 1
                ;;
            *)
                pattern="$1"
                shift
                ;;
        esac
    done
    
    # Check if lsof is available (should be on both macOS and Linux)
    if ! command -v lsof >/dev/null 2>&1; then
        echo "Error: lsof command not found. Please install lsof."
        return 1
    fi
    
    # Get the lsof output
    if [ -z "$pattern" ]; then
        lsof_output=$(sudo lsof -iTCP -sTCP:LISTEN -n -P 2>/dev/null)
    else
        lsof_output=$(sudo lsof -iTCP -sTCP:LISTEN -n -P 2>/dev/null | grep -i "$pattern")
    fi
    
    # Check if we found any processes
    if [ -z "$lsof_output" ]; then
        echo "No listening processes found"
        if [ -n "$pattern" ]; then
            echo "for pattern: $pattern"
        fi
        return 0
    fi
    
    # If kill flag is set, extract PIDs and kill them
    if [ "$kill_flag" = true ]; then
        echo "Found listening processes:"
        echo "$lsof_output"
        echo ""
        
        # Extract PIDs (second column) - works on both macOS and Linux
        pids=$(echo "$lsof_output" | awk '{print $2}' | sort -un)
        
        if [ -z "$pids" ]; then
            echo "No PIDs found to kill"
            return 0
        fi
        
        echo "PIDs to kill: $(echo $pids | tr '\n' ' ')"
        
        # Skip confirmation if force flag is set
        if [ "$force_flag" = false ]; then
            printf "Are you sure you want to kill these processes? [y/N]: "
            read -r confirm
        else
            confirm="y"
            echo "Force flag set, killing without confirmation..."
        fi
        
        case $confirm in
            [Yy]|[Yy][Ee][Ss])
                echo "Killing processes..."
                for pid in $pids; do
                    # Use kill -TERM first, then kill -KILL if needed (more graceful)
                    if kill -TERM "$pid" 2>/dev/null; then
                        echo "✓ Sent TERM signal to PID $pid"
                        sleep 1
                        # Check if process is still running, if so use KILL
                        if kill -0 "$pid" 2>/dev/null; then
                            if kill -KILL "$pid" 2>/dev/null; then
                                echo "✓ Force killed PID $pid"
                            else
                                echo "✗ Failed to kill PID $pid"
                            fi
                        fi
                    else
                        echo "✗ Failed to send signal to PID $pid (may already be dead or permission denied)"
                    fi
                done
                ;;
            *)
                echo "Operation cancelled"
                return 0
                ;;
        esac
    else
        # Just show the output
        echo "$lsof_output"
    fi
}
    # src # depends on zsh_reload

