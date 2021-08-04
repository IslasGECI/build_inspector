#!/usr/bin/env bash
#
# This script is used to run the tests in the latest corresponding Docker image.
#
# Usage: ./src/geci-maketests.sh <REPO> <UUID>
# Example: ./src/geci-maketests.sh isla-guadalupe 4fd77125-7f38-4996-b1e8-bbd337b338

repository=$1
uuid=$2
branch=develop
image_tag=latest

source ./src/helper.sh

log="tests@${repository}:${image_tag}"
notify_healthchecks "${uuid}/start" "${log}"
pull_repository "${repository}" "${branch}"
docker pull "islasgeci/${repository}:${image_tag}"
if docker run --volume "${PWD}":/workdir "islasgeci/${repository}:${image_tag}" bash -c "make setup && make tests"
then
    notify_healthchecks "${uuid}" "${log}"
else
    notify_healthchecks "${uuid}/fail" "${log}"
fi
