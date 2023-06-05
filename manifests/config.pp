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

  sudo::config::default_entry { 'omsagent_requiretty' :
    type          => 'user',
    configuration => 'omsagent !requiretty',
  }

  sudo::config::default_entry { 'omsagent_lecture' :
    type          => 'user',
    configuration => 'omsagent lecture = never',
  }

  sudo::config::cmnd_alias { 'omsagent-cmd':
    configuration => 'OMSAGENT = /usr/bin/test, /bin/touch, /bin/python, /bin/python2, /bin/python3, /bin/pkill, /opt/microsoft/*',
  }

  sudo::config::user { 'omsagent':
    user          => 'omsagent',
    configuration => 'ALL = NOPASSWD: OMSAGENT',
  }

  sudo::config::default_entry { 'nxautomation_requiretty' :
    type          => 'user',
    configuration => 'nxautomation !requiretty',
  }

  sudo::config::default_entry { 'nxautomation_lecture' :
    type          => 'user',
    configuration => 'nxautomation lecture = never',
  }

  sudo::config::user { 'nxautomation':
    user          => 'omsagent',
    configuration => 'ALL = NOPASSWD: ALL',
  }

  $rsyslog_config = {
    'udp_syslog_reception' => {
      'content' => [
        '$ModLoad imudp',
        '$UDPServerRun 514',
      ]
    },
    'tcp_syslog_reception' => {
      'content' => [
        '$ModLoad imtcp',
        '$InputTCPServerRun 514',
      ]
    },
    'syslog-config-omsagent' => {
      'content' => [
        'if not($rawmsg contains "CEF:") and not($rawmsg contains "ASA-") then @127.0.0.1:25224',
        'if not($rawmsg contains "CEF:") and not($rawmsg contains "ASA-") then /var/log/no-cef.log',
      ]
    },
    'security-config-omsagent' => {
      'content' => [
        'if $rawmsg contains "CEF:" or $rawmsg contains "ASA-" then @@127.0.0.1:25226',
        'if $rawmsg contains "CEF:" or $rawmsg contains "ASA-" then /var/log/cef.log',
      ]
    }
  }

  create_resources('::rsyslog::config::directives',$rsyslog_config)
}
