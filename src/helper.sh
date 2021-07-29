function notify_healthchecks {
  curl \
    --data-raw "$2" \
    --fail \
    --max-time 10 \
    --output /dev/null \
    --retry 5 \
    --show-error \
    --silent \
    https://hc-ping.com/"$1"
}

function pull_repository {
  repository=$1
  branch=$2
  [ ! -d "${repository}" ] && git clone git@bitbucket.org:IslasGECI/${repository}.git
  cd ${repository}
  git checkout ${branch}
  git pull
}
