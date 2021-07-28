#!/usr/bin/env bash
#
# This script is used to make all the Makefiles targets.
#
# Usage: ./src/geci-makeall.sh <REPO> <UUID>
# Example: ./src/geci-makeall.sh isla-guadalupe 4fd77125-7f38-4996-b1e8-bbd337b338

repository=$1
uuid=$2
branch=develop

source ./src/helper.sh

[ ! -d "${repository}" ] && git clone git@bitbucket.org:IslasGECI/${repository}.git
cd ${repository}
git checkout ${branch}
git pull
all_reports=$(jq --raw-output ".[].report" analyses.json)
error_count=0
i=0
for report_name in ${all_reports}
do
    image_tag=$(jq --raw-output ".[${i}].image_tag" analyses.json)
    log="${report_name}@${repository}:${image_tag}"
    notify_healthchecks ${uuid}/start ${log}
    echo ""
    echo "# $(( ${i} + 1)):"
    echo "${log}"
    echo "........................................"
    echo ""
    docker pull islasgeci/${repository}:${image_tag}
    docker run --env BITBUCKET_USERNAME=${BITBUCKET_USERNAME} --env BITBUCKET_PASSWORD=${BITBUCKET_PASSWORD} --rm --volume ${PWD}:/workdir islasgeci/${repository}:${image_tag} bash -c "make clean && make reports/${report_name}" \
        && notify_healthchecks ${uuid} ${log} \
        || ( notify_healthchecks ${uuid}/fail ${log} ; ((error_count = error_count + 1)) )
    ((i = i + 1))
done
log="geci-makeall@${repository}:develop"
echo ""
echo "${log}"
echo "----------------------------------------"
echo "Error count: ${error_count}"
sleep 10
if [ ${error_count} -eq 0 ]
then
    notify_healthchecks ${uuid} ${log}
    echo "PASS"
else
    notify_healthchecks ${uuid}/fail ${log}
    echo "FAIL"
fi
echo ""
