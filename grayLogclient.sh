#!/bin/sh
IP_ADDR='38.99.188.17'

cat > /etc/fail2ban/jail.local <<EOF
/etc/rsyslog.d/90-graylog2.conf
$template GRAYLOGRFC5424,"%protocol-version% %timestamp:::date-rfc3339% %HOSTNAME% %app-name% %procid% %msg%\n"
*.* @$IP_ADDR:514;GRAYLOGRFC5424
EOF
service rsyslog restartreboot
