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
    echo `showmount -e ${_SERVER} | egrep "^/[A-Za-z ]+$" -o`
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
    find $_MOUNTDIR -maxdepth 1 -empty -type d -exec rmdir {} \;

    # Remove mount directory if nothing is mounted.
    if [[ 0 -eq `ls -1 $_MOUNTDIR | wc -l` ]]; then
        rmdir $_MOUNTDIR
    fi
}

for SHARE in `getAvailableDirs`
do
    DIR=`echo ${_MOUNTDIR}$SHARE`
    if [ ! -f "$DIR" ]; then
        mkdir -p $DIR
    fi
    sudo mount ${_SERVER}:${SHARE} $DIR
done
cleanUnmountedDirs
