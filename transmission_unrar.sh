#!/bin/bash
#
# Unrar packed contents of torrents.
#

SOURCE="/share/Qmultimedia/video/"
DESTINATION="/share/Qmultimedia/video/"
LIST="/share/Qdownload/transmission/extracted.txt"

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

# Backup space symbol
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

log "Starting job"
# Find all RARs in working directory.
for MYRAR in `find "$SOURCE" -name *.rar`
do
   # Check if it's been decompressed before
   if grep -q $MYRAR $LIST
   then
      # Do nothing.
      echo "Already decompressed" > /dev/null

   # If it hasn't be decompressed before, make a new folder and decompress it
   else
      # Add the name to the list so it will be skipped in the future
      echo $MYRAR >> $LIST
      
      log "Decompressing $MYRAR"
      FOLDERNAME=`echo "${MYRAR:${#SOURCE}}"`
      FOLDERNAME=`echo $FOLDERNAME | sed 's:/.*::'`
      FINALADDRESS=$DESTINATION$FOLDERNAME

      # Create directory only if it does not exist.
      if [ ! -d "$FINALADDRESS" ]; then
        mkdir $FINALADDRESS
      fi
      /opt/bin/unrar x -inul "$MYRAR" "$FINALADDRESS"
   fi
done

# Restore space symbol
IFS=$SAVEIFS

log "Job ended"
exit
