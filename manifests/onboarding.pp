# Class: azureloganalytics::onboarding
#
# This is a private class and should not be called directly
#
class azureloganalytics::onboarding (
  String $workspaceid = $azureloganalytics::workspaceid,
  String $sharedkey = $azureloganalytics::sharedkey,
  String $ensure = $azureloganalytics::package_ensure,
  String $onboarding_config = $azureloganalytics::params::onboarding_config,
  String $url = $azureloganalytics::url
) inherits azureloganalytics::params {

  file { $onboarding_config :
    ensure  => $ensure,
    content => template('azureloganalytics/onboarding.conf.erb')
  }

}
