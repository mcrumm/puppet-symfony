define symfony::composer::config (
  $key            = $title,
  $values         = [],
  $global         = true,
  $cwd            = undef,
  $user           = undef,
  $composer_dir   = undef,
  $composer_home  = undef,
  $template       = 'symfony/composer/config.erb',
) {
  require ::composer
  include symfony

  $values_real = any2array($values)

  validate_string($key, $user, $template)
  validate_bool($global)
  validate_array($values_real)

  $composer_dir_real = $composer_dir ? {
    undef   => $::composer::target_dir,
    default => $composer_dir,
  }

  $composer_home_real = $composer_home ? {
    undef   => $::composer::composer_home,
    default => $composer_home,
  }

  $cwd_real = $cwd ? {
    undef   => $::symfony::cwd,
    default => $cwd,
  }

  $user_real = $user ? {
    undef   => $::symfony::user,
    default => $user,
  }

  exec { "symfony::composer::config::${key}":
    path        => "/bin:/usr/bin/:/sbin:/usr/sbin:${composer_dir_real}",
    cwd         => $cwd_real,
    command     => template($template),
    user        => $user_real,
    environment => "COMPOSER_HOME=${composer_home_real}"
  }
}
