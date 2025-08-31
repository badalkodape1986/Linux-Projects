#!/bin/bash
# 🚀 Create Advanced Linux Projects (Monitoring, Security, Troubleshooting)

set -e
SCRIPTS_DIR="linux-project03/scripts"
mkdir -p "$SCRIPTS_DIR"

# --- Advanced Linux Scripts ---

# 1. Resource Dashboard
cat > $SCRIPTS_DIR/resource-dashboard.sh <<'EOF'
#!/bin/bash
while true; do
  clear
  echo "📊 Resource Dashboard - $(date)"
  echo "----------------------------------"
  echo "CPU:    $(top -bn1 | grep 'Cpu(s)' | awk '{print $2 + $4}')%"
  echo "Memory: $(free -m | awk 'NR==2{printf \"%.2f%% of %sMB\", $3*100/$2, $2}')"
  echo "Disk:   $(df -h / | awk 'NR==2{print $5 \" used of \"$2}')"
  if command -v ifstat &>/dev/null; then
    echo "Network: $(ifstat 1 1 | awk 'NR==3 {print \"IN: \"$1\"KB/s | OUT: \"$2\"KB/s\"}')"
  fi
  sleep 2
done
EOF

# 2. Zombie Process Detector
cat > $SCRIPTS_DIR/zombie-check.sh <<'EOF'
#!/bin/bash
ZOMBIES=$(ps aux | awk '{ if ($8=="Z") print $0 }')
if [ -z "$ZOMBIES" ]; then
  echo "✅ No zombie processes found"
else
  echo "⚠️ Zombie processes detected:"
  echo "$ZOMBIES"
fi
EOF

# 3. Security Status
cat > $SCRIPTS_DIR/security-status.sh <<'EOF'
#!/bin/bash
if command -v sestatus &>/dev/null; then
  echo "🔒 SELinux status:"
  sestatus
elif command -v aa-status &>/dev/null; then
  echo "🔒 AppArmor status:"
  sudo aa-status
else
  echo "⚠️ No SELinux/AppArmor found on this system"
fi
EOF

# 4. Disk Health
cat > $SCRIPTS_DIR/disk-health.sh <<'EOF'
#!/bin/bash
if ! command -v smartctl &> /dev/null; then
  echo "📥 Installing smartmontools..."
  sudo apt install -y smartmontools
fi
for disk in /dev/sd[a-z]; do
  echo "🔎 Checking health of $disk..."
  sudo smartctl -H $disk | grep "SMART overall-health"
done
EOF

# 5. Package Update Checker
cat > $SCRIPTS_DIR/update-checker.sh <<'EOF'
#!/bin/bash
echo "🔄 Checking for updates..."
UPDATES=$(apt list --upgradeable 2>/dev/null | tail -n +2)
if [ -z "$UPDATES" ]; then
  echo "✅ System is up to date"
else
  echo "⚠️ Updates available:"
  echo "$UPDATES"
fi
EOF

# 6. Kernel Crash Log Extractor
cat > $SCRIPTS_DIR/kernel-crash-check.sh <<'EOF'
#!/bin/bash
LOG="/var/log/kern.log"
echo "🔎 Checking for kernel panics in $LOG..."
grep -i "panic" $LOG || echo "✅ No kernel panics found"
EOF

# 7. Docker Monitor
cat > $SCRIPTS_DIR/docker-monitor.sh <<'EOF'
#!/bin/bash
if ! command -v docker &>/dev/null; then
  echo "❌ Docker not installed"
  exit 1
fi
echo "🐳 Active Docker containers:"
docker ps --format "table {{.Names}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"
echo "📊 Container resource usage:"
docker stats --no-stream
EOF

# 8. File Integrity Checker
cat > $SCRIPTS_DIR/file-integrity.sh <<'EOF'
#!/bin/bash
DIR=${1:-"/etc"}
BASELINE="baseline.md5"
if [ ! -f $BASELINE ]; then
  echo "📥 Creating baseline checksum for $DIR..."
  find $DIR -type f -exec md5sum {} \; > $BASELINE
  echo "✅ Baseline saved to $BASELINE"
else
  echo "🔎 Comparing current state of $DIR with baseline..."
  md5sum -c $BASELINE | grep -E "FAILED|changed"
fi
EOF

# 9. Service Latency Test
cat > $SCRIPTS_DIR/latency-test.sh <<'EOF'
#!/bin/bash
URL=${1:-"https://google.com"}
echo "🌐 Testing latency for $URL"
time curl -o /dev/null -s -w "✅ Response code: %{http_code} | Time: %{time_total}s\n" $URL
EOF

# 10. Memory Leak Check
cat > $SCRIPTS_DIR/memory-leak-check.sh <<'EOF'
#!/bin/bash
echo "🔎 Checking top memory-hogging processes..."
ps -eo pid,comm,%mem --sort=-%mem | head -n 10
EOF

# Make executable
chmod +x $SCRIPTS_DIR/*.sh

echo "🎉 Advanced Linux projects created successfully!"

