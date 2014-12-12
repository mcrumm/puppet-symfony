class symfony::params {
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

  if $::osfamily == 'Linux' and $::operatingsystem == 'Amazon' {
    $family = 'RedHat'
  } else {
    $family = $::osfamily
  }

  case $family {
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
}
