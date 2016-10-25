# Class: datadog_agent::reports
#
# This class configures the puppetmaster for reporting back to
# the datadog service.
#
# Parameters:
#   $api_key:
#       Your DataDog API Key. Please replace with your key value
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class datadog_agent::reports(
  $api_key,
  $puppet_gem_provider,
  $puppetmaster_user,
  $dogapi_version,
  $hostname_extraction_regex = nil
) {

  file { '/etc/dd-agent/datadog.yaml':
    ensure  => file,
    content => template('datadog_agent/datadog.yaml.erb'),
    owner   => $puppetmaster_user,
    group   => 'root',
    mode    => '0640',
    require => File['/etc/dd-agent'],
  }

  package{ 'dogapi':
    ensure   => $dogapi_version,
    provider => $puppet_gem_provider,
  }
}
