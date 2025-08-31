#!/bin/bash
# 🚀 All-in-One Script: Create Linux Automation, Troubleshooting & Security Projects
# Author: You 😎

set -e
SCRIPTS_DIR="linux-project02/scripts"
mkdir -p "$SCRIPTS_DIR"

# =========================
# README.md
# =========================
cat > linux-project02/README.md <<'EOF'
# DevOps Basics Projects (Linux Automation, Troubleshooting, Security)

This folder contains **Linux automation & troubleshooting scripts** useful for DevOps, SRE, and SysAdmin roles.

## 🚀 Categories & Projects

### 🔒 Security
- **SSH Hardening** – Disable root login, enforce key-based auth
- **Firewall Setup** – Configure UFW rules
- **Failed Logins Detector** – Find brute-force login attempts

### 📊 Monitoring & Troubleshooting
- **System Monitor** – CPU, RAM, Disk usage logs
- **Network Diagnose** – Ping, DNS, port connectivity
- **Log Analyzer** – Detect errors & failed SSH attempts
- **Open Ports Scanner** – Active listening ports
- **Process Troubleshooter** – Find top CPU/mem processes
- **Service Health Check** – Restart if services stop
- **Auto-Heal Services** – Self-healing infra

### ⚙️ Automation
- **Setup Server** – Install Docker, Nginx, Git
- **Backup Script** – Daily backup with cron
- **MySQL Backup** – Dump all databases
- **Archive Old Files** – Move old files to archive
- **Disk Cleanup** – Free up space
- **Cron Manager** – Add/remove/list jobs

### 🌐 Networking
- **Speed Test** – Internet performance check
- **Service Dependency Checker** – Validate before deploy

### 🛠️ Resilience
- **Disk Usage Alert** – Warn if usage > threshold
- **Kill High-CPU Processes** – Clean runaway apps
- **System Info** – Quick OS & kernel info

EOF

# =========================
# Scripts
# =========================

# 1. Setup Server
cat > $SCRIPTS_DIR/setup-server.sh <<'EOF'
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
cat > $SCRIPTS_DIR/backup.sh <<'EOF'
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
cat > $SCRIPTS_DIR/system-monitor.sh <<'EOF'
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
cat > $SCRIPTS_DIR/user-management.sh <<'EOF'
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
cat > $SCRIPTS_DIR/firewall-setup.sh <<'EOF'
#!/bin/bash
set -e
echo "🔒 Setting up firewall rules..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow 22/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw --force enable
echo "✅ Firewall configured (SSH, HTTP, HTTPS allowed)"
EOF

# 6. Disk Alert
cat > $SCRIPTS_DIR/disk-alert.sh <<'EOF'
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
cat > $SCRIPTS_DIR/service-check.sh <<'EOF'
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

# 8. Kill High-CPU
cat > $SCRIPTS_DIR/kill-high-cpu.sh <<'EOF'
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
cat > $SCRIPTS_DIR/network-diagnose.sh <<'EOF'
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
cat > $SCRIPTS_DIR/log-analyzer.sh <<'EOF'
#!/bin/bash
LOGFILE="/var/log/syslog"
echo "🔎 Analyzing logs from $LOGFILE..."
echo "⚠️ Top 5 errors:"
grep -i "error" $LOGFILE | head -n 5
echo "⚠️ Failed SSH logins:"
grep "Failed password" /var/log/auth.log | wc -l
EOF

# 11. Auto-Heal
cat > $SCRIPTS_DIR/auto-heal.sh <<'EOF'
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
cat > $SCRIPTS_DIR/process-troubleshoot.sh <<'EOF'
#!/bin/bash
echo "🔎 Top 5 CPU-consuming processes:"
ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6
echo "🔎 Top 5 memory-consuming processes:"
ps -eo pid,comm,%mem --sort=-%mem | head -n 6
EOF

# 13. Disk Cleanup
cat > $SCRIPTS_DIR/disk-cleanup.sh <<'EOF'
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
cat > $SCRIPTS_DIR/sys-info.sh <<'EOF'
#!/bin/bash
echo "🖥️ System Info:"
uname -a
echo "🔧 Kernel: $(uname -r)"
echo "🧠 Memory: $(free -h | awk 'NR==2{print $2}')"
echo "💾 Disk: $(df -h / | awk 'NR==2 {print $2}')"
echo "👤 Logged-in users: $(who | wc -l)"
EOF

