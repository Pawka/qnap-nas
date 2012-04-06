#!/bin/bash
#
# Unrar packed contents of torrents.
#

SOURCE="/share/Qmultimedia/video/"
DESTINATION="/share/Qmultimedia/video/"
LIST="/share/Qdownload/transmission/extracted.txt"

# Find all RARs in working directory.
for MYRAR in `find "$SOURCE" -name *.rar`
do
   # Check if it's been decompressed before
   if grep -q $MYRAR $LIST
   then
      echo "Already decompressed"

   # If it hasn't be decompressed before, make a new folder and decompress it
   else
      # Add the name to the list so it will be skipped in the future
      echo $MYRAR >>$LIST
      
      FOLDERNAME=`echo "${MYRAR:${#SOURCE}}"`
      FOLDERNAME=`echo $FOLDERNAME | sed 's:/.*::'`
      FINALADDRESS=$DESTINATION$FOLDERNAME
      #Create directory only if it does not exist.
      if [ ! -d "$FINALADDRESS" ]; then
        mkdir $FINALADDRESS
      fi
      /opt/bin/unrar x -inul "$MYRAR" "$FINALADDRESS"
   fi
done

exit

