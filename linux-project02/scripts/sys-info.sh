#!/bin/bash
echo "🖥️ System Info:"
uname -a
echo "🔧 Kernel: $(uname -r)"
echo "🧠 Memory: $(free -h | awk 'NR==2{print $2}')"
echo "💾 Disk: $(df -h / | awk 'NR==2 {print $2}')"
echo "👤 Logged-in users: $(who | wc -l)"
