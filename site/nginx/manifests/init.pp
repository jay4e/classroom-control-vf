
class nginx {
  
  case $family {
    'Redhat': {
       $package = 'nginx'
       $owner = 'root'
       $group = 'root'
       $root_dir = ''
       $document_dir = 'var/www'
       $conf_dir = 'etc/nginx'
       $log_dir = 'var/log/nginx'
       $service_name = 'nginx'
       $service_user = 'nginx'
    }
    'Debian': {
       $package = 'nginx'
       $owner = 'root'
       $group = 'root'
       $root_dir = ''
       $document_dir = 'var/www'
       $conf_dir = 'etc/nginx'
       $log_dir = 'var/log/nginx'
       $service_name = 'nginx'
       $service_user = 'nginx'
    }
    'Windows': {
       $package = 'nginx-service'
       $owner = 'Administrator'
       $group = 'Administor'
       $root_dir = 'C:/ProgramData'
       $document_dir = 'nginx/html'
       $conf_dir = 'nginx'
       $log_dir = 'nginx/logs'
       $service_name = 'nginx'
       $service_user = 'nobody'
    }
       
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
    source    => 'puppet:///modules/nginx/nginx.conf',
    require   => Package[$package],
    notify    => Service[$service_name],
  }
  file { "$root_dir/$conf_dir/conf.d/default.conf":
    ensure    => 'file',
    source    => 'puppet:///modules/nginx/default.conf',
    require   => Package[$package],
    notify    => Service[$service_name],
  }
  
  service { '$service_name:
    ensure     => 'running',
    enable     => 'true',
    hasrestart => 'true',
    require    => Package[$package]
  }
}
