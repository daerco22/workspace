#!/bin/bash
set -e

DIR=$*

if [ -z "$DIR" ]; then
  echo "Missing DIR:"
  echo "org <full path>"
  echo 'e.g org "/mnt/c/Users/dcuapiaco/OneDrive - Infor/Downloads"'
  exit 1
fi

organizing () {
cd "$DIR"

XTS=$(ls | grep -E "\.[a-z,A-Z]{0,5}" | rev | cut -d '.' -f 1 | rev | tr '[:lower:]' '[:upper:]' | sort | uniq)
for X in $XTS; do
  if [ $X != 'INI' ]; then
    x=$(echo $X | tr '[:upper:]' '[:lower:]')
    mkdir -p $X
    find . -maxdepth 1 -type f -name "*.$x" -exec mv {} $X/ \;
  fi
done

#exit 1

mkdir -p NOEXTENSION
NXTS=$(ls | grep -v -E "\.[a-z,A-Z]{0,5}")
for NX in $NXTS; do
  if [ -n $(find . -maxdepth 1 -type f -name "$NX") ]; then
    find . -maxdepth 1 -type f -name "$NX" -exec mv {} NOEXTENSION/ \;
  fi
done
}

echo "Organizing $DIR"

organizing &
PID=$!
i=1
sp="/-\|"
echo -n ' '
while [ -d /proc/$PID ]
do
  printf "\b${sp:i++%${#sp}:1}"
done
echo "Done"
