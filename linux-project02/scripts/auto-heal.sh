#!/bin/bash
SERVICES=("nginx" "docker")
for svc in "${SERVICES[@]}"; do
  if systemctl is-active --quiet $svc; then
    echo "✅ $svc is running"
  else
    echo "⚠️ $svc is not running, restarting..."
    sudo systemctl restart $svc
    if systemctl is-active --quiet $svc; then
      echo "✅ $svc restarted successfully"
    else
      echo "❌ Failed to restart $svc"
    fi
  fi
done
