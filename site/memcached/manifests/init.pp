class memcached {
  package { 'memcached': ensure => 'present', }
  
  service { 'memcached':
    ensure     => 'running',
    enable     => 'true',
    hasrestart => 'true',
    require    => Package['memcached'],
  }
  
    file { "/etc/sysconfig/memcached":
    ensure    => 'file',
    mode      => '644',
    owner     => 'root',
    group     => 'root',
    source    => "puppet:///modules/memcached/memcached",
    require   => Package['memchached'],
    notify    => Service['memcached'],
  }
}
  
