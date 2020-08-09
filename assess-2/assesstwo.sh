#!/bin/bash
NUMBER='^[0-9]+$'
echo -e "\e[33m Please enter how many days old object count do you wish to get : \e[00m"; read age
echo -e "\e[33m Please enter pattern to match from metadata.json : \e[00m"; read pattern
EPOCH_TIME=`date +%s --date="$age days ago"`

if ! [[ $age =~ $number ]];then
	echo -e "\e[31m Invalid Input Provided. Number expected \e[00m"
	exit
else
	echo $age
	if [ ! -f ./metadata.json ];then
		echo -e "\e[31m \e[01mFile metadata.json does not exist \e[00m"
		exit
	fi		
	for i in `grep -i timestamp metadata.json | awk -F '"' '{print $4}' |cut -d 'T' -f 1`
	do 
		`date +%s -d"$i" >> /tmp/working`
	done

	for x in `cat /tmp/working`
	do
		if [ "$x" -lt "$EPOCH_TIME" ];then
			echo "$x" >> /tmp/final.output
		fi		
	done

	OBJECTS=`wc -l /tmp/final.output | awk '{print $1}'`
	PATTERN_COUNT=`sed -n "/$pattern/p" metadata.json |wc -l`

	echo -e "\e[32m \e[01mObject created before $age days is: $OBJECTS \e[00m"
	echo -e "\e[32m \e[01mPattern Count for provided pattern is: $PATTERN_COUNT \e[00m"
	/bin/rm -fv /tmp/{working,final.output} > /dev/null 2>&1 	
fi
