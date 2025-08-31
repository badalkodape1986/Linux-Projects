#!/bin/bash
LOG_DIR="/var/log"
ARCHIVE_DIR="/var/archive"
mkdir -p $ARCHIVE_DIR

echo "♻️ Rotating logs in $LOG_DIR..."
for file in $LOG_DIR/*.log; do
  if [ -f "$file" ]; then
    TIMESTAMP=$(date +%F_%H-%M-%S)
    gzip -c "$file" > "$ARCHIVE_DIR/$(basename $file)_$TIMESTAMP.gz"
    : > "$file"
    echo "✅ Rotated $file"
  fi
done

find $ARCHIVE_DIR -type f -mtime +30 -exec rm -f {} \;
echo "✅ Old logs cleaned (kept 30 days)"
