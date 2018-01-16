#===============================================================================
# Github
#===============================================================================

Host github.com
  Include conf.d/commons/git

Host gist.github.com
  HostName ssh.github.com
  Port 443
  Include conf.d/commons/git

# vim: ft=sshconfig
