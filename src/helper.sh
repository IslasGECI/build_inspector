function pull_repository {
  repository=$1
  branch=$2
  [ ! -d "${repository}" ] && git clone git@bitbucket.org:IslasGECI/"${repository}".git
  cd "${repository}" || return
  git checkout "${branch}"
  git pull
}


function test_and_make_all_by_repository {
  repository=${1}
  uuid=${2}
  echo ""
  echo "========================================"
  echo "Repository: ${repository}"
  echo "UUID: ${uuid}"
  ./src/geci-maketests.sh "${repository}" "${uuid}"
  ./src/geci-makeall.sh "${repository}" "${uuid}"
  echo ""
}