# A command that I made and put in my bash_aliases. Substitutes cd .. with just ..
# along with accepting parameters, either the number of folders to go up by
# or a specific folder that you want to go to in the path

function .. () {
    # If there is an argument
    if [ $1 ]; then
        # Making a string to compare to
        str='/'$1'/'
        # If arg is a number
        if [[ $1 =~ $re ]] ; then
            # First check if there's a folder in the subpath
            if [[ "$PWD" != *"$str"* ]]; then
                # If not, go down by number passed in
                for ((i=0; i < $1; i++)); do
                    # If we hit the root
                    if [[ $(curr) == '/' ]]; then
                        echo -en '\E[31m'"\033[1mHit the root\033[0m"'\n'
                        return;
                    fi
                    cd ..
                    done
                return;
            fi
        fi
        # If the arg is a string, check if it's in the path
        if [[ "$PWD" == *"$str"* ]]; then
            # If so, go up to that folder
            while [[ $1 != $(curr) ]]; do
                cd ..
                done
        else
            # If not...
            echo -en '\E[31m'"\033[1m$1 is not in the path\033[0m"'\n'
        fi
    # If there was no argument, just normal cd ..
    else
        cd ..
    fi
}
