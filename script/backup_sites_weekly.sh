backup_dir="/backup/weekly/files"
dir_to_backup="/var/www/html"
dir_backup_log="/backup/log"

tar czf $backup_dir/`date +%Y%m%d`-mysite-backup-weekly.tar.gz $dir_to_backup && echo "`date +%Y%m%d` Files Weekly Backup Successful" >> $dir_backup_log/backup_sites_weekly.log && echo "`date` Files Weekly Backup Successful" | mail -s "Weekly Backup Status" your_email@domain.tld