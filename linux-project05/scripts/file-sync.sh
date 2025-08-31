#!/bin/bash
SRC="/home/$USER/data/"
DEST="backup@192.168.1.100:/home/backup/data/"
rsync -avz --delete $SRC $DEST
echo "✅ Files synced from $SRC to $DEST"
