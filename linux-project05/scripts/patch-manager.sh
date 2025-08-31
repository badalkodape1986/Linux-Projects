#!/bin/bash
echo "🔄 Checking for security updates..."
sudo apt update
sudo apt list --upgradable | grep security
echo "📥 Applying security patches..."
sudo unattended-upgrade
