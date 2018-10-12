#!/bin/bash
set -e

ENV=$1
VER=$2
File_Name=$3

if [[ -z $ENV ]]; then
  echo "Missing: Environment Param"
  echo "e.g ./create_bat.sh <env> <ver> <filename>"
  exit
fi

if [[ -z $VER ]]; then
  echo "Missing: Version Param"
  echo "e.g ./create_bat.sh <env> <ver> <filename>"
  exit
fi

if [[ -z $File_Name ]]; then
  echo "Missing: FileName Param"
  echo "e.g ./create_bat.sh <env> <ver> <filename>"
  exit
fi

SAVEIFS=$IFS
IFS=$(echo -en "\n\b")

mkdir -p $ENV

for row in `cat $File_Name`; do
	APP=$(echo $row | cut -d '=' -f 1)
  	LINK=$(echo $row | cut -d '=' -f 2)
	if [[ $APP == "ISO" ]]; then
  	  echo '@echo off' > "$ENV/${VER}_$APP.bat"
  	  echo 'start '$LINK >> "$ENV/${VER}_$APP.bat"
	else
  	  echo '@echo off' > "$ENV/${VER}_$APP.bat"
  	  echo 'start "" '$LINK >> "$ENV/${VER}_$APP.bat"
	fi
done

