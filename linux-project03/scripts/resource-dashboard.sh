#!/bin/bash
while true; do
  clear
  echo "📊 Resource Dashboard - $(date)"
  echo "----------------------------------"
  echo "CPU:    $(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')%"
  echo "Memory: $(free -m | awk 'NR==2{printf \"%.2f%% of %sMB\", $3*100/$2, $2}')"
  echo "Disk:   $(df -h / | awk 'NR==2{print $5 \" used of \"$2}')"
  if command -v ifstat &>/dev/null; then
    echo "Network: $(ifstat 1 1 | awk 'NR==3 {print \"IN: \"$1\"KB/s | OUT: \"$2\"KB/s\"}')"
  fi
  sleep 2
done
