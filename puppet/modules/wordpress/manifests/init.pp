# = Class: wordpress

class wordpress {
  include dependencies
  include install
  include config
  Class['wordpress::dependencies'] -> Class['wordpress::install'] -> Class['wordpress::config']
}
