class syslog_ng::params {
  case $::operatingsystem {
    debian, ubuntu: {
      $supported       = false
      $pkg_name        = [ "syslog-ng" ]
      $svc_name        = "syslog-ng"
      $config          = "/etc/syslog-ng/syslog-ng.conf"
      $config_tpl      = "syslog-ng.conf.debian.erb"
    }
    gentoo: {
      $supported       = true
      $pkg_name        = [ "syslog-ng" ]
      $svc_name        = "syslog-ng"
      $config          = "/etc/syslog-ng/syslog-ng.conf"
      $config_tpl      = "syslog-ng.conf.gentoo.erb"
    }
    centos, redhat, oel, linux: {
      $supported       = false
      $pkg_name        = [ "syslog-ng" ]
      $svc_name        = "syslog-ng"
      $config          = "/etc/syslog-ng/syslog-ng.conf"
      $config_tpl      = "syslog-ng.conf.el.erb"
    }
    default: {
      $supported = false
    }
  }
  if $supported == false {
    notify { "${module_name}_unsupported":
      message => "The ${module_name} module is not supported on ${operatingsystem}",
    }    
  }
}
