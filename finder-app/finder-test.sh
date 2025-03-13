#!/bin/bash
# Tester script for assignment 1 and assignment 2
# Author: Siddhant Jajoo

set -e
set -u

NUMFILES=10
WRITESTR=AELD_IS_FUN
WRITEDIR=/tmp/aeld-data
username=$(cat conf/username.txt)

if [ $# -lt 3 ]; then
	echo -e "Using default value ${WRITESTR} for string to write\n"
	if [ $# -lt 1 ]; then
		echo -e "Using default value ${NUMFILES} for number of files to write\n"
	else
		NUMFILES=$1
	fi
else
	NUMFILES=$1
	WRITESTR=$2
	WRITEDIR=/tmp/aeld-data/$3
fi

MATCHSTR="The number of files are ${NUMFILES} and the number of matching lines are ${NUMFILES}"

echo -e "Writing ${NUMFILES} files containing string ${WRITESTR} to ${WRITEDIR}\n"

assignment=`cat ../conf/assignment.txt`

if [ $assignment != 'assignment1' ]; then
	mkdir -p "$WRITEDIR"

	if [ -d "$WRITEDIR" ]; then
		echo -e "$WRITEDIR created\n"
	else
		exit 1
	fi
fi

#echo "Removing the old writer utility and compiling as a native application"
#make clean
#make

for i in $( seq 1 $NUMFILES); do
	./writer.sh "$WRITEDIR/${username}$i.txt" "$WRITESTR"
done

OUTPUTSTR=$(./finder.sh "$WRITEDIR" "$WRITESTR")
echo -e "OUTPUTSTR: $OUTPUTSTR"
#rm -rf /tmp/aeld-data

set +e
echo ${OUTPUTSTR} | grep "${MATCHSTR}"
if [ $? -eq 0 ]; then
	echo -e "success\n"
	exit 0
else
	echo -e "failed: expected ${MATCHSTR} in ${OUTPUTSTR} but instead found\n"
	exit 1
fi
