#!/bin/bash
set -e
HOST=${1:-"google.com"}
echo "🌐 Checking connectivity to $HOST..."
ping -c 3 $HOST > /dev/null && echo "✅ Ping successful" || echo "❌ Ping failed"
echo "🔎 Checking DNS resolution..."
nslookup $HOST &>/dev/null && echo "✅ DNS works" || echo "❌ DNS failed"
echo "📡 Checking open ports..."
for port in 22 80 443; do
  nc -zv $HOST $port &>/dev/null && echo "✅ Port $port open" || echo "⚠️ Port $port closed"
done
