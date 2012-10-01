#!/bin/bash
#
# Author: Povilas Balzaravičius <pavvka@gmail.com>
#
# Mount all available network shares of server.
#

# Load settings
. `dirname $0`/../settings.sh

function getMountedDirs {
    echo `mount -l | grep ${_SERVER} | egrep "^([^ ]+)" -o | egrep "/.+" -o | tr " " "\n"`
}

function getAvailableDirs {
    ping -c 2 ${_SERVER} > /dev/null
    if [[ $? -eq 0 ]]; then
        echo `showmount -e ${_SERVER} | egrep "^/[A-Za-z ]+$" -o`
    fi
}

function getUnmountedDirs {
    MOUNTED=`getMountedDirs`
    UNMOUNTED=()
    for DIR in `getAvailableDirs`
    do
        if [ 0 -eq `echo $MOUNTED | grep $DIR | wc -l` ]; then
            echo $DIR
        fi
    done
}

function cleanUnmountedDirs {
    # Check if at all mount directory exits.
    if [ -d $_MOUNTDIR ]; then
        find $_MOUNTDIR -maxdepth 1 -empty -type d -exec rmdir {} \;

        # Remove mount directory if nothing is mounted.
        if [[ 0 -eq `ls -1 $_MOUNTDIR | wc -l` ]]; then
            rmdir $_MOUNTDIR
        fi
    fi
}

AVAILABLE_DIRS=`getAvailableDirs`
# If mount resources exist
if [[ -n $AVAILABLE_DIRS ]]; then
    for SHARE in $AVAILABLE_DIRS
    do
        DIR=`echo ${_MOUNTDIR}$SHARE`
        if [ ! -f "$DIR" ]; then
            mkdir -p $DIR
        fi
        sudo mount ${_SERVER}:${SHARE} $DIR
    done
fi
cleanUnmountedDirs
