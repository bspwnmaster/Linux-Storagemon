#Folder Structures: etc, home, root, boot, usr, opt, var, nsm 
df -h --output='pcent' / | awk 'NR==2 {gsub("%","") ; if ($1 >= 94) print $1 ; else print "False"}'
du -hS /nsm/| sort -rh | head -5
#ls -alh
df -hT

echo "Storage Free Threshold Met" 2>&1 | mail -s ""

df -h --output='pcent','source','size' /nsm/
+
df -h --output='pcent','source','size' /

#!/bin/bash
#Folder Structures to monitor: etc, home, root, boot, usr, opt, var
#Grepping particular drives can change system to system "df -h /", grep /dev/, /dev/mapper/
#Every Minute

checkme="$(df -h --output='pcent' / | awk 'NR==2 {gsub("%","") ; if ($1 >= 94) print $1}')"
drives="$(df -hT | grep -i "/dev/")"
fulloutput="$(df -h --output='size','pcent','source','avail' /)"
df -hT | grep -i "/dev/"
largeness="$(du -hS /nsm/| sort -rh | head -5)"

if [ "$checkme" ]
then
	#echo "here"
df -hT
	du -hS /nsm/| sort -rh | head -5
	#echo "Storage Free Threshold Met" 2>&1 | mail -s "Storage Error" example@gmail[.]com
	echo $drives $largeness 2>&1 | mail -s "Storage Free Threshold Met" alert@alert.pagerduty.com
elif [ -z "$checkme" ]
then
	#echo "not here"
	exit 0
fi
