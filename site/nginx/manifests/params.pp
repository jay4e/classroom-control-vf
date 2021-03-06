class nginx::params {
  case $::os['family'] {
    'Redhat': {
       $package = 'nginx'
       $owner = 'root'
       $group = 'root'
       $root_dir = ''
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
       $conf_dir = 'nginx'
       $log_dir = 'nginx/logs'
       $service_name = 'nginx'
       $service_user = 'nobody'
    }
  }
}
