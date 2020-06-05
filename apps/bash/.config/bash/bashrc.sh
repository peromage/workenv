#!/usr/bin/bash

# Author: Fang
# Date: 2020/02/17

# Don't add code before the initialization
# Interactive mode initialization script
# Prevent from being loaded twice
if [ -z "$RCLOADED" ]; then
    RCLOADED=1
else
    return
fi
# If in non-interactive mode then exit
case "$-" in
    *i*) ;;
    *) return ;;
esac

function RCLoadModule {
    # $1: Folder where the module resides
    # $2: Module names. Separated by ','
    # $3: The default module extension
    # Note: Module name supports glob

    # Check if give module directory exists
    [ ! -d "$1" ] && return
    # Change current working directory
    local modules i md ext savedcwd
    savedcwd=$(pwd)
    cd $1
    # Expand glob in current module directory
    modules=(${2//,/ })
    # Module extension
    if [ -z "$3" ]; then
        ext=".sh"
    else
        ext=$3
    fi
    # Iterate through module list
    for i in ${modules[@]}; do
        # Strip suffix and append with expected module suffix
        md="${i%.*}$ext"
        # If module with suffix exists, source it.
        [ -f "$md" ] && . "$md"
    done
    # Restore working directory
    cd "$savedcwd"
}

RCROOT=$(dirname $(realpath $BASH_SOURCE))
# End prerequisites

function RCInit {
    # This function's parameters correspond to the rc's parameters
    # This rc script
    RCLoadModule "$RCROOT/autoload" "*"
    source "$RCROOT/bash_profile.sh"
    # Load prompt style
    if [ -z "$1" ]; then
        RCLoadModule "$RCROOT/prompts" mybash
    else
        RCLoadModule "$RCROOT/prompts" "$1"
    fi
}

RCInit $1