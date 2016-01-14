#!/bin/sh
IP_ADDR='38.99.188.17'
#firewall-cmd --zone=public --add-port=514/udp

cat > /etc/rsyslog.d/90-graylog2.conf <<EOF
$template GRAYLOGRFC5424,"%protocol-version% %timestamp:::date-rfc3339% %HOSTNAME% %app-name% %procid% %msg%\n"
*.* @$IP_ADDR:514;GRAYLOGRFC5424
EOF
service rsyslog restart
