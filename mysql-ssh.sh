#!/bin/bash
# ---------------------------------------------------------
# MySQL Backup Script for VPS
# Author: Gift Balogun
# Portfolio: https://giftbalogun.name.ng
# GitHub: https://github.com/giftbalogun
# Description: This script automates MySQL database backups
# on Debian-based VPS systems with optional compression.
# License: MIT (c) 2024 Gift Balogun. All rights reserved.
# ---------------------------------------------------------

# Configuration
REMOTE_HOST=""
REMOTE_USER="root"
REMOTE_PORT=22
LOCAL_PATH="/WebsiteBackup"
REMOTE_PATH="/root/backup/mysql"
LOG_FILE="/var/log/mysql_backup.log"

# Telegram Bot Details
TELEGRAM_BOT_TOKEN="YOUR_TELEGRAM_BOT_TOKEN"
TELEGRAM_CHAT_ID="YOUR_TELEGRAM_CHAT_ID"

# Function to send Telegram notifications
send_telegram_message() {
  local message="$1"
  curl -s -X POST "https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage" \
    -d chat_id="$TELEGRAM_CHAT_ID" \
    -d text="$message"
}

# Start backup process
{
  echo "$(date) - Starting backup from $REMOTE_HOST"
  ssh-keyscan -p $REMOTE_PORT $REMOTE_HOST >> ~/.ssh/known_hosts 2>/dev/null
  
  rsync -e "ssh -o StrictHostKeyChecking=no -p $REMOTE_PORT" -avzP \
    $REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH $LOCAL_PATH

  if [ $? -eq 0 ]; then
    echo "$(date) - Backup successful."
    send_telegram_message "Backup completed successfully from $REMOTE_HOST to $LOCAL_PATH."

    ssh $REMOTE_USER@$REMOTE_HOST -p $REMOTE_PORT "rm -rf $REMOTE_PATH/*"
    echo "$(date) - Remote files deleted."
  else
    echo "$(date) - Backup failed."
    send_telegram_message "Backup failed from $REMOTE_HOST. Check logs."
  fi
} | tee -a $LOG_FILE
