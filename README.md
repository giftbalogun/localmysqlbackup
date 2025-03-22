# MySQL Backup Script for VPS

## Overview
This script automates the backup of MySQL databases from a VPS to a local server. It also sends Telegram notifications upon success or failure and logs all activities.

## Features
- Automated MySQL backup from a remote VPS
- Secure transfer using `rsync` over SSH
- Telegram notifications for success/failure
- Log file management for troubleshooting
- Remote cleanup of old backups after transfer

## Requirements
- A Debian-based VPS with MySQL installed
- SSH access with password-less authentication or `sshpass`
- Telegram bot API token and chat ID

## Installation
1. Clone the repository:
   ```sh
   git clone https://github.com/giftbalogun/localmysqlbackup.git
   cd mysql-backup-script
   ```
2. Edit the script and update the following variables:
   ```sh
   REMOTE_HOST="your_vps_ip"
   REMOTE_USER="root"
   REMOTE_PORT=22
   LOCAL_PATH="/WebsiteBackup"
   REMOTE_PATH="/root/backup/mysql"
   TELEGRAM_BOT_TOKEN="your_bot_token"
   TELEGRAM_CHAT_ID="your_chat_id"
   ```
3. Make the script executable:
   ```sh
   chmod +x mysql_backup.sh
   ```

## Usage
Run the script manually:
```sh
./mysql_backup.sh
```
Or set up a cron job to run it automatically:
```sh
0 2 * * * /path/to/mysql_backup.sh >> /var/log/mysql_backup.log 2>&1
```
This will execute the backup daily at 2 AM.

## License
MIT License (c) 2024 Gift Balogun

## Author
Gift Balogun  
[Portfolio](https://giftbalogun.name.ng)  
[GitHub](https://github.com/giftbalogun)

