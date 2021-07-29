Describe 'notify_healthchecks'
  Include src/helper.sh

  Mock curl
    echo "curl $@"
  End

  It 'notifies healtchecks with uuid and message'
    When call notify_healthchecks uuid mensaje
    The stdout should eq "curl --data-raw mensaje --fail --max-time 10 --output /dev/null --retry 5 --show-error --silent https://hc-ping.com/uuid"
  End

  Mock git
    echo "git $@"
  End

  It 'notifies pull_repository with repository and branch when there is not the repository'
    When call pull_repository repository branch
    The lines of stdout should equal 3
    The stderr should be present
    The first line of output should equal "git clone git@bitbucket.org:IslasGECI/repository.git"
  End
End
