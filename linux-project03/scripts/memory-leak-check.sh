#!/bin/bash
echo "🔎 Checking top memory-hogging processes..."
ps -eo pid,comm,%mem --sort=-%mem | head -n 10
