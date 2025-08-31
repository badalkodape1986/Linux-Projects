#!/bin/bash
echo "🔄 Checking for updates..."
UPDATES=$(apt list --upgradeable 2>/dev/null | tail -n +2)
if [ -z "$UPDATES" ]; then
  echo "✅ System is up to date"
else
  echo "⚠️ Updates available:"
  echo "$UPDATES"
fi
