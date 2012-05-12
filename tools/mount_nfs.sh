#!/bin/bash
#
# Author: Povilas Balzaravičius <pavvka@gmail.com>
#
# Mount all available network shares of server.
#

SERVER='deathstar.local'

# Backup and replace space symbol to support folder names with spaces.
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

# Collect all available shares of server.
SHARES=`showmount -e ${SERVER} | grep "/"`

for SHARE in $SHARES
do
    echo $SHARE
done


# Restore space symbol.
IFS=$SAVEIFS
