#!/bin/bash
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM=$(free | awk '/Mem/{printf("%.0f"), $3/$2*100}')
DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$CPU" -gt 80 ] || [ "$MEM" -gt 90 ] || [ "$DISK" -gt 85 ]; then
  echo "⚠️ Alert: High usage detected! CPU=$CPU% MEM=$MEM% DISK=$DISK%" | mail -s "Linux Alert" root@localhost
  echo "✅ Alert sent"
else
  echo "✅ System usage normal"
fi
