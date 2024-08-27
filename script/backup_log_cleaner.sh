#!/bin/bash
now=$(date)
BACKUP_LOG_DIR="/backup/log"

# create log file
touch $BACKUP_LOG_DIR/backup_log_delete.log
echo "Date: $now" > $BACKUP_LOG_DIR/backup_log_delete.log

# declare static Array of file names 
file_names=('backup_db_daily.log' 'backup_sites_daily.log' 'backup_db_weekly.log' 'backup_sites_weekly.log')

# deletes files found in the backup directory (BACKUP_LOG_DIR) but not deeper (-maxdepth 1) 
# with the last modified time of over 30 days ago (-mtime +30) and a name which 
# matches the pattern of the filename from the file_names array.
for filename in "${file_names[@]}";
do 
    echo $filename
    # check if the backup files exit in the backup directory 
    if ls $BACKUP_LOG_DIR/$filename &> /dev/null
    then
        echo "check if backup files exists"
        # check if backup files older than 30 days exists, if so, delete them
        if find $BACKUP_LOG_DIR -maxdepth 1 -mtime +30 -name $filename -ls &> /dev/null
        then
            # File exit. Now delete backups files that are older than 30 days
            echo "The following backup file was deleted" >> $BACKUP_LOG_DIR/backup_log_delete.log
            find $BACKUP_LOG_DIR -maxdepth 1 -mtime +30 -name $filename -ls >> $BACKUP_LOG_DIR/backup_log_delete.log
            # delete those files
            find $BACKUP_LOG_DIR -maxdepth 1 -mtime +30 -name $filename -delete
        else
            echo  "There are no" $filename "files older than 30 days in" $BACKUP_LOG_DIR &>> $BACKUP_LOG_DIR/backup_log_delete.log
        fi
    else
        echo  "No" $filename "files found in" $BACKUP_LOG_DIR >> $BACKUP_LOG_DIR/backup_log_delete.log
    fi
done

exit 0
