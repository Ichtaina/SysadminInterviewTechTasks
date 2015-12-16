# = Class: wordpress::install

class wordpress::install {

  file { 'latest.tar.gz':
	path    => '/tmp/latest.tar.gz',
        source  => "puppet:///modules/wordpress/latest.tar.gz",
        ensure => present,
	}
  exec { 'extract_wp':
        cwd => "/tmp",
        command => "tar -xvzf latest.tar.gz",
        require => File['/tmp/latest.tar.gz'],
        path => ['/bin'],
    }
  exec { 'copy_wp':
        command => "cp -r /tmp/wordpress/* /home/blogger/wordpress",
        require => Exec['extract_wp'],
        path => ['/bin'],
    }
  exec { 'permissions_wp':
    command      => 'chown www-data:www-data /home/blogger/wordpress -R',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    require     => Exec['copy_wp'],
    refreshonly => true,
  }
  file { '/home/blogger/wp-config.php':
        ensure  => present,
        owner   => 'www-data',
        group   => 'www-data',
        mode    => '755',
        require => Exec['permissions_wp'],
        content => template("wordpress/wp-config.php.erb")
  }
}
