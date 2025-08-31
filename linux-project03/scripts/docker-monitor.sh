#!/bin/bash
if ! command -v docker &>/dev/null; then
  echo "❌ Docker not installed"
  exit 1
fi
echo "🐳 Active Docker containers:"
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
echo "📊 Container resource usage:"
docker stats --no-stream
