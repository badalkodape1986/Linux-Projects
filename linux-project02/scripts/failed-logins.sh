#!/bin/bash
LOGFILE="/var/log/auth.log"
echo "🔐 Failed login attempts summary:"
grep "Failed password" $LOGFILE | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | head
