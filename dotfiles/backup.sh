#!/bin/bash
DATE="$(date +%Y-%b-%d)"

# Check for internet conectivity
wget -q --tries=10 --timeout=20 --spider http://google.com
if [[ $? -eq 0 ]]; then
    echo "Online"
else
    echo "Backup Aborted; No internet connection."
    notify-send "Backup Aborted; No internet connection."
    exit 1
fi

if [ ! -e backup.tar.gz ]; then
    echo "Downloading newest exclusion list"
    wget -q https://raw.githubusercontent.com/rubo77/rsync-homedir-excludes/master/rsync-homedir-excludes.txt -O /var/tmp/ignorelist
    echo "Archive & compress home directory"
    tar -cpzf backup.tar.gz --exclude=*backup.tar.gz --exclude=backup-split-* --exclude-from=/var/tmp/ignorelist --one-file-system /home/phil
else
    echo "Backup already exists"
fi

echo "Size: $(du -sh backup.tar.gz)"
echo "Split archive"
split -b 100M backup.tar.gz backup-split-
echo "Upload archives to Google Drive"
rclone copy -v --stats 10s . --include "backup-split-*" gdrive:/gambit-backup/split/"${DATE}"

if [ $? -eq 0 ]; then
    echo "Upload completed successfully."
    echo "Deleting all backup files."
    if [ -e backup.tar.gz ]; then
        rm backup.tar.gz
    fi
else
    >&2 echo "Upload was unsuccessful."
    >&2 echo "Deleting only split archives."
fi

if [ -e backup-split-aa ]; then
    rm backup-split-*
fi

# To restore, 
## cat backup-split-* >> backup.tar.gz
# then untar the folder
