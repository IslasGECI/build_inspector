#!/usr/bin/env bash
#
# This script is used to run the tests in the latest corresponding Docker image.
#
# Usage: ./src/geci-maketests.sh <REPO> <UUID>
# Example: ./src/geci-maketests.sh isla-guadalupe 4fd77125-7f38-4996-b1e8-bbd337b338

REPO=$1
UUID=$2

function notify_healthchecks {
  curl \
    --fail \
    --max-time 10 \
    --output /dev/null \
    https://hc-ping.com/{$1}
}

git clone git@bitbucket.org:IslasGECI/${REPO}.git
cd ${REPO}
docker pull islasgeci/${REPO}:latest
docker run --volume ${PWD}:/workdir islasgeci/${REPO}:latest make tests \
    && notify_healthchecks ${UUID} \
    || notify_healthchecks ${UUID}/fail
