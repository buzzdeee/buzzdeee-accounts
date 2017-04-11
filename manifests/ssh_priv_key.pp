# This defined type takes care
# to maintain private keys of managed users
define accounts::ssh_priv_key (
  $user,
  $group,
  $homedir,
  $key,
) {

  file { "${homedir}/.ssh":
    ensure => 'directory',
    owner  => $user,
    group  => $group,
    mode   => '0755',
  }
  file { "${homedir}/.ssh/id_rsa":
    content => $key,
    owner   => $user,
    group   => $group,
    mode    => '0600',
    require => User[$user],
  }
}
