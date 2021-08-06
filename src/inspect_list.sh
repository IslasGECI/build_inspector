#!/usr/bin/env bash
#
source ./src/helper.sh

datafile=data/raw/repository_list.csv

while IFS="," read -r repository uuid
do
  make_tests_all_by_repository "${repository}" "${uuid}"
done < <(tail --lines=+2 ${datafile})
