#!/bin/bash
ZOMBIES=$(ps aux | awk '{ if ($8=="Z") print $0 }')
if [ -z "$ZOMBIES" ]; then
  echo "✅ No zombie processes found"
else
  echo "⚠️ Zombie processes detected:"
  echo "$ZOMBIES"
fi
