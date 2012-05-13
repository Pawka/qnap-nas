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

SOURCE=$1

# Check if SOURCE is provided
if [[ -z "$SOURCE" ]]; then
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
if [[ -d $SOURCE ]]; then
    log "Looking up for directory $SOURCE"
    find $SOURCE \( -name *.avi -o -name *.mkv -o -name *.mov -o -name *.mp4 \) -type f | grep -v 'sample' | xargs periscope -l en -l lt
elif [[ -f $SOURCE ]]; then
    log "Looking up for file $SOURCE"
    periscope -l en -l lt $SOURCE
else
    log "File/path not found: $SOURCE"
fi

