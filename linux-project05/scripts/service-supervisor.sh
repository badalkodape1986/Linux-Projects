#!/bin/bash
SERVICE="nginx"

while true; do
  if ! systemctl is-active --quiet $SERVICE; then
    echo "⚠️ $SERVICE is down, restarting..."
    sudo systemctl restart $SERVICE
    echo "$(date): $SERVICE restarted" >> service-supervisor.log
  fi
  sleep 10
done
