# backup-script-linux-cron

For documentation please refer to https://devarticles.in/howto-setup-daily-weekly-backup-cron-linux/

Set up Daily Backup Scripts
Create a new `backup_daily.sh` file.

`nano backup_daily.sh`

Add the following lines to `backup_daily.sh` file

`/bin/bash /backup/script/backup_db_daily.sh
/bin/bash /backup/script/backup_sites_daily.sh`

As you just added in the two lines above we will create backup_db_daily.sh and backup_sites_daily.sh in the next steps.

Daily Database backup script
Create backup_db_daily.shwith following lines. Make changes to db details accordingly.

extrafile="/backup/my.cnf"
dir_backup_log="/backup/log"
backup_dir="/backup/daily/db"
dbname="your_database_name"
/usr/bin/mysqldump --defaults-extra-file=$extrafile $dbname | gzip >  $backup_dir/`date +%Y%m%d`-backup_filename.sql.gz
&& echo "`date +%Y%m%d` DB Daily Backup Successful" >> $dir_backup_log/backup_db_daily.log 
&& echo "`date` DB Daily Backup Successful" | mail -s "Daily Backup Status" your_email@domain.tld
Note: in order to not expose database details in the command line we are using the default-extra-file options of MySQL server. More details. For this, create a my.cnf file with the following lines of code, and store it some secured folder and mention the path in the extrafile option above. (supply database details accordingly)

[client]
user = "your_db_username"
password = "your_db_password"
host = "your_db_host"
Daily Files backup script
Create backup_sites_daily.shwith following lines. Make changes to folder path accordingly.

backup_dir="/backup/daily/files"
dir_to_backup="/var/www/html"
dir_backup_log="/backup/log"
tar czf $backup_dir/`date +%Y%m%d`-fundabook-wp-content.tar.gz $dir_to_backup \
&& echo "`date +%Y%m%d` Files Daily Backup Successful" >> $dir_backup_log/backup_sites_daily.log 
&& echo "`date` Files Daily Backup Successful" | mail -s "Daily Backup Status" your_email@domain.tld
Set up Weekly Backup Scripts
Weekly backup scripts can also be setup by modifying the daily backup scripts, as under.

Note: All files to be created within /backup/scripts folder

Create a new backup_weekly.sh file.

/bin/bash /backup/script/backup_db_weekly.sh \
/bin/bash /backup/script/backup_sites_weekly.sh
As you just added in the two lines above we will create backup_db_weekly.sh and backup_sites_weekly.sh in the next steps.

Weekly Database backup script
Create backup_db_weekly.shwith following lines. Make changes to db details accordingly.

backup_dir="/backup/weekly/db"
dir_backup_log="/backup/log"
dbhost="[hostname]"
dbuser="[username]"
dbpass="[password]"
dbname="[database_name]"
/usr/bin/mysqldump --force -u $dbuser --password=$dbpass -h $dbhost $dbname | gzip >  $backup_dir/`date +%Y%m%d`-fundabook-hi.sql.gz
&& echo "`date +%Y%m%d` DB Weekly Backup Successful" >> $dir_backup_log/backup_db_weekly.log 
&& echo "`date` DB Weekly Backup Successful" | mail -s "Weekly Backup Status" your_email@domain.tld
Weekly Files Backup Script
Create backup_sites_weekly.shwith following lines. Make changes to folder path accordingly.

backup_dir="/backup/weekly/files"
dir_to_backup="/var/www/html"
dir_backup_log="/backup/log"
tar czf $backup_dir/`date +%Y%m%d`-fundabook-wp-content.tar.gz $dir_to_backup \
&& echo "`date +%Y%m%d` Files Weekly Backup Successful" >> $dir_backup_log/backup_sites_weekly.log 
&& echo "`date` Files Weekly Backup Successful" | mail -s "Weekly Backup Status" your_email@domain.tld
Cleaning Back Ups
If you are concerned about the disk space, you may need to remove old backups periodically.

Create backup_cleaner.shwith following lines. Make changes to folder path accordingly.

/bin/bash /backup/script/backup_cleaner_daily.sh \
/bin/bash /backup/script/backup_cleaner_weekly.sh
As added in two lines above we will create backup_cleaner_daily.sh and backup_cleaner_weekly.sh in the next two steps.


Create backup_cleaner_daily.sh and add the following code.

#! /bin/bash
find /backup/daily/* -type f -ctime +3 -exec rm -f {} \;
exit 1
Create backup_cleaner_weekly.sh and add the following code.

#! /bin/bash
find /backup/weekly/* -type f -ctime +28 -exec rm -f {} \;
exit 1
Running Back Up Scripts
Setting up cron for daily backup

crontab -e
Add the following lines to crontab file

0 0 * * 5 /bin/bash /backup/script/backup_weekly.sh > /var/log/backup_weekly.log
0 0 * * * /bin/bash /backup/script/backup_cleaner_weekly.sh > /var/log/backup_cleaner_weekly.log
0 0 * * * /bin/bash /backup/script/backup_daily.sh > /var/log/backup_daily.log
0 0 * * * /bin/bash /backup/script/backup_cleaner_daily.sh > /var/log/backup_cleaner_daily.log
All crons above except first one runs once in a day. The first one above which is a weekly backup cron runs every Friday.
Although I have created backup_cleaner.sh I would like to run daily and weekly cleaners individually so that I could log them individually.

There is also a backup_log_cleaner.sh that can be used as a cron to clean backup logs.