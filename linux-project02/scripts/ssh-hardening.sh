#!/bin/bash
set -e
SSHD_CONFIG="/etc/ssh/sshd_config"
echo "🔒 Securing SSH..."
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' $SSHD_CONFIG
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' $SSHD_CONFIG
sudo systemctl restart sshd
echo "✅ SSH hardened"
