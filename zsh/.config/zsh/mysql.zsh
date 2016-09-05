function m57() {
  mysql.server stop
  brew unlink mysql56
  brew link mysql
  rm /usr/local/var/mysql
  ln -s /usr/local/var/mysql57 /usr/local/var/mysql
  mysql.server start
}

function m56() {
  mysql.server stop
  brew unlink mysql
  brew link mysql56
  rm /usr/local/var/mysql
  ln -s /usr/local/var/mysql56 /usr/local/var/mysql
  mysql.server start
}
