
class nginx {
  
  package { 'nginx': ensure => present }
  
  file { '/var/www':
    ensure => 'directory',
    user  => 'root',
    group => 'root',
    mode  => '0644'
  }
  file { '/var/www/index.html':
    ensure    => 'file',
    mode      => '644',
    owner     => 'root',
    group     => 'root',
    source    => 'puppet:///modules/nginx/index.html',
  }
  
  file { '/etc/nginx/nginx.conf':
    ensure    => 'file',
    mode      => '644',
    owner     => 'root',
    group     => 'root',
    source    => 'puppet:///modules/nginx/nginx.conf',
    require   => Package['nginx'],
    notify    => Service['nginx'],
  }
  file { '/etc/nginx/conf.d/default.conf':
    ensure    => 'file',
    mode      => '644',
    owner     => 'root',
    group     => 'root',
    source    => 'puppet:///modules/nginx/default.conf',
    require   => Package['nginx'],
    notify    => Service['nginx'],
  }
  
  service { 'nginx':
    ensure     => 'running',
    enable     => 'true',
    hasrestart => 'true',
    require    => Package['nginx']
  }