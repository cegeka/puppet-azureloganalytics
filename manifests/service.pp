# Class: azureloganalytics::service
#
# This is a private class and should not be called directly
#
class azureloganalytics::service (
  String  $service_ensure = $azureloganalytics::service_ensure,
  Array   $service_name   = $azureloganalytics::service_name,
  Boolean $service_enable = $azureloganalytics::service_enable
) {


  service { $service_name :
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => [
      Class['azureloganalytics::package'],
      File['/etc/systemd/system/omsagent.service']
    ]
  }

  # By default a service is created with the UUID in its name, link this to a service called omsagent
  file { '/etc/systemd/system/omsagent.service':
    ensure => link,
    target => "/usr/lib/systemd/system/omsagent-${azureloganalytics::workspaceid}.service"
  }

}
