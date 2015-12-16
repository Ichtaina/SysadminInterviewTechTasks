# = Class: wordpress::config

class wordpress::config inherits wordpress::params {

    $db_name = 'wordpress'
    $db_user = 'wp'
    $db_user_password = 'w0rdpr3ss'
    $db_host = 'localhost'

    
    $db_user_host = "${db_user}@${db_host}"

    $db_user_host_db = "${db_user}@${db_host}/${db_name}.*"
}
