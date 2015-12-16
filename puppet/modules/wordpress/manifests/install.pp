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
  file { '/home/blogger/wp-config.php':
        ensure => present,
        require => Exec['copy_wp'],
        content => template("wordpress/wp-config.php.erb")
  }
}
