#!/bin/bash
echo "🔎 Checking for hung processes (D state)..."
ps -eo pid,stat,comm | awk '$2 ~ /D/ {print "⚠️ Hung: "$0}'
