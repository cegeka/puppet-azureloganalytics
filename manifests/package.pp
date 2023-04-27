# Class: azureloganalytics::package
#
# This is a private class and should not be called directly
#
class azureloganalytics::package (
  String $package_ensure = $azureloganalytics::package_ensure,
  Array  $package_name   = $azureloganalytics::package_name,
) inherits azureloganalytics {

  package { $package_name :
    ensure  => $package_ensure,
    require => File[$azureloganalytics::onboarding_config]
  }

}
