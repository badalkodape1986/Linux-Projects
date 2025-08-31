#!/bin/bash
LOGFILE="/var/log/nginx/access.log"
echo "🌐 Top 5 requested URLs:"
awk '{print $7}' $LOGFILE | sort | uniq -c | sort -nr | head -5
echo "🌐 Top 5 client IPs:"
awk '{print $1}' $LOGFILE | sort | uniq -c | sort -nr | head -5
