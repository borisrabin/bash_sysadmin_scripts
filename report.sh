#!/bin/bash
# Boris R - Tekyhost.com
# 18/01/2015
# Monitor open files by java process
# test commit
#!/bin/bash
for t in 1 2 3

do
        DATE=$(date +"%m-%d-%H-%M")
        PROCESS=java
        PROCESS_ID=$(ps -C $PROCESS -o pid=)
        OPEN_FILES=$(lsof -p $PROCESS_ID | wc -l)
        OPEN_APACHE=$(ps aux | grep httpd | wc -l)
        OPEN_80=$(lsof -i TCP:80  | wc -l)
		OPEN_443=$(lsof -i TCP:443  | wc -l)
		OPEN_8080=$(lsof -i TCP:8080  | wc -l)
		OPEN_MYSQL=$(lsof -c mysql  | wc -l)
    echo  "Process ID $PROCESS_ID"  >  /opt/reports/log$DATE.log
    echo  "Process $PROCESS_ID has $OPEN_FILES open files"  >>  /opt/reports/log$DATE.log
    echo  "Apache has $OPEN_APACHE processes running"  >>  /opt/reports/log$DATE.log
    echo "Port 80 $OPEN_80 files open" >> /opt/reports/log$DATE.log
    echo "Port 443 $OPEN_443 files open " >> /opt/reports/log$DATE.log
    echo "port 8080 $PEN_8080 files opne" >> /opt/reports/log$DATE.log
    echo "mysq $OPEN_MYSQL files open" >> /opt/reports/log$DATE.log
    
    echo "############" >> /opt/reports/log$DATE.log
    echo "stats collection" >> /opt/reports/log$DATE.log
    echo "############" >> /opt/reports/log$DATE.log
    
    top -b -n 3 >> /opt/reports/log$DATE.log
    echo "VMSTAT OUTPUT --------------------------" >>  /opt/reports/log$DATE.log
    vmstat >>  /opt/reports/log$DATE.log
    
    lsof -i TCP:80  >> /opt/reports/log$DATE.log

    
    lsof -i TCP:443  >> /opt/reports/log$DATE.log

    
    lsof -i TCP:8080  >> /opt/reports/log$DATE.log

    
    lsof -c mysql  >> /opt/reports/log$DATE.log
    
    echo "java open files" >> /opt/reports/log$DATE.log
    lsof -p $PROCESS_ID >> /opt/reports/log$DATE.log
    
    free >> /opt/reports/log$DATE.log

        sleep 5m
done

