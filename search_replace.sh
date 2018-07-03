#!/bin/bash

# ROOT_DIR=$1
ROOT_DIR="."

SEARCH_EXPR=$1
REPLACE_EXPR=$2

find $ROOT_DIR -name "*.h" -or -name "*.m" | while read f; do
	sed -i '' -E "s/$SEARCH_EXPR/$REPLACE_EXPR/" $f
	echo "Completed edit $f"
done

# Script Explanation -
# 
# The script finds all files with the extension .h / .m in a particular directory recursively
# and uses sed to search for strings matching a regular expression and replace all occurances of 
# that string with another regular expression.
#
# Regex Explanation -
#
# (\.*[a-zA-Z0-9]*) - 	Matches any number of characters which contain a-z / A-Z / 0-9 and creates
# 						a group for later use.
#
# (\.*[ \n]) 		- 	Matches a space or a new line character and creates a group for later use.
#
# \<index> 			-	Adds the group selected at <index>.
#
# Swift search / replace regex examples -
#
# ObjC search / replace regex examples -
# 
# 1. Search and replace all callsites of a function taking no parameters in ObjC
# SEARCH_EXPR=	"<space><functionName>]"
# REPLACE_EXPR=	"<space><newFunctionName>]"
#
# e.g. -
#   ./search_replace " myFunction" "myFun"
#
# 	i/p = [obj myFunction]
#   o/p = [obj myFun]
#
# 2. Search and replace all callsites of a function taking 1 parameter in ObjC
# SEARCH_EXPR=	"<space>functionName>:(\.*[a-zA-Z0-9]*)"
# REPLACE_EXPR= "<space><newFunctionName>:\1"
#
# e.g. -
#	./search_replace " myFunction:(\.*[a-zA-Z0-9]*)]" " myFunc:\1"
#
#	i/p = [obj myFunction:a]
#	o/p = [obj myFunc:a]
#
# 3. Search and replace all callsites of a function taking 2 parameters in ObjC
#    Note - This also handles method calls which have a new line after the first function argument 
#
# SEARCH_EXPR=  "<space><functionName>:(\.*[a-zA-Z0-9]*)(\.*[ \n])<argLabel1>:(\.*[a-zA-Z0-9]*)"
# REPLACE_EXPR= "<space><functionName>:(\1)(\2)<argLabel1>:(\2)"
# 	
# e.g. -
#	./search_replace " myFunction:(\.*[a-zA-Z0-9]*)(\.*[ \n])param:(\.*[a-zA-Z0-9]*)" " myFunc:\1\2param:\3"
#
#	i/p = [obj myFunction:a param:b]
#	o/p = [obj myFunc:a param:b]
#
#	i/p = [obj myFunction:a
#					param:b]
#	o/p = [obj myFunc:a
#					param:b]
# 
# 4. Changing an argument label for a particular function call taking 2 parameters in ObjC
#
# SEARCH_EXPR=  "<space><functionName>:(\.*[a-zA-Z0-9]*)(\.*[ \n])param:(\.*[a-zA-Z0-9]*)"
# REPLACE_EXPR= "<space><functionName>:\1\2newParamName:\3"
