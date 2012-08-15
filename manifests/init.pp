# Class: syslog_ng
#
#   This module manages the syslog-ng service.
#
# Parameters:
#
# Actions:
#
#  Installs, configures, and manages the syslog-ng service.
#
# Requires:
#
# Sample Usage:
#
#   class { "syslog_ng":
#     autoupdate => false,
#   }
#
# [Remember: No empty lines between comments and class definition]
class syslog_ng (
  $ensure="running",
  $autoupdate=false
) {
  include syslog_ng::params
  if ! ($ensure in [ "running", "stopped" ]) {
    fail("ensure parameter must be running or stopped")
  }

  if $autoupdate == true {
    $package_ensure = latest
  } elsif $autoupdate == false {
    $package_ensure = present
  } else {
    fail("autoupdate parameter must be true or false")
  }

  if ($syslog_ng::params::supported == true) {

    package { 'syslog-ng':
      name   => $syslog_ng::params::pkg_name,
      ensure => $package_ensure,
    }

    file { $syslog_ng::params::config:
      ensure  => file,
      owner   => root,
      group   => root,
      mode    => 0644,
      content => template("${module_name}/${syslog_ng::params::config_tpl}"),
      require => Package['syslog-ng'],
    }

    service { "syslog-ng":
      ensure     => $ensure,
      name       => $syslog_ng::params::svc_name,
      hasstatus  => true,
      hasrestart => true,
      subscribe  => [ Package['syslog-ng'], File[$syslog_ng::params::config] ],
    }

  }

}
