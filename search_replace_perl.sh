#!/bin/bash

ROOT_DIR="."

SEARCH_REGEX=$1
REPLACE_REGEX=$2

find $ROOT_DIR -name "*.swift" | while read f; do
	perl -0pi.back -e "s/$SEARCH_REGEX/$REPLACE_REGEX/" $f		
	echo "Completed edit $f"
done

# The following example searches for all callsites of myFun() and only renames the second argument label.
# This basically means that indentation, variable names being passed etc are not affected at all callsites.
# 
#	Search - 	<anyobject>.myFun(param1: "param1",
# 								param2: "param2") 
#
#	Replace - 	<anyobject>.myFun(param1: "param1",
#								param3: ""param2)
#
# ./search_replace_perl.sh "\.myFun\(param1: (\.*[a-zA-Z0-9\"]*),(\.*[ \t\n]*)param2: (\.*[a-zA-Z0-9\"]*)" ".myFun\(param1: \$1,\$2param3: \$3"
