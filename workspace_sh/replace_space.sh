#!/bin/bash
set -e

DIR=$*

if [ -z "$DIR" ]; then
  echo "Missing DIR:"
  echo "rspace <full path>"
  echo 'e.g rspace "/mnt/c/Users/dcuapiaco/OneDrive - Infor/Downloads"'
  exit 1
fi

echo "cd $DIR"
cd "$DIR"

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

echo "***replacing <space> with <underscore>"
declare -a LIST=(`ls | grep " "`)
for file in "${LIST[@]}"; do 
  echo "$file to" $(echo $file | tr ' ' '_')
  mv "$file" $(echo $file | tr ' ' '_')
done

IFS=$SAVEIFS

echo "***done"
