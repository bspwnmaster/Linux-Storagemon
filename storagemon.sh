#!/bin/bash
#/mnt/*
#Folder Structures: etc, home, root, boot, usr, opt, var, nsm
#df -h --output='pcent' / | awk 'NR==2 {gsub("%","") ; if ($1 >= 94) print $1 ; else print "False"}'
#du -hS /nsm/| sort -rh | head -5
#ls -alh
#df -hT
#find ~/Logs/ -name "*.txt" -type f -mtime +20 -delete #delete txt files w/ modification dates greater than 20 days
#df -hT | grep -i "/dev/"
#du -hS /dev/| sort -rh | head -5
#echo "Storage Free Threshold Met" 2>&1 | mail -s ""
#df -h --output='pcent','source','size' /dev/
#+
#df -h --output='pcent','source','size' /
#Grepping particular drives can change system to system "df -h /", grep /dev/, /dev/mapper/
#Tools to help with analysis include ncdu & duf

#Every Hour
# touch /etc/cron.d/checkstorage
# 0 * * * * root /root/checkstorage.sh
#Example set to trigger alert if drive over 10% utilization
checkme="$(df -h --output='pcent' / | awk 'NR==2 {gsub("%","") ; if ($1 >= 10) print $1}')"
drives="$(df -hT | grep -i "/dev/" | sort -rh -k3 | head -10)"
dirsize="$(du --max-depth=1 -h / 2>&1 | grep -v "cannot" | sort -rh | head -20)"
fulloutput="$(df -h --output='size','pcent','source','avail' /)"
#find if last email alert was sent within last day, if no then email
#newalert="$(find -type f -name ~/Documents/tests/lastemail.txt -mtime +1)"
#echo "$newalert"
#echo "$checkme"


if [ "$checkme" ]
then
	touch -m ~/Documents/tests/lastemail.txt
	#echo -e "here" "\n" > "~/Documents/tests/lastemail.txt"
    echo -e "$fulloutput\n\n""$drives\n\n""$dirsize"
    #echo -e "$fulloutput\n\n""$drives\n\n""$dirsize" | mail -s "Storage Free Threshold Met" alert@alert.pagerduty.com
    #echo "Storage Free Threshold Met" 2>&1 | mail -s "Storage Error" example@gmail[.]com
    #echo $drives 2>&1 | mail -s "Storage Free Threshold Met" alert@alert.pagerduty.com
    #echo $drives $largeness 2>&1 | mail -s "Storage Free Threshold Met" alert@alert.pagerduty.com
elif [ -z "$checkme" ]
then
	exit 0
fi

##################################

# If one doesn't want to get spammed with alerts - delay them a day until storage is fixed
#if [ "$checkme" ] && [ "$newalert" ]
#then
    #touch ~/Documents/tests/lastemail.txt
    ##echo -e "here" "\n" > "~/Documents/tests/lastemail.txt"
    #echo -e "$fulloutput\n\n""$drives\n\n""$dirsize"
#else
    #echo "parameters not met"
    #exit 0
