#!/bin/bash
#
# Author: Povilas Balzaravičius <pavvka@gmail.com>
#
# Mount all available network shares of server.
#

SERVER="deathstar.local"
MOUNTDIR="/home/pawka/Desktop/${SERVER}"

# Collect all available shares of server.
SHARES=`showmount -e ${SERVER} | egrep "^/[A-Za-z ]+$" -o`

for SHARE in $SHARES
do
    DIR=`echo ${MOUNTDIR}$SHARE`
    if [ ! -f "$DIR" ]; then
        mkdir -p $DIR
    fi
    sudo mount ${SERVER}:${SHARE} $DIR
done
