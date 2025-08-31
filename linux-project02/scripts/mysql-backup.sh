#!/bin/bash
USER="root"
PASSWORD="yourpassword"
BACKUP_DIR="/home/$USER/db_backups"
TIMESTAMP=$(date +%F_%H-%M-%S)
mkdir -p $BACKUP_DIR
mysqldump -u $USER -p$PASSWORD --all-databases > $BACKUP_DIR/mysql_backup_$TIMESTAMP.sql
echo "✅ MySQL backup saved: $BACKUP_DIR/mysql_backup_$TIMESTAMP.sql"
