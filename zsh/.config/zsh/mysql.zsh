function m57() {
  brew services stop mysql@5.6
  brew unlink mysql@5.6
  brew link mysql
  rm /usr/local/var/mysql
  ln -s /usr/local/var/mysql57 /usr/local/var/mysql
  brew services start mysql
}

function m56() {
  brew services stop mysql
  brew unlink mysql
  brew link mysql@5.6
  rm /usr/local/var/mysql
  ln -s /usr/local/var/mysql56 /usr/local/var/mysql
  brew services start mysql@5.6
}
