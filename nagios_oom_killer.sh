#!/bin/bash

#

# script:    NagiosPlugin-for oom-killer

# author:    Boris R

# date:      Jan 08 2015

#

###########################################

#        variables                        #

###########################################
MONTH=$(date +%b)     
HOUR=$(date +%H)
DAY=$(date +%e)
PATH_TO_LOG=/var/log/messages




# Look for oom-killer withing last hour , return 0 if not found and 3 if found 
function look_for_it

            {

            cat $PATH_TO_LOG | grep -e "$MONTH  $DAY $HOUR"

            }

look_for_it

# report to nagios 
case $? in
0)
echo "oom-killer detected"
exit 2
;;
1)
echo "OK"
exit 0
;;
*)
echo "non standard output"
exit 3
;;
esac




 
