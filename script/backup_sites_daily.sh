backup_dir="/backup/daily/files"
dir_to_backup="/var/www/html"
dir_backup_log="/backup/log"

tar czf $backup_dir/`date +%Y%m%d`-mywebsite-backup.tar.gz $dir_to_backup && echo "`date +%Y%m%d` Files Daily Backup Successful" >> $dir_backup_log/backup_sites_daily.log && echo "`date` Files Daily Backup Successful" | mail -s "Backup Status" your_email@address.tld