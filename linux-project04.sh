#!/bin/bash
# 🚀 Create Real-Time Linux Troubleshooting & Monitoring Projects
# Author: You 😎

set -e
SCRIPTS_DIR="linux-project04"
mkdir -p "$SCRIPTS_DIR"

# 1. High Load Detector
cat > $SCRIPTS_DIR/high-load-check.sh <<'EOF'
#!/bin/bash
THRESHOLD=5.0
LOAD=$(uptime | awk -F'load average:' '{ print $2 }' | cut -d, -f1 | xargs)

if (( $(echo "$LOAD > $THRESHOLD" | bc -l) )); then
  echo "⚠️ High system load detected: $LOAD (threshold $THRESHOLD)"
else
  echo "✅ Load normal: $LOAD"
fi
EOF

# 2. Network Auto-Healer
cat > $SCRIPTS_DIR/network-autoheal.sh <<'EOF'
#!/bin/bash
HOST="8.8.8.8"
if ping -c 2 $HOST > /dev/null; then
  echo "✅ Network is up"
else
  echo "⚠️ Network down, restarting networking service..."
  sudo systemctl restart NetworkManager || sudo systemctl restart networking
fi
EOF

# 3. Top Network Processes
cat > $SCRIPTS_DIR/top-network-processes.sh <<'EOF'
#!/bin/bash
echo "🔎 Top 5 processes by network usage:"
sudo netstat -tunp | awk '{print $7}' | sort | uniq -c | sort -nr | head -5
EOF

# 4. Swap Usage Alert
cat > $SCRIPTS_DIR/swap-usage-check.sh <<'EOF'
#!/bin/bash
THRESHOLD=80
USAGE=$(free | awk '/Swap/ {if ($2>0) printf("%.0f", $3/$2*100); else print 0}')

if [ "$USAGE" -ge "$THRESHOLD" ]; then
  echo "⚠️ Swap usage critical: $USAGE%"
else
  echo "✅ Swap usage normal: $USAGE%"
fi
EOF

# 5. Hung Process Detector
cat > $SCRIPTS_DIR/hung-process-check.sh <<'EOF'
#!/bin/bash
echo "🔎 Checking for hung processes (D state)..."
ps -eo pid,stat,comm | awk '$2 ~ /D/ {print "⚠️ Hung: "$0}'
EOF

# 6. Cron Failures
cat > $SCRIPTS_DIR/cron-failures.sh <<'EOF'
#!/bin/bash
LOGFILE="/var/log/syslog"
echo "🔎 Failed cron jobs in last 24h:"
grep CRON $LOGFILE | grep "exit status" | tail -20
EOF

# 7. Port Collision Check
cat > $SCRIPTS_DIR/port-collision-check.sh <<'EOF'
#!/bin/bash
echo "🔎 Checking for port collisions..."
sudo ss -tulnp | awk '{print $5}' | sort | uniq -c | awk '$1 > 1 {print "⚠️ Port conflict:", $0}'
EOF

# 8. Disk I/O Check
cat > $SCRIPTS_DIR/disk-io-check.sh <<'EOF'
#!/bin/bash
if ! command -v iostat &> /dev/null; then
  echo "📥 Installing sysstat (for iostat)..."
  sudo apt install -y sysstat
fi
IOWAIT=$(iostat -c 1 2 | awk '/avg-cpu/ {getline; print $4}')
echo "📊 I/O Wait: $IOWAIT%"
if (( $(echo "$IOWAIT > 20" | bc -l) )); then
  echo "⚠️ High disk I/O wait detected"
fi
EOF

# 9. Orphan Process Checker
cat > $SCRIPTS_DIR/orphan-process-check.sh <<'EOF'
#!/bin/bash
echo "🔎 Orphaned processes:"
ps -eo pid,ppid,comm | awk '$2==1 {print "⚠️ Orphan:", $0}'
EOF

# 10. TCP Flood Detector
cat > $SCRIPTS_DIR/tcp-flood-check.sh <<'EOF'
#!/bin/bash
echo "🔎 Top IPs by TCP connections:"
sudo netstat -ntu | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | head -5
EOF

# Make all new scripts executable
chmod +x $SCRIPTS_DIR/*.sh

echo "🎉 Real-time troubleshooting & monitoring scripts created successfully!"

