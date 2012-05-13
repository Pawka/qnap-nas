#!/bin/bash
#
# Download subtitles for movies.
#
# Usage: subtitles.sh <path|file>
#
# Requirements:
# - BusyBox v1.10.3
# - periscope
#

DESTINATION=$1

# Check if destination is provided
if [[ -z "$DESTINATION" ]]; then
    echo "Usage: `basename $0` <path|file>"
    exit
fi

# Log dir
LOGDIR="`dirname $0`/log"
LOGFILE="${LOGDIR}/`basename $0`.log"

# Create logs directory if it does not exist.
if [ ! -d "$LOGDIR" ]; then
  echo "Creating log dir: ${LOGDIR}"
  mkdir $LOGDIR
fi

# Log content to log file
function log {
  LINE="`date +'%F %H:%M:%S'` $1"
  echo $LINE
  echo $LINE >> $LOGFILE
}

log "Starting job"
find $DESTINATION \( -name *.avi -o -name *.mkv -o -name *.mov -o -name *.mp4 \) -type f | grep -v 'sample' | xargs periscope -l en -l lt

