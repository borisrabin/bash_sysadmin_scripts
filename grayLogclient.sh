#!/bin/sh
IP_ADDR='38.99.188.17'
firewall-cmd --zone=public --add-port=514/udp --permanent
firewall-cmd --reload
cat > /etc/rsyslog.d/90-graylog2.conf <<EOF
$template GRAYLOGRFC5424,"<%PRI%>%PROTOCOL-VERSION% %TIMESTAMP:::date-rfc3339% %HOSTNAME% %APP-NAME% %PROCID% %MSGID% %STRUCTURED-DATA% %msg%\n"
*.* @$IP_ADDR:514;GRAYLOGRFC5424
EOF
service rsyslog restart
