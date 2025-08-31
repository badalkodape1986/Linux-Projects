#!/bin/bash
TARGET_DIR="/home/$USER/data"
ARCHIVE_DIR="/home/$USER/archive"
mkdir -p $ARCHIVE_DIR
find $TARGET_DIR -type f -mtime +30 -exec mv {} $ARCHIVE_DIR/ \;
echo "📦 Archived old files (>30 days) to $ARCHIVE_DIR"
