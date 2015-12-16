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
    class { 'sudo':
      purge               => false,
      config_file_replace => false,
    }
    class { 'sudo': }
        sudo::conf { 'blogger':
          source => 'puppet:///files/etc/sudoers.d/blogger',
        }
        sudo::conf { 'hostname':
          priority => 10,
          content  => "blogger ALL=(ALL) NOPASSWD: /etc/init.d/hostname",
        }
        sudo::conf { 'blogger':
          priority => 60,
          source   => 'puppet:///files/etc/sudoers.d/users/blogger',
    }    
}
