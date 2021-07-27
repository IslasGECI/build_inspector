#!/usr/bin/env bash
#
# This script is used to run the tests in the latest corresponding Docker image.
#
# Usage: ./src/geci-maketests.sh <REPO> <UUID>
# Example: ./src/geci-maketests.sh isla-guadalupe 4fd77125-7f38-4996-b1e8-bbd337b338

REPO=$1
UUID=$2
BRANCH=develop
TAG=latest

source ./src/helper.sh

[ ! -d "${REPO}" ] && git clone git@bitbucket.org:IslasGECI/${REPO}.git
cd ${REPO}
git checkout ${BRANCH}
git pull
docker pull islasgeci/${REPO}:${TAG}
docker run --volume ${PWD}:/workdir islasgeci/${REPO}:${TAG} bash -c "make setup && make tests" \
    && notify_healthchecks ${UUID} \
    || notify_healthchecks ${UUID}/fail
