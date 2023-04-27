# Class: azureloganalytics::service
#
# This is a private class and should not be called directly
#
class azureloganalytics::service (
  String  $service_ensure   = $azureloganalytics::service_ensure,
  Array   $service_name     = $azureloganalytics::service_name,
  Boolean $service_enable  = $azureloganalytics::service_enable
) {


  service { $service_name :
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => [
      Class['azureloganalytics::package'],
      Exec['symlink-omsagent-service']
    ]
  }

  # By default a service is created with the UUID in its name, link this to a service called omsagent
  exec { 'symlink-omsagent-service':
    command => 'ln -s /usr/lib/systemd/system/omsagent-*.service /etc/systemd/system/omsagent.service',
    path    => [ '/usr/bin', '/bin', '/usr/sbin' ],
    creates => '/etc/systemd/system/omsagent.service',
    notify  => Exec['azureloganalytics-systemd-reload']
  }

  exec { 'azureloganalytics-systemd-reload':
    command     => 'systemctl daemon-reload',
    path        => [ '/usr/bin', '/bin', '/usr/sbin' ],
    refreshonly => true
  }

}
