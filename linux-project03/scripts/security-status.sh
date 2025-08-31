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
