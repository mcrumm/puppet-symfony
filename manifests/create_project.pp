# == Define: symfony::create_project
#
# Creates a new symfony project via composer's create-project command.
#
# === Parameters
#
# [*target_dir*]
#   Required: The directory where this project will be installed.
#
# [*project_name*]
#   The project name as required by composer. Defaults to resource title.
#
# [*version*]
#   The version of the composer project. Defaults to undefined.
#
# [*repository_url*]
#   A custom repository URL for the project. Defaults to undefined.
#
# [*user*]
#   The user name of this project's owner. Defaults to undefined.
#
# [*group*]
#   The name of this project's group. Defaults to undefined.
#
# [*timeout*]
#   The timeout, in seconds, for the composer exec. Defaults to 600.
#
# [*set_permissions*]
#   Whether or not to set user permissions on this project. Defaults to false.
#
# [*parameters*]
#   Optional: A hash for creating this project's parameters.yml file.
#
# [*commands*]
#   Optional: A hash of console commands to run after creating this project.
#
# === Authors
#
# Michael Crumm <mike@crumm.net>
#
define symfony::create_project (
  $target_dir,
  $project_name    = $title,
  $version         = undef,
  $repository_url  = undef,
  $user            = undef,
  $group           = undef,
  $set_permissions = false,
  $parameters      = {},
  $commands        = {},
  $timeout         = $::symfony::params::exec_timeout,
  $kernel_dir      = $::symfony::kernel_dir,
  $config_dir      = $::symfony::config_dir,
) {
  require ::composer
  include symfony

  $user_real = $user ? {
    undef   => $::symfony::user,
    default => $user,
  }

  $group_real = $group ? {
    undef   => $::symfony::group,
    default => $group,
  }

  composer::project { $project_name:
    project_name   => $project_name,
    target_dir     => $target_dir,
    version        => $version,
    repository_url => $repository_url,
    user           => $user_real,
    timeout        => $timeout,
  }

  unless empty($parameters) {
    symfony::app::parameters { "${target_dir}/${kernel_dir}/${config_dir}":
      parameters => $parameters,
      owner      => $user_real,
      group      => $group_real,
      require    => Composer::Project["${project_name}"],
    }
  }
}
