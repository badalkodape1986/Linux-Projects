#!/bin/bash
# 🚀 Create Linux Automation & Troubleshooting Projects
# This script creates README + 14 Linux project scripts in one go

set -e

# Create folder
mkdir -p linux-project01/scripts

# Create README.md
cat > linux-project01/README.md <<'EOF'
# DevOps Basics Projects (Linux Automation & Troubleshooting)

This folder contains **Linux automation & troubleshooting scripts** useful for DevOps, SRE, and SysAdmin roles.

## 🚀 Projects
1. **Setup Server** – Install Docker, Git, Nginx automatically.
2. **Backup Script** – Archive important files daily with cron.
3. **System Monitor** – Logs CPU, memory, disk usage.
4. **User Management** – Automates user/group creation.
5. **Firewall Setup** – Configures UFW with secure defaults.
6. **Disk Usage Alert** – Warns when disk usage is > threshold.
7. **Service Health Check** – Restarts services if stopped.
8. **Kill High-CPU Processes** – Cleans runaway processes.
9. **Network Diagnose** – Ping, DNS check, open port check.
10. **Log Analyzer** – Detects errors & failed logins from logs.
11. **Auto-Heal Services** – Restart failed services automatically.
12. **Process Troubleshooter** – Identify top CPU/memory hogs.
13. **Disk Cleanup** – Automates freeing disk space.
14. **System Info** – Quick system & kernel diagnostic.

## 📘 Skills Learned
- Linux troubleshooting
- Bash scripting
- Monitoring & self-healing systems
- Security & firewall automation
- Log analysis & disk maintenance
EOF

# --- Scripts ---

# 1. Setup Server
cat > linux-project01/scripts/setup-server.sh <<'EOF'
#!/bin/bash
set -e
echo "🔄 Updating system..."
sudo apt update && sudo apt upgrade -y
echo "📦 Installing common tools..."
sudo apt install -y git curl wget htop unzip
echo "🐳 Installing Docker..."
sudo apt install -y docker.io
sudo systemctl enable docker
sudo usermod -aG docker $USER
echo "🌐 Installing Nginx..."
sudo apt install -y nginx
sudo systemctl enable nginx
echo "✅ Server setup complete!"
EOF

# 2. Backup Script
cat > linux-project01/scripts/backup.sh <<'EOF'
#!/bin/bash
set -e
SOURCE_DIR="/home/$USER/data"
BACKUP_DIR="/home/$USER/backups"
TIMESTAMP=$(date +%F_%H-%M-%S)
mkdir -p "$BACKUP_DIR"
tar -czf "$BACKUP_DIR/data_backup_$TIMESTAMP.tar.gz" "$SOURCE_DIR"
echo "✅ Backup completed: $BACKUP_DIR/data_backup_$TIMESTAMP.tar.gz"
EOF

# 3. System Monitor
cat > linux-project01/scripts/system-monitor.sh <<'EOF'
#!/bin/bash
LOGFILE="system_usage.log"
echo "⏱️ $(date)" >> $LOGFILE
echo "CPU: $(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')%" >> $LOGFILE
echo "Memory: $(free -m | awk 'NR==2{printf \"%.2f%%\", $3*100/$2 }')" >> $LOGFILE
echo "Disk: $(df -h / | awk 'NR==2 {print $5}')" >> $LOGFILE
echo "-----------------------------------" >> $LOGFILE
echo "✅ System usage logged to $LOGFILE"
EOF

