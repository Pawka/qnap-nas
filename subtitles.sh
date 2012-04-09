#!/bin/bash
#
# Download subtitles for movies.
#
# Requirements:
# - BusyBox v1.10.3
# - periscope
#

DESTINATION="/share/Qmultimedia/video/"

find $DESTINATION \( -name *.avi -o -name *.mkv -o -name *.mov -o -name *.mp4 \) -type f | grep -v 'sample' | xargs periscope -l en -l lt

