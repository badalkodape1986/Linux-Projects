#!/bin/bash
LOGFILE="/var/log/syslog"
echo "🔎 Analyzing logs from $LOGFILE..."
echo "⚠️ Top 5 errors:"
grep -i "error" $LOGFILE | head -n 5
echo "⚠️ Failed SSH logins:"
grep "Failed password" /var/log/auth.log | wc -l
