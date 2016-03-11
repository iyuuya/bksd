if type ghq > /dev/null 2>&1; then
  function ghq-list-relative() {
    local query
    if [ $# = 1 ]; then
      query=$1
    else
      query=''
    fi
    ghq list $query -p | sed -e "s/$(echo $HOME | sed -e 's/\//\\\//g')/~/g"
  }

  function ghq-update() {
    for dir in `ghq list -p`; do
      echo "updating... : $dir"
      cd $dir
      git pull
    done
  }
fi
