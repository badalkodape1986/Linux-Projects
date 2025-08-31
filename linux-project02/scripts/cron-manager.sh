#!/bin/bash
case $1 in
  list) crontab -l ;;
  add)  (crontab -l; echo "$2") | crontab -; echo "✅ Cron job added: $2" ;;
  remove) crontab -r; echo "✅ All cron jobs removed" ;;
  *) echo "Usage: $0 {list|add '<cron expr>'|remove}" ;;
esac
