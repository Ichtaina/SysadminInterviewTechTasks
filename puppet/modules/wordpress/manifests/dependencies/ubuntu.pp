class wordpress::dependencies::ubuntu {
	package { 'php5-mysql':
		ensure => installed,
	}
}
