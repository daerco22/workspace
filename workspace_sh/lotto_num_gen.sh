#!/bin/bash
set -e

MIN="1"
MAX="58"
COUNT="6"

shuf -i $MIN-$MAX -n $COUNT | tr '\n' ' ' | tee -a generated_num_result.log

echo " " | tee -a generated_num_result.log
