#!/bin/bash


# Check if we get the right number of arguments

if [ ${#} -lt 2 ]; then echo -e "Usage: $(basename ${0}) <filedir> <searchstring>\n"; exit 1; fi

filedir=${1}
searchstr=${2}

# Check if $filedir is a directory on the filesystem

if [ ! -d ${filedir} ]; then echo -e "The first parameter is not a diectory\n"; exit 1; fi

files=$(find ${filedir} -type f 2>/dev/null)

# iterate over all ${files} and count the items and search for ${searchstr}

for file in ${files}; do
	filecount=$(expr ${filecount} + 1)

	if [ "$(cat ${file})" = "${searchstr}" ]; then
	       hitcount=$(expr ${hitcount} + 1);
	fi;
done

echo -e "The number of files are ${filecount} and the number of matching lines are ${hitcount}\n"

exit 0
