#! /bin/bash

find /backup/weekly/* -type f -ctime +28 -exec rm -f {} \;
exit 1
