define user::managed_user (
    $home = undef,
    $group = $title,
    $ssh_key_file = undef
    ) {
  include httpd

  if $home {
    $home_dir = $home
  } else {
    $home_dir = "/home/${title}"
  }
 
  user { $title:
    ensure => 'present',
    gid => $group,
    home => $home_dir,
  }
  
  File {
    owner   => $title,
    group   => $group,
    mode    => '0600',
  }
  
  file { [$home_dir, "${home_dir}/.ssh":
    ensure  => 'directory',
    require => User[$title]
  }
  
  if $ssh_key_file: {
    file {
      ensure => 'file',
      source => $ssh_key_file,
    }
  }
    
}
