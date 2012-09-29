#!/bin/bash
#
# All requirements for current config. Some libs could be missing but I'm
# trying to collect them all over here :-)
#

ipkg update
ipkg install busybox
ipkg install unrar
ipkg install python27
ipkg install svn
ipkg install git
ipkg install findutils
ipkg install grep

ipkg upgrade

ln -s /opt/local/bin/periscope /opt/bin/periscope
