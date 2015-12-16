# = Class: wordpress::install

class wordpress::install {
  exec { 'download_wp':
  	command      => 'wget http://wordpress.org/latest.tar.gz -O /tmp/latest.tar.gz',
  	path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
  	refreshonly => true,
  }
  exec { 'extract_wp':
        cwd => "/tmp",
        command => "tar -xvzf latest.tar.gz",
        require => File['/tmp/latest.tar.gz'],
        path => ['/bin'],
    }
  exec { 'copy_wp':
        command => "cp -r /tmp/wordpress/* /var/www/",
        require => Exec['extract_wp'],
        path => ['/bin'],
    }
  file { '/var/www/wp-config.php':
        ensure => present,
        require => Exec['copy_wp'],
        content => template("wordpress/wp-config.php.erb")
  }
}
