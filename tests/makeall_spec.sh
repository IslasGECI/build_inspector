Describe 'geci-makeall.sh'

  setup() {
    mkdir --parents repositorio
    echo '[{"image_tag": "abcd","report": "reporte_1.pdf"},{"image_tag": "wxyz","report": "reporte_2.pdf"}]' > repositorio/analyses.json
    }

  BeforeAll 'setup'

  Mock curl
    echo "curl $@"
  End

  Mock git
    echo "git $@"
  End

  Mock docker
    echo "docker $@"
  End

  It 'Notifies healtchecks.io'
    output_head="curl --data-raw"
    output_tail="--fail --max-time 10 --output /dev/null --retry 5 --show-error --silent https://hc-ping.com/1234567890"
    When call src/geci-makeall.sh repositorio 1234567890
    The lines of stdout should equal 26
    The line 3 of output should equal "${output_head} reporte_1.pdf@repositorio:abcd ${output_tail}/start"
    The line 6 of output should equal "reporte_1.pdf@repositorio:abcd"
    The line 15 of output should equal "reporte_2.pdf@repositorio:wxyz"
    The line 25 of output should equal "${output_head} geci-makeall@repositorio:develop ${output_tail}"
    The line 26 of output should equal "PASS"
  End
End
