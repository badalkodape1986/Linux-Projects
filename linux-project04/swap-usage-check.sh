#!/bin/bash
THRESHOLD=80
USAGE=$(free | awk '/Swap/ {if ($2>0) printf("%.0f", $3/$2*100); else print 0}')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
  echo "⚠️ Swap usage critical: $USAGE%"
else
  echo "✅ Swap usage normal: $USAGE%"
fi
