define symfony::app::parameters (
  $target     = undef,
  $parameters = {},
  $filename   = 'parameters.yml',
  $owner      = undef,
  $group      = undef,
  $template   = 'symfony/app/parameters.erb',
) {
  include symfony

  $target_real = $target ? {
    undef   => "${::symfony::target}/${::symfony::kernel_dir}/${::symfony::config_dir}",
    default => $target,
  }

  validate_string($target_real, $filename, $template)

  $owner_real = $owner ? {
    undef   => $::symfony::owner,
    default => $owner,
  }

  $group_real = $group ? {
    undef   => $::symfony::group,
    default => $group,
  }

  file { "${target_real}/${filename}" :
    ensure  => file,
    content => template($template),
    owner   => $owner_real,
    group   => $group_real,
  }
}
