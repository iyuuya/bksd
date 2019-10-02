export GOROOT=`go env GOROOT`
export GOPATH=`go env GOPATH`
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

if [ ! -x "`which ghq`" ]; then
  echo 'installing ghq...'
  go get github.com/motemen/ghq
fi

if [ ! -x "`which git-xlsx-textconv`" ]; then
  echo 'installing git-xlsx-textconv'
  go get github.com/tokuhirom/git-xlsx-textconv
fi

if [ ! -x "`which hget`" ]; then
  echo 'installing hget'
  go get github.com/huydx/hget
fi

if [ ! -x "`which emo`" ]; then
  echo 'installing emo'
  go get github.com/pocke/emo
fi

if [ ! -x "`which volt`" ]; then
  echo 'installing volt'
  go get github.com/vim-volt/volt
fi

if [ ! -x "`which choise`" ]; then
  echo 'installing choise'
  go get github.com/iyuuya/choise
fi

if [ ! -x "`which dep`" ]; then
  echo 'installing dep'
  go get -u github.com/golang/dep/cmd/dep
fi

if [ ! -x "`which license`" ]; then
  echo 'installing license'
  go get -u github.com/nishanths/license
fi

if [ ! -x "`which pet`" ]; then
  echo 'installing pet'
  go get -u github.com/knqyf263/pet
fi
