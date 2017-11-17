echo "Archive & compress home directory"
tar -cpzf backup.tar.gz --exclude=*backup.tar.gz --exclude=backup-split-* --one-file-system /home/phil
echo "Split archive"
split -b 50M backup.tar.gz backup-split-
echo "Upload archives to Google Drive"
rclone copy -v . --include "backup-split-*" gdrive:/gambit-backup/split/2017november17

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