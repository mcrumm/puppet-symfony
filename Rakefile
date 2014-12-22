require 'puppetlabs_spec_helper/rake_tasks'
require 'puppet-syntax/tasks/puppet-syntax'
require 'puppet-lint/tasks/puppet-lint'

# Forsake support for Puppet 2.6.2 for the benefit of cleaner code.
# http://puppet-lint.com/checks/class_parameter_defaults/
PuppetLint.configuration.send('disable_class_parameter_defaults')
# http://puppet-lint.com/checks/class_inherits_from_params_class/
PuppetLint.configuration.send('disable_class_inherits_from_params_class')

exclude_paths = [
  "pkg/**/*",
  "vendor/**/*",
  "spec/**/*",
  "tests/**/*",
]

Rake::Task[:lint].clear
PuppetLint.configuration.ignore_paths = exclude_paths
PuppetSyntax.exclude_paths = exclude_paths

task :default => [
  :syntax,
  :lint,
  :spec,
]
