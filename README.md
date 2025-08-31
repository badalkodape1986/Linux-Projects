# 🐧 Linux DevOps / SRE Toolkit

This folder contains **40+ Linux projects** for **automation, troubleshooting, monitoring, security, and optimization**.  
These scripts are designed to showcase **real-world DevOps & SRE skills** — from basic automation to advanced incident handling.

---

## 📂 Categories & Projects

### ⚙️ Automation
- `setup-server.sh` – Install Docker, Nginx, Git, common tools
- `backup.sh` – Daily backup with timestamp
- `archive-old-files.sh` – Move files older than 30 days
- `disk-cleanup.sh` – Free disk space (logs, tmp, cache)
- `cron-manager.sh` – Manage cron jobs via script
- `mysql-backup.sh` – Dump all MySQL databases
- `file-sync.sh` – Sync data between servers (rsync)

---

### 📊 Monitoring & Observability
- `system-monitor.sh` – CPU, memory, disk logging
- `resource-dashboard.sh` – CLI dashboard (mini-htop)
- `docker-monitor.sh` – Monitor running containers
- `disk-health.sh` – Check SMART health of disks
- `update-checker.sh` – Notify available system updates
- `infra-dashboard.sh` – Full infra overview (CPU, RAM, Disk, Load, Top processes)

---

### 🔎 Troubleshooting
- `log-analyzer.sh` – Detect errors & failed logins
- `cron-failures.sh` – Report failed cron jobs
- `process-troubleshoot.sh` – Top CPU & memory processes
- `zombie-check.sh` – Detect zombie processes
- `hung-process-check.sh` – Detect D-state hung processes
- `orphan-process-check.sh` – Detect orphan processes
- `kernel-crash-check.sh` – Extract kernel panic logs
- `latency-test.sh` – Measure service response time
- `memory-leak-check.sh` – Check for memory hogging apps

---

### 🔒 Security & Auditing
- `ssh-hardening.sh` – Disable root login, enforce key-based auth
- `firewall-setup.sh` – Configure UFW rules
- `failed-logins.sh` – Detect brute-force attempts
- `open-ports.sh` – Scan open ports
- `file-integrity.sh` – Detect modified files with checksums
- `security-status.sh` – Check SELinux/AppArmor
- `patch-manager.sh` – Apply security updates automatically

---

### 🛡️ Resilience & Self-Healing
- `service-check.sh` – Restart services if stopped
- `auto-heal.sh` – Monitor & auto-restart critical services
- `service-supervisor.sh` – Custom mini-systemd (watch + restart)
- `incident-simulator.sh` – Simulate service failure & recover
- `network-autoheal.sh` – Restart network service if ping fails
- `kill-high-cpu.sh` – Kill runaway CPU processes
- `disk-alert.sh` – Warn if disk usage exceeds threshold
- `swap-usage-check.sh` – Warn if swap usage is critical
- `high-load-check.sh` – Detect high system load
- `tcp-flood-check.sh` – Detect connection floods
- `port-collision-check.sh` – Detect port conflicts

---

### 🔧 Optimization
- `sys-info.sh` – System & kernel info
- `service-deps.sh` – Validate service dependencies
- `sysctl-tuner.sh` – Auto-tune kernel parameters
- `top-network-processes.sh` – Find bandwidth hogging processes
- `network-traffic-analyzer.sh` – Monitor top network connections

---

### 🌐 Web / Logs
- `web-log-analyzer.sh` – Top requested URLs & client IPs (Nginx)
- `log-rotation.sh` – Rotate & archive logs, cleanup after 30 days

---

## 📘 Usage

### Run a script directly
```bash
./01-devops-basics/scripts/system-monitor.sh

