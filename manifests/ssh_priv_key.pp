define accounts::ssh_priv_key (
  $user,
  $group,
  $homedir,
  $key,
) {

  file { "${homedir}/.ssh":
    ensure => 'directory',
    user   => $user,
    group  => $group,
    mode   => '0755',
  }
  file { "${homedir}/.ssh/id_rsa":
    content => hiera("node::${fqdn}::user::${user}::sshprivkey")
    user    => $user,
    group   => $group,
    mode    => '0600',
    require => User[$user],
  } 
}
