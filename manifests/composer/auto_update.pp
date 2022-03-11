# Install composer package manager
#
# === Parameters
#
# [*max_age*]
#   Defines number of days after which Composer should be updated.
#   This gets overriden if $version is set
#
# [*path*]
#   Holds path to the Composer executable
#
# [*source*]
#   Holds URL to the Composer source file
#
# [*version*]
#   Optionally pin Composer to a specific version
#
# [*proxy_type*]
#    proxy server type (none|http|https|ftp)
#
# [*proxy_server*]
#   specify a proxy server, with port number if needed. ie: https://example.com:8080.
#
#
# === Examples
#
#  include php::composer::auto_update
#  class { "php::composer::auto_update":
#    "max_age" => 90
#  }
#
class php::composer::auto_update (
  $max_age,
  $path,
  $source,
  $version,
  $proxy_type   = undef,
  $proxy_server = undef,
) {

  if $caller_module_name != $module_name {
    warning('php::composer::auto_update is private')
  }

  if $proxy_type and $proxy_server {
    $env = [ 'HOME=/root', "${proxy_type}_proxy=${proxy_server}" ]
  } else {
    $env = [ 'HOME=/root' ]
  }

  if ($version) {
    warning("Pinning Composer to version ${version} by running 'composer self-update ${version}'")
    $onlyif = "test `find '${path}'`"
  } else {
    $onlyif = "test `find '${path}' -mtime +${max_age}`"
  }

  exec { 'update composer':
    command     => "${path} --no-interaction --quiet self-update ${version}",
    environment => $env,
    onlyif      => $onlyif,
    path        => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/', '/usr/local/bin', '/usr/local/sbin' ],
    require     => [File[$path], Class['::php::cli']],
  }
}