# 4. User Management
cat > linux-project01/scripts/user-management.sh <<'EOF'
#!/bin/bash
set -e
if [ $# -lt 2 ]; then
  echo "Usage: $0 <username> <group>"
  exit 1
fi
USERNAME=$1
GROUP=$2
if ! getent group $GROUP >/dev/null; then
  sudo groupadd $GROUP
  echo "✅ Group $GROUP created"
fi
if id "$USERNAME" &>/dev/null; then
  echo "⚠️ User $USERNAME already exists"
else
  sudo useradd -m -s /bin/bash -g $GROUP $USERNAME
  echo "✅ User $USERNAME created and added to group $GROUP"
fi
EOF

# 5. Firewall Setup
cat > linux-project01/scripts/firewall-setup.sh <<'EOF'
#!/bin/bash
set -e
echo "🔒 Setting up firewall rules..."
sudo ufw default deny incoming
[Osudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable
echo "✅ Firewall configured (SSH, HTTP, HTTPS allowed)"
EOF

# 6. Disk Alert
cat > linux-project01/scripts/disk-alert.sh <<'EOF'
#!/bin/bash
THRESHOLD=80
USAGE=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')
if [ $USAGE -gt $THRESHOLD ]; then
  echo "⚠️ Disk usage is at ${USAGE}% (threshold ${THRESHOLD}%)"
else
  echo "✅ Disk usage is normal: ${USAGE}%"
fi
EOF

# 7. Service Check
cat > linux-project01/scripts/service-check.sh <<'EOF'
#!/bin/bash
SERVICE=$1
if [ -z "$SERVICE" ]; then
  echo "Usage: $0 <service-name>"
  exit 1
fi
if systemctl is-active --quiet $SERVICE; then
  echo "✅ $SERVICE is running"
else
  echo "⚠️ $SERVICE is not running, restarting..."
  sudo systemctl start $SERVICE
  if systemctl is-active --quiet $SERVICE; then
    echo "✅ $SERVICE restarted successfully"
  else
    echo "❌ Failed to restart $SERVICE"
  fi
fi
EOF

# 8. Kill High-CPU Processes
cat > linux-project01/scripts/kill-high-cpu.sh <<'EOF'
#!/bin/bash
THRESHOLD=50
echo "🔎 Checking for processes above ${THRESHOLD}% CPU usage..."
ps -eo pid,comm,%cpu --sort=-%cpu | awk -v th=$THRESHOLD '$3 > th {print $1, $2, $3}' | while read pid cmd cpu; do
  echo "⚠️ Killing $cmd (PID $pid) using $cpu% CPU"
  sudo kill -9 $pid
done
echo "✅ Cleanup complete"
EOF

# 9. Network Diagnose
cat > linux-project01/scripts/network-diagnose.sh <<'EOF'
#!/bin/bash
set -e
HOST=${1:-"google.com"}
echo "🌐 Checking connectivity to $HOST..."
ping -c 3 $HOST > /dev/null && echo "✅ Ping successful" || echo "❌ Ping failed"
echo "🔎 Checking DNS resolution..."
nslookup $HOST &>/dev/null && echo "✅ DNS works" || echo "❌ DNS failed"
echo "📡 Checking open ports..."
for port in 22 80 443; do
  nc -zv $HOST $port &>/dev/null && echo "✅ Port $port open" || echo "⚠️ Port $port closed"
done
EOF

# 10. Log Analyzer
cat > linux-project01/scripts/log-analyzer.sh <<'EOF'
#!/bin/bash
LOGFILE="/var/log/syslog"
echo "🔎 Analyzing logs from $LOGFILE..."
echo "⚠️ Top 5 errors:"
grep -i "error" $LOGFILE | head -n 5
echo "⚠️ Failed SSH logins:"
grep "Failed password" /var/log/auth.log | wc -l
EOF

# 11. Auto-Heal Services
cat > linux-project01/scripts/auto-heal.sh <<'EOF'
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
EOF

# 12. Process Troubleshooter
cat > linux-project01/scripts/process-troubleshoot.sh <<'EOF'
#!/bin/bash
echo "🔎 Top 5 CPU-consuming processes:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo "🔎 Top 5 memory-consuming processes:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
EOF

# 13. Disk Cleanup
cat > linux-project01/scripts/disk-cleanup.sh <<'EOF'
#!/bin/bash
set -e
echo "🧹 Cleaning /tmp..."
sudo rm -rf /tmp/*
echo "🧹 Cleaning old logs..."
sudo find /var/log -type f -name "*.log" -mtime +7 -exec rm -f {} \;
echo "🧹 Cleaning apt cache..."
sudo apt-get clean
echo "✅ Disk cleanup complete"
EOF

# 14. System Info
cat > linux-project01/scripts/sys-info.sh <<'EOF'
#!/bin/bash
echo "🖥️ System Info:"
uname -a
echo "🔧 Kernel: $(uname -r)"
echo "🧠 Memory: $(free -h | awk 'NR==2{print $2}')"
echo "💾 Disk: $(df -h / | awk 'NR==2 {print $2}')"
echo "👤 Logged-in users: $(who | wc -l)"
EOF

# Make all scripts executable
chmod +x linux-project01/scripts/*.sh

echo "🎉 Linux troubleshooting & automation projects created successfully!"

