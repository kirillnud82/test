name 'monitoring'
description 'Monitoring server'

run_list(
  'recipe[nagios::server]'
)

default_attributes(
  :nagios => {
    :server_auth_method => 'nagios',
    :url => '10.2.1.196/nagios'
  }
)
