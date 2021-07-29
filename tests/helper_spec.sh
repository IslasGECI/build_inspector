Describe 'helper.sh'
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

  It 'pull_repository when repository already exists'
    mkdir --parents repository # Setup
    When call pull_repository repository branch
    The lines of stdout should equal 2
    The first line of output should equal "git checkout branch"
  End
End
