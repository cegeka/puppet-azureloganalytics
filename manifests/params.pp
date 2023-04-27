# Class: azureloganalytics::params
#
# This is a private class and should not be called directly
#
class azureloganalytics::params (
  $service_enable = true,
  $service_ensure = 'running',
  $service_name = ['omid','omsagent'],
  $package_ensure = 'present',
  $package_name = ['omi','omsagent','omsconfig','scx'],
  $url = 'opinsights.azure.com',
  $cef_enable = false,
  $omshelper_disable = false,
  $onboarding_config = '/etc/omsagent-onboard.conf'
) {

}
