ssh-config
==========

Install
-------

### Clone and symlink

```
git clone https://github.com/iyuuya/ssh-config.git
cd ssh-config
ln -s `pwd`/.ssh $HOME/.ssh
ln -s `pwd`/bin/ssh-config $HOME/bin/ssh-config
export PATH=~/bin:$PATH
```

### Create ids directory

```
mkdir ~/.ssh/ids
```

### Set keys

Reanme id_rsa files to %u.%h.id_rsa, and put id_rsa files to ~/.ssh/ids

ex)

* iyuuya.github.com.id_rsa
* iyuuya.bitbucket.org.id_rsa

> Check .ssh/config.d/000_default

### Set config

Create .ssh/config file from .ssh/config.d/*

```
ssh-config
```

> Check bin/ssh-config

