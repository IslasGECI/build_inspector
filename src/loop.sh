#!/usr/bin/env bash
#
datafile=data/raw/repository_list.csv

while IFS="," read -r repository uuid
do
  echo "Repository: ${repository}"
  echo "UUID: ${uuid}"
  ./src/geci-maketests.sh ${repository} ${uuid}
  ./src/geci-makeall.sh ${repository} ${uuid}
  echo ""
done < <(tail --lines=+2 ${datafile})
