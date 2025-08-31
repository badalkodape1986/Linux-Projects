#!/bin/bash
echo "🔎 Top 5 processes by network usage:"
sudo netstat -tunp | awk '{print $7}' | sort | uniq -c | sort -nr | head -5
