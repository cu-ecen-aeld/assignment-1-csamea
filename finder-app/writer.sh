#!/bin/bash

# Check if we get the right number of arguments

if [ ${#} -lt 2 ]; then 
	echo -e "Usage: $(basename ${0}) <writefile> <writestr>\n";
	exit 1; 
fi

if [ ! ${1} ]; then 
	echo -e "File Path must not be empty!\n"; 
	exit 1; 
fi

writefile=${1}
writestr=${2}

# Check if ${writefile} is a directory on the filesystem if not create the hole path

if [ ! -d ${writefile%/*} ]; then 
	mkdir -p ${writefile%/*} || $(echo -e "Unable to create directory path\n" \
		&& exit 1); 
fi

# Create the file 

touch ${writefile} || $(echo -e "Could not create the file\n" && exit 1)

printf ${writestr} > ${writefile} || $(echo -e "Error writing to file ${writefile}\n" && exit 1)

exit 0
