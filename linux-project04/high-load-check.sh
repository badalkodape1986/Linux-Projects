#!/bin/bash
THRESHOLD=5.0
LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | xargs)

if (( $(echo "$LOAD > $THRESHOLD" | bc -l) )); then
  echo "⚠️ High system load detected: $LOAD (threshold $THRESHOLD)"
else
  echo "✅ Load normal: $LOAD"
fi
