#!/bin/bash
echo "⚠️ Simulating incident: stopping nginx..."
sudo systemctl stop nginx
sleep 2

if ! systemctl is-active --quiet nginx; then
  echo "✅ Incident detected: nginx is down"
  echo "♻️ Restarting nginx..."
  sudo systemctl start nginx
  systemctl is-active --quiet nginx && echo "✅ nginx recovered" || echo "❌ nginx failed to restart"
fi
