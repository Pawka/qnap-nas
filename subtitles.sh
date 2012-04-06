#!/bin/bash
#
# Download subtitles for movies.
#
# Requirements:
# - BusyBox v1.10.3
# - periscope
#

find /share/Qmultimedia/video/ \( -name *.avi -o -name *.mkv -o -name *.mov -o -name *.mp4 \) -follow -type f -mtime 2 | grep -v lt

