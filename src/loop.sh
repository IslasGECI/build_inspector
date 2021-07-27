#!/usr/bin/env bash
#
DATAFILE=data/raw/repository_list.csv

while IFS="," read -r repo uuid
do
  echo "Repo: ${repo}"
  echo "UUID: ${uuid}"
  ./src/geci-maketests.sh ${repo} ${uuid} && \
  ./src/geci-makeall.sh ${repo} ${uuid}
  echo ""
done < <(tail --lines=+2 ${DATAFILE})
