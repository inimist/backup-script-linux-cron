extrafile="/backup/my.cnf"
backup_dir="/backup/weekly/db"
dir_backup_log="/backup/log"
dbname="your_database_name"
/usr/bin/mysqldump --defaults-extra-file=$extrafile $dbname | gzip >  $backup_dir/`date +%Y%m%d`-backup_filename.sql.gz
&& echo "`date +%Y%m%d` DB Weekly Backup Successful" >> $dir_backup_log/backup_db_weekly.log 
&& echo "`date` DB Weekly Backup Successful" | mail -s "Weekly Backup Status" your_email@domain.tld