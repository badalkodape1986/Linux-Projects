#!/bin/bash
LOGFILE="/var/log/syslog"
echo "🔎 Failed cron jobs in last 24h:"
grep CRON $LOGFILE | grep "exit status" | tail -20
