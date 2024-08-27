# backup-script-linux-cron

For detailed documentation please refer to https://devarticles.in/howto-setup-daily-weekly-backup-cron-linux/

Copy all script files to location or server on which you want to setup backups. Then setup the cron as following:

`crontab -e`

Add the following lines to crontab file

`0 0 * * 5 /bin/bash /backup/script/backup_weekly.sh > /var/log/backup_weekly.log`

`0 0 * * * /bin/bash /backup/script/backup_cleaner_weekly.sh > /var/log/backup_cleaner_weekly.log`

`0 0 * * * /bin/bash /backup/script/backup_daily.sh > /var/log/backup_daily.log`

`0 0 * * * /bin/bash /backup/script/backup_cleaner_daily.sh > /var/log/backup_cleaner_daily.log`

Although I have created backup_cleaner.sh I would like to run daily and weekly cleaners individually so that I could log them individually.

There is also a backup_log_cleaner.sh that can be used as a cron to clean backup logs.