#!/bin/bash
if ! command -v speedtest-cli &> /dev/null; then
  echo "📥 Installing speedtest-cli..."
  sudo apt install -y speedtest-cli
fi
echo "🌐 Running internet speed test..."
speedtest-cli --simple
