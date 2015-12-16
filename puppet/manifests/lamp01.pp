node lamp01 {
    user { 'blogger':
      comment  => 'Blogger user',
      home     => '/home/blogger',
      password => 'wordpresssecuritysucks',
      shell    => '/bin/bash',
      ensure   => present
    }
	class {'apache': 
    mpm_module => 'prefork',
    default_vhost => false,
  }
  class {'::apache::mod::php': }
	include ::php
    class { '::mysql::server':
	}
    mysql::db { 'wordpress':
        user     => 'wp',
        password => 'w0rdpr3ss',
        host     => 'localhost',
        grant    => ['ALL'],
    }
	include wordpress
    file { 'hostname':
        path    => '/etc/sudoers.d/hostname',
        source  => "puppet:///modules/sudo/hostname",
        require => User['blogger'],
        ensure  => file
    }
  apache::vhost { 'techvm.wp':
    port          => '80',
    docroot       => '/home/blogger',
    docroot_owner => 'www-data',
    docroot_group => 'www-data',
  } 
}
