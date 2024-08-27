extrafile="/backup/my.cnf"
dir_backup_log="/backup/log"
backup_dir="/backup/daily/db"
dbname="your_database_name"
/usr/bin/mysqldump --defaults-extra-file=$extrafile $dbname | gzip >  $backup_dir/`date +%Y%m%d`-backup_filename.sql.gz && echo "`date +%Y%m%d` DB Daily Backup Successful" >> $dir_backup_log/backup_db_daily.log && echo "`date` DB Daily Backup Successful" | mail -s "Daily Backup Status" your_email@domain.tld