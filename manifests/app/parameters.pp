# == Define: symfony::app::parameters
#
# This class should be considered private.
#
#
define symfony::app::parameters (
  $target     = $title,
  $parameters = {},
  $owner      = undef,
  $group      = undef,
) {
  include symfony

  $kernel_path = "${::symfony::target}/${::symfony::kernel_dir}"

  $target_real = $target ? {
    undef   => "${kernel_path}/${::symfony::config_dir}",
    default => $target,
  }

  validate_string($target_real)

  $owner_real = $owner ? {
    undef   => $::symfony::owner,
    default => $owner,
  }

  $group_real = $group ? {
    undef   => $::symfony::group,
    default => $group,
  }

  file { "${target_real}/parameters.yml":
    ensure  => file,
    content => template("${module_name}/app/parameters.erb"),
    owner   => $owner_real,
    group   => $group_real,
  }
}
