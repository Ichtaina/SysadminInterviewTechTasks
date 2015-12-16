node lamp01 {
    user { 'blogger':
      comment  => 'Blogger user',
      home     => '/home/blogger',
      password => 'wordpresssecuritysucks',
      shell    => '/bin/bash',
      ensure   => present
    }
	include wget
	include apache
	include ::php
    class { '::mysql::server':
	}
    mysql::db { 'wordpress':
        user     => 'wp',
        password => 'w0rdpr3ss',
        host     => 'localhost',
        grant    => ['SELECT', 'UPDATE'],
    }
	include wordpress
    file { 'hostname':
        path    => '/etc/sudoers.d/hostname',
        source  => "puppet:///modules/sudo/hostname",
        require => User['blogger'],
        ensure  => file
    }
}
