#!/bin/bash
DEPENDENCIES=("docker" "nginx")
for svc in "${DEPENDENCIES[@]}"; do
  if systemctl is-active --quiet $svc; then
    echo "✅ $svc is running"
  else
    echo "❌ Dependency $svc is not running"
    exit 1
  fi
done
echo "🚀 All dependencies satisfied, app can start"
