#!/bin/bash
if ! command -v iostat &> /dev/null; then
  echo "📥 Installing sysstat (for iostat)..."
  sudo apt install -y sysstat
fi
IOWAIT=$(iostat -c 1 2 | awk '/avg-cpu/ {getline; print $4}')
echo "📊 I/O Wait: $IOWAIT%"
if (( $(echo "$IOWAIT > 20" | bc -l) )); then
  echo "⚠️ High disk I/O wait detected"
fi
