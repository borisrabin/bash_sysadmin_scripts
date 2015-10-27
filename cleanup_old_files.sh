#!/bin/bash
# Boris R
# Oct 27 2015
#
#######################################################
#   VARIABLES
OLDER_THEN='5'
PATH_TO='/usr/asa/tmax/files/email/*.htm'
LOG_LOCATION='/var/log/cleanup.log'
#   ACTION do not make chnages below
echo "Starting cleanup" >>  $LOG_LOCATION
date +"%D" >> $LOG_LOCATION
date +"%T" >> $LOG_LOCATION
ls -l $PATH_TO | wc -l >> $LOG_LOCATION
unalias rm
find $PATH_TO -mtime +$OLDER_THEN -exec rm {} \;
echo "cleanup done" >>  $LOG_LOCATION
date +"%D" >> $LOG_LOCATION
date +"%T" >> $LOG_LOCATION
ls -l $PATH_TO | wc -l >> $LOG_LOCATION 
