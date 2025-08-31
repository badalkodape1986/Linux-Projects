#!/bin/bash
if ! command -v smartctl &> /dev/null; then
  echo "📥 Installing smartmontools..."
  sudo apt install -y smartmontools
fi
for disk in /dev/sd[a-z]; do
  echo "🔎 Checking health of $disk..."
  sudo smartctl -H $disk | grep "SMART overall-health"
done
