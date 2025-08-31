#!/bin/bash
echo "🔎 Orphaned processes:"
ps -eo pid,ppid,comm | awk '$2==1 {print "⚠️ Orphan:", $0}'
