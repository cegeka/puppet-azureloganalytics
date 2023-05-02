# Class: azureloganalytics::proxy
#
# This is a private class and should not be called directly
#
class azureloganalytics::proxy (
  String  $proxy_ensure   = $azureloganalytics::proxy_ensure,
  String  $proxy_config   = $azureloganalytics::params::proxy_config,
  String  $proxy_protocol = $azureloganalytics::proxy_protocol,
  Integer $proxy_port     = $azureloganalytics::proxy_port,
  Variant[String,Undef] $proxy_username = $azureloganalytics::proxy_username,
  Variant[String,Undef] $proxy_password = $azureloganalytics::proxy_password,
  Variant[String,Undef] $proxy_host     = $azureloganalytics::proxy_host
) inherits azureloganalytics::params {

  if ($proxy_username and $proxy_password) {
    $proxy_url = "${proxy_protocol}://${proxy_username}:${proxy_password}@${proxy_host}:${proxy_port}"
  } else {
    $proxy_url = "${proxy_protocol}://${proxy_host}:${proxy_port}"
  }

  file { $proxy_config :
    ensure  => $proxy_ensure,
    content => $proxy_url,
    notify  => Service[$azureloganalytics::service_name]
  }

}
