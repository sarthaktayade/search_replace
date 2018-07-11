#!/bin/bash

ROOT_DIR="."

find $ROOT_DIR -name "*.back" | while read f; do
	rm $f
	echo "Removed $f"
done 
