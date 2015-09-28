yum -y install yum-cron
   81  cd /etc/yum
   82  vim yum-cron.conf 
   83  vi yum-cron.conf 
   84  systemctl enable yum-cron.service
   85  systemctl start yum-cron.service
   86  systemctl status yum-cron.service
[root@circ ~]# cat /etc/yum/yum-cron.conf 
[commands]
#  What kind of update to use:
# default                            = yum upgrade
# security                           = yum --security upgrade
# security-severity:Critical         = yum --sec-severity=Critical upgrade
# minimal                            = yum --bugfix upgrade-minimal
# minimal-security                   = yum --security upgrade-minimal
# minimal-security-severity:Critical =  --sec-severity=Critical upgrade-minimal
update_cmd = security

# Whether a message should be emitted when updates are available,
# were downloaded, or applied.
update_messages = yes

# Whether updates should be downloaded when they are available.
download_updates = yes

# Whether updates should be applied when they are available.  Note
# that download_updates must also be yes for the update to be applied.
apply_updates = yes

# Maximum amout of time to randomly sleep, in minutes.  The program
# will sleep for a random amount of time between 0 and random_sleep
# minutes before running.  This is useful for e.g. staggering the
# times that multiple systems will access update servers.  If
# random_sleep is 0 or negative, the program will run immediately.
# 6*60 = 360
random_sleep = 360


[emitters]
# Name to use for this system in messages that are emitted.  If
# system_name is None, the hostname will be used.
system_name = None

# How to send messages.  Valid options are stdio and email.  If
# emit_via includes stdio, messages will be sent to stdout; this is useful
# to have cron send the messages.  If emit_via includes email, this
# program will send email itself according to the configured options.
# If emit_via is None or left blank, no messages will be sent.
emit_via = stdio

# The width, in characters, that messages that are emitted should be
# formatted to.
ouput_width = 80


[email]
# The address to send email messages from.
email_from = root@circ-travelpress.com

# List of addresses to send messages to.
email_to = info@tekyhost.com

# Name of the host to connect to to send email messages.
email_host = localhost


[groups]
# NOTE: This only works when group_command != objects, which is now the default
# List of groups to update
group_list = None

# The types of group packages to install
group_package_types = mandatory, default

[base]
# This section overrides yum.conf

# Use this to filter Yum core messages
# -4: critical
# -3: critical+errors
# -2: critical+errors+warnings (default)
debuglevel = -2

# skip_broken = True
mdpolicy = group:main

# Uncomment to auto-import new gpg keys (dangerous)
# assumeyes = True
[root@circ ~]# 
