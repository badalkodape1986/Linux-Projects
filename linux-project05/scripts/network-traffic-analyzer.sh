#!/bin/bash
if ! command -v iftop &>/dev/null; then
  echo "📥 Installing iftop..."
  sudo apt install -y iftop
fi
echo "📡 Top network connections (press q to quit):"
sudo iftop -n -P
