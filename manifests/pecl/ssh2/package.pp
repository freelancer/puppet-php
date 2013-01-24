# == Class: php::pecl::ssh2::package
#
# Install the PHP ssh2 extension
#
# === Parameters
#
# [*version*]
#   The version of ssh2 to install
#   Could be "latest", "installed" or a pinned verison
#
# [*package*]
#   The package name for ssh2
#   For debian it's php5-ssh2
#
# [*provider*]
#   The provider used to install php5-ssh2
#   Could be "pecl", "apt" or any other OS package provider
#
# === Variables
#
# No variables
#
# === Examples
#
#  include 'php::pecl::ssh2::package'
#
#  class {'php::pecl::ssh2::package':
#   version => latest
#  }
#
# === Authors
#
# Christian Winther <cw@nodes.dk>
#
# === Copyright
#
# Copyright 2012-2013 Nodes, unless otherwise noted.
#
class php::pecl::ssh2::package(
  $version  = $php::pecl::ssh2::params::version,
  $package  = $php::pecl::ssh2::params::package,
  $provider = $php::pecl::ssh2::params::provider
) inherits php::pecl::ssh2::params {

  php::pecl::package { 'ssh2':
    version  => $version,
    package  => $package,
    provider => $provider
  }

}
