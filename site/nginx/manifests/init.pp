
class nginx( 
       $package = $nginx::params::package,
       $owner = $nginx::params::owner,
       $group = $nginx::params::group,
       $root_dir = $nginx::params::root_dir,
       $document_dir = $nginx::params::document_dir,
       $conf_dir = $nginx::params::conf_dir,
       $log_dir = $nginx::params::log_dir,
       $service_name = $nginx::params::service_name,
       $service_user = '$nginx::params::service_user,
       )
    inherits nginx::params {
       
  package { $package: ensure => present }
       
  File {
    owner  => $owner,
    group => $group,
    mode  => '0664'
  }
  
  file { "$root_dir/$document_dir":
    ensure => 'directory',
  }
  file { "$root_dir/$document_dir/index.html":
    ensure    => 'file',
    source    => 'puppet:///modules/nginx/index.html',
  }
  
  file { "$root_dir/$conf_dir/nginx.conf":
    ensure    => 'file',
    content   => template('nginx/nginx.conf.erb'),
    require   => Package[$package],
    notify    => Service[$service_name],
  }
  file { "$root_dir/$conf_dir/conf.d/default.conf":
    ensure    => 'file',
    content   => template("nginx/default.conf.erb"),
    require   => Package[$package],
    notify    => Service[$service_name],
  }
  
  service { $service_name:
    ensure     => 'running',
    enable     => 'true',
    hasrestart => 'true',
    require    => Package[$package]
  }
}
