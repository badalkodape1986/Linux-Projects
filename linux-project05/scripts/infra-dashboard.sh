#!/bin/bash
while true; do
  clear
  echo "📊 Infra Dashboard - $(date)"
  echo "----------------------------------"
  echo "CPU:    $(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')%"
  echo "Memory: $(free -m | awk 'NR==2{printf \"%.2f%% of %sMB\", $3*100/$2, $2}')"
  echo "Disk:   $(df -h / | awk 'NR==2{print $5 \" used of \"$2}')"
  echo "Load:   $(uptime | awk -F'load average:' '{ print $2 }')"
  echo "Top Processes:"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
  sleep 5
done
