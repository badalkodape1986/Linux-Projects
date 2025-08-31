#!/bin/bash
# 🚀 Create Advanced Linux Projects (Incident Handling, Monitoring, Security, Optimization)
# Author: You 😎

set -e
SCRIPTS_DIR="01-devops-basics/scripts"
mkdir -p "$SCRIPTS_DIR"

# 1. Incident Simulation & Recovery
cat > $SCRIPTS_DIR/incident-simulator.sh <<'EOF'
#!/bin/bash
echo "⚠️ Simulating incident: stopping nginx..."
sudo systemctl stop nginx
sleep 2

if ! systemctl is-active --quiet nginx; then
  echo "✅ Incident detected: nginx is down"
  echo "♻️ Restarting nginx..."
  sudo systemctl start nginx
  systemctl is-active --quiet nginx && echo "✅ nginx recovered" || echo "❌ nginx failed to restart"
fi
EOF

# 2. Log Rotation & Archiving
cat > $SCRIPTS_DIR/log-rotation.sh <<'EOF'
#!/bin/bash
LOG_DIR="/var/log"
ARCHIVE_DIR="/var/archive"
mkdir -p $ARCHIVE_DIR

echo "♻️ Rotating logs in $LOG_DIR..."
for file in $LOG_DIR/*.log; do
  if [ -f "$file" ]; then
    TIMESTAMP=$(date +%F_%H-%M-%S)
    gzip -c "$file" > "$ARCHIVE_DIR/$(basename $file)_$TIMESTAMP.gz"
    : > "$file"
    echo "✅ Rotated $file"
  fi
done

find $ARCHIVE_DIR -type f -mtime +30 -exec rm -f {} \;
echo "✅ Old logs cleaned (kept 30 days)"
EOF

# 3. Alerting Framework
cat > $SCRIPTS_DIR/alerting.sh <<'EOF'
#!/bin/bash
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
MEM=$(free | awk '/Mem/{printf("%.0f"), $3/$2*100}')
DISK=$(df -h / | awk 'NR==2 {print $5}' | sed 's/%//')

if [ "$CPU" -gt 80 ] || [ "$MEM" -gt 90 ] || [ "$DISK" -gt 85 ]; then
  echo "⚠️ Alert: High usage detected! CPU=$CPU% MEM=$MEM% DISK=$DISK%" | mail -s "Linux Alert" root@localhost
  echo "✅ Alert sent"
else
  echo "✅ System usage normal"
fi
EOF

# 4. Distributed File Sync
cat > $SCRIPTS_DIR/file-sync.sh <<'EOF'
#!/bin/bash
SRC="/home/$USER/data/"
DEST="backup@192.168.1.100:/home/backup/data/"
rsync -avz --delete $SRC $DEST
echo "✅ Files synced from $SRC to $DEST"
EOF

# 5. Service Supervisor
cat > $SCRIPTS_DIR/service-supervisor.sh <<'EOF'
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
EOF

# 6. Network Traffic Analyzer
cat > $SCRIPTS_DIR/network-traffic-analyzer.sh <<'EOF'
#!/bin/bash
if ! command -v iftop &>/dev/null; then
  echo "📥 Installing iftop..."
  sudo apt install -y iftop
fi
echo "📡 Top network connections (press q to quit):"
sudo iftop -n -P
EOF

# 7. Backup Verification
cat > $SCRIPTS_DIR/verify-backups.sh <<'EOF'
#!/bin/bash
FILE=$1
if [ -z "$FILE" ]; then
  echo "Usage: $0 <backup-file>"
  exit 1
fi

if [[ $FILE == *.tar.gz ]]; then
  tar -tzf $FILE >/dev/null && echo "✅ Backup $FILE is valid" || echo "❌ Backup corrupted"
elif [[ $FILE == *.sql ]]; then
  mysql -u root -p -e "SOURCE $FILE" testdb && echo "✅ SQL Backup valid" || echo "❌ SQL Backup failed"
else
  echo "⚠️ Unsupported file type"
fi
EOF

# 8. Sysctl Tuner
cat > $SCRIPTS_DIR/sysctl-tuner.sh <<'EOF'
#!/bin/bash
echo "🔧 Tuning kernel parameters..."
sudo sysctl -w fs.file-max=2097152
sudo sysctl -w net.ipv4.ip_forward=1
sudo sysctl -w net.ipv4.tcp_fin_timeout=15
sudo sysctl -p
echo "✅ Kernel parameters tuned"
EOF

# 9. Patch Manager
cat > $SCRIPTS_DIR/patch-manager.sh <<'EOF'
#!/bin/bash
echo "🔄 Checking for security updates..."
sudo apt update
sudo apt list --upgradable | grep security
echo "📥 Applying security patches..."
sudo unattended-upgrade
EOF

# 10. Infra Dashboard
cat > $SCRIPTS_DIR/infra-dashboard.sh <<'EOF'
#!/bin/bash
while true; do
  clear
  echo "📊 Infra Dashboard - $(date)"
  echo "----------------------------------"
  echo "CPU:    $(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')%"
  echo "Memory: $(free -m | awk 'NR==2{printf \"%.2f%% of %sMB\", $3*100/$2, $2}')"
  echo "Disk:   $(df -h / | awk 'NR==2{print $5 \" used of \"$2}')"
  echo "Load:   $(uptime | awk -F'load average:' '{ print $2 }')"
  echo "Top Processes:"
  ps -eo pid,comm,%cpu,%mem --sort=-%cpu | head -n 6
  sleep 5
done
EOF

# Make all executable
chmod +x $SCRIPTS_DIR/*.sh

echo "🎉 Advanced Linux projects created successfully!"

