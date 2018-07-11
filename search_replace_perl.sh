#!/bin/bash

ROOT_DIR="."

SEARCH_REGEX=$1
REPLACE_REGEX=$2

find $ROOT_DIR -name "*.swift" | while read f; do
	perl -pi.back -e "s/$SEARCH_REGEX/$REPLACE_REGEX/" $f		
	echo "Completed edit $f"
done
