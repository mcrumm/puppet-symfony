# == Define: symfony::app::command
#
# This class should be considered private.
#
#
define symfony::app::command (
  $cwd,
  $command      = $title,
  $env          = undef,
  $user         = undef,
  $environment  = [],
  $verbosity    = false,
  $logoutput    = false,
  $template     = 'symfony/app/command.erb',
) {
  require ::composer
  include symfony

  $console_real = "${::symfony::kernel_dir}/${::symfony::console}"
  $command_real = "${::composer::php_bin} ${console_real} ${command}"

  $user_real = $user ? {
    undef   => $::symfony::user,
    default => $user,
  }

  $verbosity_real = $verbosity ? {
    true    => '-v',
    false   => '',
    default => $verbosity,
  }

  $env_real = $env ? {
    undef   => $::symfony::env,
    default => $env,
  }

  exec { "${cwd}/${command}_${env_real}":
    command     => template($template),
    cwd         => $cwd,
    user        => $user_real,
    environment => $environment,
    logoutput   => $logoutput,
  }
}
