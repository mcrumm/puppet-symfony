# == Class: symfony::params
#
# This class should be considered private.
#
#
class symfony::params {
  if $::osfamily == 'Linux' and $::operatingsystem == 'Amazon' {
    $family = 'RedHat'
  } else {
    $family = $::osfamily
  }

  case $family {
    'Darwin': {
      $user   = '_www'
      $group  = '_www'
    }
    'Debian': {
      $user   = 'www-data'
      $group  = 'www-data'
    }
    'RedHat', 'Centos': {
      $user   = 'apache'
      $group  = 'apache'
    }
    default: {
      fail("Unsupported platform: ${family}")
    }
  }

  $owner        = $user
  $console      = 'console'
  $kernel_dir   = 'app'
  $config_dir   = 'config'
  $logs_dir     = 'logs'
  $web_dir      = 'web'
  $env          = 'dev'
  $scripts      = true
  $interactive  = false
  $verbosity    = false
  $logoutput    = false
  $exec_timeout = 600
}
