#!/bin/bash



USEDSPACE=$(df -h | awk '{print $5}' | grep -vi use | cut -d'%' -f1)
for i in $USEDSPACE
do
	if [ $i -gt 90 ]
	then
		(df -h | head -n1; df -h | grep $i; \
		echo; echo "Total disk space used by /tmp = $(du -sh /tmp | awk '{print$1}')"; \
		echo; echo "Total disk space used by /var/log = $(du -sh /var/log | awk '{print$1}')") \
		| mail -s "HDD space warning for $(hostname -f)" mail@example.com

	elif [ $i -gt 85 ]
	then
		(df -h | head -n1; df -h | grep $i) \
		| mail -s "HDD space warning for $(hostname -f)" mail@example.com

	elif [ $i -gt 80 ]
	then
		(df -h | head -n1; df -h | grep $i) \
		| mail -s "HDD space warning for $(hostname -f)" mail@example.com

	fi
done

