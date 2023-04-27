# Class: azureloganalytics::config
#
# This is a private class and should not be called directly
#
class azureloganalytics::config (
  $cef_enable = $azureloganalytics::cef_enable,
  $omshelper_disable = $azureloganalytics::omshelper_disable
) inherits azureloganalytics::params {

  if ($omshelper_disable and $cef_enable) {
    $omshelper_content = 'a'
    $ensure_file = present
  } else {
    $omshelper_content = undef
    $ensure_file = absent
  }

  file { '/etc/opt/omi/conf/omsconfig/omshelper_disable':
    ensure  => $ensure_file,
    content => $omshelper_content
  }

  file { '/etc/opt/microsoft/omsagent/conf/omsagent.d/security_events.conf':
    ensure => $ensure_file,
    source => 'puppet:///modules/azureloganalytics/security_events.conf',
    notify => Service[$azureloganalytics::service_name]
  }

  sudo::config::cmnd_alias { 'omsagent-cmd':
    configuration => 'OMSAGENT = /bin/python3, /bin/pkill, /opt/microsoft/*'
  }

  sudo::config::user { 'omsagent':
    user => 'omsagent',
    configuration => 'ALL = NOPASSWD: OMSAGENT'
  }

}
