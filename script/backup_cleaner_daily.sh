#! /bin/bash

find /backup/daily/* -type f -ctime +3 -exec rm -f {} \;
exit 1
