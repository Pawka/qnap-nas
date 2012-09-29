#!/bin/bash
#
# Author: Povilas Balzaravičius <pavvka@gmail.com>
#
# Global configs file. All global settings variables starts with underscore "_"
# character to easier separate them.

#
# Feel free to change settings
#
_SERVER="deathstar.local"
_MOUNTDIR="/home/pawka/Desktop/${_SERVER}"

#
# Do not change bellow.
#
_ROOTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
