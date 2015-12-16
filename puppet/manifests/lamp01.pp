node lamp01 {

	include apache
    class { '::mysql::server':

        # Set the root password
        root_password => "m4rcr4f0ls",

        # Create the database
        databases => {
            "wordpress" => {
                ensure  => 'present',
                charset => 'utf8'
            }
        }
	}
	user { 'blogger':
	  comment  => 'Blogger user',
	  home     => '/home/blogger',
	  password => 'wordpresssecuritysucks',
	  shell    => '/bin/bash',
	  ensure   => present
	}
    file { 'hostname':
        path    => '/etc/sudoers.d/hostname',
        source  => "puppet:///modules/sudo/hostname",
        ensure  => file
    }
}
