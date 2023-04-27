# Class: azureloganalytics
#
# This module manages Azure Log Analytics Agent
#
# Parameters:
#
# @param workspaceid
#   Use workspace ID for automatic onboarding."
#
# @param sharedkey
#   Use <key> as the shared key for automatic onboarding."
#
# @param url
#   Use <url> as the OMS domain for onboarding.."
#   default: opinsights.azure.com"
#
# @param package_ensure
#   Controls if the managed resources shall be `present` or `absent`.
#
# @param package_name
#   Name Of the package to install.
#
# @param service_enable
#   Enable the service on boot.
#
# @param service_ensure
#   Control if the service is `running` or `stopped`.
#
# @param service_name
#   A list of services to manage.
#
# @param cef_enable
#   Control to manage the Azure Log Analytics CEF forwarding on port 25226.
#
# @param omshelper_disable
#   Control to manage the Azure Log Analytics OMS Cloud sync.
#
class azureloganalytics (
  String                      $workspaceid,
  String                      $sharedkey,
  Enum['absent', 'present']   $package_ensure = $::azureloganalytics::params::package_ensure,
  Array                       $package_name   = $::azureloganalytics::params::package_name,
  Boolean                     $service_enable = $::azureloganalytics::params::service_enable,
  Enum['stopped', 'running']  $service_ensure = $::azureloganalytics::params::service_ensure,
  Array                       $service_name   = $::azureloganalytics::params::service_name,
  String                      $url            = $::azureloganalytics::params::url,
  Boolean                     $cef_enable     = $::azureloganalytics::params::cef_enable,
  Boolean                     $omshelper_disable = $azureloganalytics::params::omshelper_disable
) inherits azureloganalytics::params {

  contain 'azureloganalytics::package'
  contain 'azureloganalytics::onboarding'
  contain 'azureloganalytics::config'
  contain 'azureloganalytics::service'

}
