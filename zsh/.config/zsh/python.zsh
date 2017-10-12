function set_pyenv_flags {
  export CFLAGS="-I$(brew --prefix openssl)/include"
  export LDFLAGS="-L$(brew --prefix openssl)/lib -L$(brew --prefix sqlite3)/lib"
  export CPPFLAGS="-I$(brew --prefix sqlite3)/include"
}
