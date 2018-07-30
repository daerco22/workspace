#!/bin/bash
set -e

DIR=$*

if [ -z "$DIR" ]; then
  echo "Missing DIR:"
  echo "org <full path>"
  echo 'e.g org "/mnt/c/Users/dcuapiaco/OneDrive - Infor/Downloads"'
  exit 1
fi

echo "cd $DIR"
cd "$DIR"

#make folders for extension names
echo "***creating folders for extension names"
FOLDERS=$(ls -1 | rev | cut -d '.' -f 1 | rev | tr '[:lower:]' '[:upper:]' | sort | uniq)
for folders in $FOLDERS; do
  if [ $folders != 'INI' ]; then
    mkdir -p $folders
  fi
done

#move file to their extension folders
echo "***moving file to their extension folders"
XTN=$(ls -1 | rev | cut -d '.' -f 1 | rev | sort | uniq)
for xtn in $XTN; do
  if [ $xtn != 'ini' ]; then
    UPXTN=$(echo $xtn | tr '[:lower:]' '[:upper:]')
    find . -maxdepth 1 -type f -name "*.$xtn" -exec mv {} $UPXTN/ \;
  fi
done

echo "***done"
