#!/bin/sh
IP_ADDR='192.168.0.22'


/etc/rsyslog.d/90-graylog2.conf
$template GRAYLOGRFC5424,"%protocol-version% %timestamp:::date-rfc3339% %HOSTNAME% %app-name% %procid% %msg%\n"
*.* @$IP_ADDR:514;GRAYLOGRFC5424

sudo service rsyslog restartreboot