# 15. SSH Hardening
cat > $SCRIPTS_DIR/ssh-hardening.sh <<'EOF'
#!/bin/bash
set -e
SSHD_CONFIG="/etc/ssh/sshd_config"
echo "🔒 Securing SSH..."
sudo sed -i 's/^#*PermitRootLogin.*/PermitRootLogin no/' $SSHD_CONFIG
sudo sed -i 's/^#*PasswordAuthentication.*/PasswordAuthentication no/' $SSHD_CONFIG
sudo systemctl restart sshd
echo "✅ SSH hardened"
EOF

# 16. Open Ports
cat > $SCRIPTS_DIR/open-ports.sh <<'EOF'
#!/bin/bash
echo "🔎 Scanning open TCP ports..."
sudo ss -tulnp | awk 'NR>1 {print $1, $5, $7}'
EOF

# 17. Failed Logins
cat > $SCRIPTS_DIR/failed-logins.sh <<'EOF'
#!/bin/bash
LOGFILE="/var/log/auth.log"
echo "🔐 Failed login attempts summary:"
grep "Failed password" $LOGFILE | awk '{print $(NF-3)}' | sort | uniq -c | sort -nr | head
EOF

# 18. Web Log Analyzer
cat > $SCRIPTS_DIR/web-log-analyzer.sh <<'EOF'
#!/bin/bash
LOGFILE="/var/log/nginx/access.log"
echo "🌐 Top 5 requested URLs:"
awk '{print $7}' $LOGFILE | sort | uniq -c | sort -nr | head -5
echo "🌐 Top 5 client IPs:"
awk '{print $1}' $LOGFILE | sort | uniq -c | sort -nr | head -5
EOF

# 19. Cron Manager
cat > $SCRIPTS_DIR/cron-manager.sh <<'EOF'
#!/bin/bash
case $1 in
  list) crontab -l ;;
  add)  (crontab -l; echo "$2") | crontab -; echo "✅ Cron job added: $2" ;;
  remove) crontab -r; echo "✅ All cron jobs removed" ;;
  *) echo "Usage: $0 {list|add '<cron expr>'|remove}" ;;
esac
EOF

# 20. Speed Test
cat > $SCRIPTS_DIR/speed-test.sh <<'EOF'
#!/bin/bash
if ! command -v speedtest-cli &> /dev/null; then
  echo "📥 Installing speedtest-cli..."
  sudo apt install -y speedtest-cli
fi
echo "🌐 Running internet speed test..."
speedtest-cli --simple
EOF

# 21. MySQL Backup
cat > $SCRIPTS_DIR/mysql-backup.sh <<'EOF'
#!/bin/bash
USER="root"
PASSWORD="yourpassword"
BACKUP_DIR="/home/$USER/db_backups"
TIMESTAMP=$(date +%F_%H-%M-%S)
mkdir -p $BACKUP_DIR
mysqldump -u $USER -p$PASSWORD --all-databases > $BACKUP_DIR/mysql_backup_$TIMESTAMP.sql
echo "✅ MySQL backup saved: $BACKUP_DIR/mysql_backup_$TIMESTAMP.sql"
EOF

# 22. Archive Old Files
cat > $SCRIPTS_DIR/archive-old-files.sh <<'EOF'
#!/bin/bash
TARGET_DIR="/home/$USER/data"
ARCHIVE_DIR="/home/$USER/archive"
mkdir -p $ARCHIVE_DIR
find $TARGET_DIR -type f -mtime +30 -exec mv {} $ARCHIVE_DIR/ \;
echo "📦 Archived old files (>30 days) to $ARCHIVE_DIR"
EOF

# 23. Service Dependency Checker
cat > $SCRIPTS_DIR/service-deps.sh <<'EOF'
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
EOF

# Make all executable
chmod +x $SCRIPTS_DIR/*.sh

echo "🎉 All Linux troubleshooting, automation & security scripts created!"

