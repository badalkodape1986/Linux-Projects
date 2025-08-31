#!/bin/bash
set -e
echo "🧹 Cleaning /tmp..."
sudo rm -rf /tmp/*
echo "🧹 Cleaning old logs..."
sudo find /var/log -type f -name "*.log" -mtime +7 -exec rm -f {} \;
echo "🧹 Cleaning apt cache..."
sudo apt-get clean
echo "✅ Disk cleanup complete"
