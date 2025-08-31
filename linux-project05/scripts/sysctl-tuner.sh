#!/bin/bash
echo "🔧 Tuning kernel parameters..."
sudo sysctl -w fs.file-max=2097152
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv4.tcp_fin_timeout=15
sudo sysctl -p
echo "✅ Kernel parameters tuned"
