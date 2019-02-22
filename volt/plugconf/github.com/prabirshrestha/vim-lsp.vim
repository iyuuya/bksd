" vim:et:sw=2:ts=2

function! s:on_load_pre()
  " Plugin configuration like the code written in vimrc.
  " This configuration is executed *before* a plugin is loaded.
endfunction

function! s:on_load_post()
  " Plugin configuration like the code written in vimrc.
  " This configuration is executed *after* a plugin is loaded.

  augroup vim-lsp-load-post-plugconf
    autocmd!

    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'php-language-server',
          \ 'cmd': {server_info->['php', expand('~/working/php-language-server/bin/php-language-server.php')]},
          \ 'whitelist': ['php'],
          \ })

    autocmd User lsp_setup call lsp#register_server({
          \ 'name': 'solargraph',
          \ 'cmd': {server_info->[&shell, &shellcmdflag, 'solargraph stdio']},
          \ 'initialization_options': {'diagnostics': 'true'},
          \ 'whitelist': ['ruby'],
          \ })

    if executable('gopls')
      au User lsp_setup call lsp#register_server({
            \ 'name': 'gopls',
            \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
            \ 'whitelist': ['go'],
            \ })
    endif
    if executable('go-langserver')
      au User lsp_setup call lsp#register_server({
            \ 'name': 'go-langserver',
            \ 'cmd': {server_info->['go-langserver', '-gocodecompletion']},
            \ 'whitelist': ['go'],
            \ })
    endif
    if executable('bingo')
      au User lsp_setup call lsp#register_server({
            \ 'name': 'bingo',
            \ 'cmd': {server_info->['bingo', '-mode', 'stdio']},
            \ 'whitelist': ['go'],
            \ })
    endif
    if executable('typescript-language-server')
      au User lsp_setup call lsp#register_server({
            \ 'name': 'javascript support using typescript-language-server',
            \ 'cmd': { server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri': { server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_directory(lsp#utils#get_buffer_path(), '.git/..'))},
            \ 'whitelist': ['javascript', 'javascript.jsx']
            \ })

      au User lsp_setup call lsp#register_server({
            \ 'name': 'javascript support using typescript-language-server',
            \ 'cmd': {server_info->[&shell, &shellcmdflag, 'typescript-language-server --stdio']},
            \ 'root_uri':{server_info->lsp#utils#path_to_uri(lsp#utils#find_nearest_parent_file_directory(lsp#utils#get_buffer_path(), 'package.json'))},
            \ 'whitelist': ['javascript', 'javascript.jsx'],
            \ })
    endif
  augroup END
endfunction

function! s:loaded_on()
  " This function determines when a plugin is loaded.
  "
  " Possible values are:
  " * 'start' (a plugin will be loaded at VimEnter event)
  " * 'filetype=<filetypes>' (a plugin will be loaded at FileType event)
  " * 'excmd=<excmds>' (a plugin will be loaded at CmdUndefined event)
  " <filetypes> and <excmds> can be multiple values separated by comma.
  "
  " This function must contain 'return "<str>"' code.
  " (the argument of :return must be string literal)

  return 'start'
endfunction

function! s:depends()
  " Dependencies of this plugin.
  " The specified dependencies are loaded after this plugin is loaded.
  "
  " This function must contain 'return [<repos>, ...]' code.
  " (the argument of :return must be list literal, and the elements are string)
  " e.g. return ['github.com/tyru/open-browser.vim']

  return ['github.com/prabirshrestha/async.vim']
endfunction
