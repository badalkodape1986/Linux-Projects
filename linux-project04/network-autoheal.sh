#!/bin/bash
HOST="8.8.8.8"
if ping -c 2 $HOST > /dev/null; then
  echo "✅ Network is up"
else
  echo "⚠️ Network down, restarting networking service..."
  sudo systemctl restart NetworkManager || sudo systemctl restart networking
fi
