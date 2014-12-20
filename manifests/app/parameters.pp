# == Define: symfony::app::parameters
#
# This class should be considered private.
#
#
define symfony::app::parameters (
  $target     = undef,
  $parameters = {},
  $filename   = 'parameters.yml',
  $owner      = undef,
  $group      = undef,
  $template   = 'symfony/app/parameters.erb',
) {
  include symfony

  $kernel_path = "${::symfony::target}/${::symfony::kernel_dir}"

  $target_real = $target ? {
    undef   => "${kernel_path}/${::symfony::config_dir}",
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
