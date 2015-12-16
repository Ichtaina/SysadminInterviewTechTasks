# = Class: wordpress::dependencies

class wordpress::dependencies {
  case $::operatingsystem {
    ubuntu: {
      require wordpress::dependencies::ubuntu
    }
    default: { notify("Only ubuntu it's supported right now") }
  }
}
