node default {

  notify { 'enduser-before': }
  notify { 'enduser-after': }

  class { 'syslog_ng':
    require => Notify['enduser-before'],
    before  => Notify['enduser-after'],
  }

}
