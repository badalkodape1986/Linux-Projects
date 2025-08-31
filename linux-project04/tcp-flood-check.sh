#!/bin/bash
echo "🔎 Top IPs by TCP connections:"
sudo netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head -5
