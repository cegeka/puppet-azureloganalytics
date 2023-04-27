# Class: azureloganalytics
#
# This module manages Azure Log Analytics Agent
#
# Parameters:
#
# @param package_ensure
#   Controls if the managed resources shall be `present` or `absent`.
#   If set to `absent`, the managed software packages will be uninstalled, and
#   any traces of the packages will be purged as well as possible, possibly
#   including existing configuration files.
#   System modifications (if any) will be reverted as well as possible (e.g.
#   removal of created users, services, changed log settings, and so on).
#   This is a destructive parameter and should be used with care.
#
# @param package_name
#   Name Of the package to install.
#
# @param service_enable
# @param service_ensure
# @param service_manage
# @param service_name
# @param url
# @param cef_enable
# @param omshelper_disable
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
class azureloganalytics (
  String                      $workspaceid,
  String                      $sharedkey,
  Enum['absent', 'present']   $package_ensure = $::azureloganalytics::params::package_ensure,
  Array                       $package_name   = $::azureloganalytics::params::package_name,
  Boolean                     $service_enable = $::azureloganalytics::params::service_enable,
  Enum['stopped', 'running']  $service_ensure = $::azureloganalytics::params::service_ensure,
  Boolean                     $service_manage = $::azureloganalytics::params::service_manage,
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
