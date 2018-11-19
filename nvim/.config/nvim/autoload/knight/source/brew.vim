scriptencoding utf-8
let s:save_cpo = &cpoptions
set cpoptions&vim

let s:global_options = [
      \ '--cache',
      \ '--cellar',
      \ '--env',
      \ '--prefix',
      \ '--repository',
      \ '--version',
      \ ]
let s:sub_commands = [
      \ 'analytics',
      \ 'cask',
      \ 'cat',
      \ 'cleanup',
      \ 'command',
      \ 'commands',
      \ 'config',
      \ 'deps',
      \ 'desc',
      \ 'diy',
      \ 'doctor',
      \ 'fetch',
      \ 'gist-logs',
      \ 'help',
      \ 'home',
      \ 'info',
      \ 'install',
      \ 'leaves',
      \ 'link',
      \ 'list',
      \ 'log',
      \ 'migrate',
      \ 'missing',
      \ 'options',
      \ 'outdated',
      \ 'pin',
      \ 'postinstall',
      \ 'prune',
      \ 'readall',
      \ 'reinstall',
      \ 'search',
      \ 'sh',
      \ 'shellenv',
      \ 'style',
      \ 'switch',
      \ 'tap',
      \ 'tap-info',
      \ 'tap-pin',
      \ 'tap-unpin',
      \ 'uninstall',
      \ 'unlink',
      \ 'unpack',
      \ 'unpin',
      \ 'untap',
      \ 'update',
      \ 'update-report',
      \ 'update-reset',
      \ 'upgrade',
      \ 'uses',
      \ 'vendor-install',
      \ ]

function! knight#source#brew#run(...)
  echo a:000
endfunction

function! knight#source#brew#complete(args, cmdline, pos)
  return s:sub_commands
endfunction

let &cpoptions = s:save_cpo
unlet s:save_cpo
