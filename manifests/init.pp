class symfony (
  $php_bin    = $symfony::params::php_bin,
  $console    = $symfony::params::console,
  $kernel_dir = $symfony::params::kernel_dir,
  $web_dir    = $symfony::params::web_dir
) inherits symfony::params {

  notify('Loading Symfony!');
}
