class symfony (
  $target,
  $env          = $symfony::params::env,
  $kernel_dir   = $symfony::params::kernel_dir,
  $project      = $kernel_dir,
  $console      = $symfony::params::console,
  $config_dir   = $symfony::params::config_dir,
  $logs_dir     = $symfony::params::logs_dir,
  $web_dir      = $symfony::params::web_dir,
  $scripts      = $symfony::params::scripts,
  $interactive  = $symfony::params::interactive,
  $verbosity    = $symfony::params::verbosity,
  $user         = $symfony::params::user,
  $owner        = $symfony::params::owner,
  $group        = $symfony::params::group,
  $exec_timeout = $symfony::params::exec_timeout,
  $logoutput    = $symfony::params::logoutput,
  $parameters   = hiera_hash('symfony::app::parameters', {}),
  $commands     = hiera_hash('symfony::app::commands', {}),
) inherits symfony::params {

  Symfony::App::Parameters <| |> -> Symfony::App::Command <| |>

  $project_real = "symfony/${project}"

  $composer_verbose = $verbosity ? {
    '-v'    => true,
    '-vv'   => true,
    '-vvv'  => true,
    default => $verbosity,
  }

  ::composer::exec { $project_real:
    cmd         => 'install',
    cwd         => $target,
    scripts     => $scripts,
    interaction => $interactive,
    optimize    => true,
    verbose     => $composer_verbose,
    timeout     => $exec_timeout,
    logoutput   => $logoutput,
  }

  if $parameters {
    symfony::app::parameters { $project_real:
      target      => "${target}/${kernel_dir}/${config_dir}",
      parameters  => $parameters,
      owner       => $owner,
      group       => $group,
      before      => ::Composer::Exec[$project_real],
    }
  }

  if $commands {
    create_resources('symfony::app::command', $commands, {
      'cwd'       => $target,
      'user'      => $user_real,
      'verbosity' => $verbosity,
      'logoutput' => $logoutput,
      'require'   => ::Composer::Exec[$project_real],
    })
  }
}
