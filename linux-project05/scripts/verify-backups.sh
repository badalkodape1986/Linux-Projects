#!/bin/bash
FILE=$1
if [ -z "$FILE" ]; then
  echo "Usage: $0 <backup-file>"
  exit 1
fi

if [[ $FILE == *.tar.gz ]]; then
  tar -tzf $FILE >/dev/null && echo "✅ Backup $FILE is valid" || echo "❌ Backup corrupted"
elif [[ $FILE == *.sql ]]; then
  mysql -u root -p -e "SOURCE $FILE" testdb && echo "✅ SQL Backup valid" || echo "❌ SQL Backup failed"
else
  echo "⚠️ Unsupported file type"
fi
