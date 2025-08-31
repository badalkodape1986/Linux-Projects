#!/bin/bash
LOG="/var/log/kern.log"
echo "🔎 Checking for kernel panics in $LOG..."
grep -i "panic" $LOG || echo "✅ No kernel panics found"
