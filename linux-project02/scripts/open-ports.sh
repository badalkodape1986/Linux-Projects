#!/bin/bash
echo "🔎 Scanning open TCP ports..."
sudo ss -tulnp | awk 'NR>1 {print $1, $5, $7}'
