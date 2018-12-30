
#-------------------------------------------------------------
# File & string-related functions:
#-------------------------------------------------------------

# Bash prompt
export PS1="[\[\e[01;49;91m\]\u\[\e[00m\]\[\e[01;49;91m\]@\H\[\e[00m\]][\[\e[1;49;34m\]\W\[\e[0m\]]$ "

 #Safe file deletion
alias rm="rm -i"
alias mv="mv -i"

# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

# Find a file with pattern $1 in name and Execute $2 on it:
function fe()
{ find . -type f -iname '*'${1:-}'*' -exec ${2:-file} {} \;  ; }

# find all instances of a string in all files within a directory
function fstr()
{
    OPTIND=1
    local case=""
    local usage="fstr: find string in files.
Usage: fstr [-i] \"pattern\" [\"filename pattern\"] "
    while getopts :it opt
    do
        case "$opt" in
        i) case="-i " ;;
        *) echo "$usage"; return;;
        esac
    done
    shift $(( $OPTIND - 1 ))
    if [ "$#" -lt 1 ]; then
        echo "$usage"
        return;
    fi
    find . -type f -name "${2:-*}" -print0 | \
    xargs -0 egrep -H --color=always -sn ${case} "$1" 2>&- | more
}
