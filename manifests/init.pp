# == Class: accounts
#
# Full description of class accounts here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'accounts':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Sebastian Reitenbach <sebastia@l00-bugdead-prods.de>
#
# === Copyright
#
# Copyright 2014 Sebastian Reitenbach, unless otherwise noted.
#
class accounts {

  $vgroups         = hiera_hash('accounts::virtual::groups')
  $vusers          = hiera_hash('accounts::virtual::users')
  $vsshkeys        = hiera_hash('accounts::virtual::sshkeys')
  $vsshprivkeys    = hiera_hash('accounts::virtual::sshprivkeys')
  $vuser_defaults  = hiera_hash('accounts::virtual::userdefaults')
  $vgroup_defaults = hiera_hash('accounts::virtual::groupdefaults')
  create_resources('@group', $vgroups, $vgroup_defaults)
  create_resources('@user', $vusers, $vuser_defaults)
  create_resources('@ssh_authorized_key', $vsshkeys)
  create_resources('@accounts::ssh_priv_key', $vsshprivkeys)

  $groups      = hiera_array('accounts::groups')
  $users       = hiera_array('accounts::users')
  $sshkeys     = hiera_array('accounts::sshkeys')
  $sshprivkeys = hiera_array('accounts::sshprivkeys')

  realize(Group[$groups])
  realize(User[$users])
  realize(Ssh_authorized_key[$sshkeys])
  realize(Accounts::Ssh_priv_key[$sshprivkeys])
}
