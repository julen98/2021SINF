#!/bin/sh
exitcode=1
MAIN=$1
COPY=$2

# Read the user input   
#echo "Enter the pendrive name: "  
#read pendrive


#$COPY = /media/$USER/$pendrive/

# Making a backup of the main folder
echo "Making a backup..."
rsync -ar --backup --suffix=`date +'.%F_%H-%M'` $MAIN /backupRsync/

# Check if folders exist
if [ -d "$MAIN" ] && [ -d "$COPY" ]; then 
    exitcode=0 
    if [ "$MAIN" -nt "$COPY" ]; then
        rsync -avu --delete --inplace $MAIN $COPY;
        #rsync --modify-window 1 -a --delete --no-o --no-p --no-g $MAIN $COPY;
    elif [ "$COPY" -nt "$MAIN" ]; then
        rsync -avu --delete --inplace $COPY $MAIN;
        #rsync --modify-window 1 -a --delete --no-o --no-p --no-g $COPY $MAIN;
    else
        echo "Here is nothing to sync :)"
    fi
else
echo "The folders does not exist."
# If folders does not exist, exit with exitcode=1
exit $exitcode
fi
exit $exitcode