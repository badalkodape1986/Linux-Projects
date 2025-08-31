#!/bin/bash
echo "🔎 Checking for port collisions..."
sudo ss -tulnp | awk '{print $5}' | sort | uniq -c | awk '$1 > 1 {print "⚠️ Port conflict:", $0}'
