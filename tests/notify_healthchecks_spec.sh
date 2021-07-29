Describe 'notify_healthchecks'
  Include src/helper.sh

  Mock curl
    echo "curl $@"
  End

  It 'notifies healtchecks with uuid and message'
    When call notify_healthchecks uuid mensaje
    The stdout should eq "curl --data-raw mensaje --fail --max-time 10 --output /dev/null --retry 5 --show-error --silent https://hc-ping.com/uuid"
  End
End
