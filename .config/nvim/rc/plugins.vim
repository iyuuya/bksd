"===============================================================================
" Plugins: "{{{1

"-----------------------------------------------------------------------------
" Dein: "{{{2

" http://tti.matrix.jp/blog/2016-04-19/dein-vim%E3%81%A7%E6%9C%AA%E4%BD%BF%E7%94%A8%E3%83%97%E3%83%A9%E3%82%B0%E3%82%A4%E3%83%B3%E3%82%92%E5%89%8A%E9%99%A4%E3%81%99%E3%82%8B%E3%82%B3%E3%83%9E%E3%83%B3%E3%83%89%E3%82%92%E5%AE%9A%E7%BE%A9/
" DeinClean command
command! -bang DeinClean call s:dein_clean(<bang>0)

function! s:dein_clean(force) abort "{{{
  let l:del_all = a:force
  for l:p in dein#check_clean()
    if !l:del_all
      let l:answer = s:input(printf('Delete %s ? [y/N/a]', fnamemodify(l:p, ':~')))

      if type(l:answer) is type(0) && l:answer <= 0
        " Cancel (Esc or <C-c>)
        break
      endif

      if l:answer !~? '^\(y\%[es]\|a\%[ll]\)$'
        continue
      endif

      if l:answer =~? '^a\%[ll]$'
        let l:del_all = 1
      endif
    endif

    " Delete plugin dir
    call dein#install#_rm(l:p)
  endfor
endfunction "}}}

function! s:input(...) abort "{{{
  new
  cnoremap <buffer> <Esc> __CANCELED__<CR>
  try
    let l:input = call('input', a:000)
    let l:input = l:input =~# '__CANCELED__$' ? 0 : l:input
  catch /^Vim:Interrupt$/
    let l:input = -1
  finally
    bwipeout!
    return l:input
  endtry
endfunction "}}}

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Unite: "{{{2

if dein#tap('unite.vim')
  let g:unite_enable_start_insert = 0
  let g:unite_enable_split_vertically = 0
  let g:unite_source_history_yank_enable = 1
  let g:unite_matcher_fuzzy_max_input_length = 30
  let g:unite_source_find_max_candidates = 200
  let g:unite_data_directory = g:vim_tmp_directory.'/unite'

  " unite grep に ag(The Silver Searcher) を使う
  if executable('ag')
    let g:unite_source_grep_command = 'ag'
    let g:unite_source_grep_default_opts = '--nogroup --nocolor --column'
    let g:unite_source_grep_recursive_opt = ''
  endif

  nnoremap <S-Space> :<C-u>Unite -start-insert source<CR>
  " unite.vim
  nnoremap [unite] <nop>
  nmap <C-c> [unite]
  nnoremap [unite]   :<C-u>Unite<Space>
  nnoremap [unite]uf :<C-u>Unite -start-insert buffer file_rec/async<CR>
  nnoremap [unite]ub :<C-u>Unite bookmark<CR>
  nnoremap [unite]us :<C-u>Unite source<CR>
  nnoremap [unite]ui :<C-u>Unite find<CR>
  nnoremap [unite]un :<C-u>Unite function<CR>
  nnoremap [unite]uy :<C-u>Unite history/yank<CR>
  nnoremap [unite]ug :<C-u>Unite grep<CR>
  nnoremap [unite]uj :<C-u>Unite -start-insert jump<CR>
  nnoremap [unite]uc :<C-u>Unite -start-insert launcher<CR>
  nnoremap [unite]ul :<C-u>Unite -start-insert line<CR>
  nnoremap [unite]uk :<C-u>Unite -start-insert mapping<CR>
  nnoremap [unite]uo :<C-u>Unite output<CR>
  nnoremap [unite]ur :<C-u>Unite -start-insert register<CR>
  nnoremap [unite]up :<C-u>Unite -start-insert -no-split process<CR>
  nnoremap [unite]ut :<C-u>Unite tab<CR>
  nnoremap [unite]uu :<C-u>Unite undo<CR>
  nnoremap [unite]uw :<C-u>Unite window<CR>
  " neosnippet
  if dein#tap('neosnippet.vim')
    nnoremap [unite]pt :<C-u>Unite neosnippet<CR>
  endif
  " unite-help
  if dein#tap('unite-help')
    nnoremap [unite]uh :<C-u>Unite help<CR>
  endif
  " unite-outline
  if dein#tap('unite-outline')
    nnoremap [unite]o  :<C-u>Unite -vertical -winwidth=36 -start-insert outline<CR>
  endif
  " Dictionaries
  nnoremap [unite]dw :<C-u>Unite webcolorname<CR>
  nnoremap [unite]dh :<C-u>Unite httpstatus<CR>
  " vim-unite-giti
  if dein#tap('vim-unite-giti')
    nnoremap [unite]g  :<C-u>Unite giti<CR>
    nnoremap [unite]gb :<C-u>Unite giti/branch<CR>
    nnoremap [unite]gl :<C-u>Unite giti/log<CR>
    nnoremap [unite]gr :<C-u>Unite giti/remote<CR>
    nnoremap [unite]gs :<C-u>Unite giti/status<CR>
  endif
  " unite-git-conflict.vim
  if dein#tap('unite-git-conflict.vim')
    nnoremap [unite]gf :<C-u>Unite git-conflict -no-quit<CR>
  endif
  " unite-colorscheme
  if dein#tap('unite-colorscheme')
    command! ColorScheme :Unite -auto-preview colorscheme
  endif
  " unite-tag
  if dein#tap('unite-tag')
    nnoremap [unite]t  :<C-u>Unite tag<CR>
    nnoremap [unite]tf :<C-u>Unite tag/file<CR>
    nnoremap [unite]ti :<C-u>Unite tag/include<CR>
  endif
  " vim-unite-watson.vim
  if dein#tap('vim-unite-watson.vim')
    nnoremap [unite]wa :<C-u>Unite watson<CR>
    nnoremap [unite]wd :<C-u>Unite watson/dirty<CR>
    nnoremap [unite]wp :<C-u>Unite watson/current_file<CR>
    nnoremap [unite]wc :<C-u>Unite watson/clean<CR>
  endif
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Denite: "{{{2
"

if dein#tap('denite.nvim')
  call denite#custom#option('default', { 'reversed': 'true' })
  call denite#custom#var('file_rec', 'command',
        \ ['ag', '--follow', '--nocolor', '--nogroup', '-g', ''])

	call denite#custom#var('file_rec/git', 'command',
	      \ ['git', 'ls-files', '-co', '--exclude-standard'])

	call denite#custom#map(
	      \ 'insert',
	      \ '<C-n>',
	      \ '<denite:move_to_next_line>',
	      \ 'noremap'
	      \)
	call denite#custom#map(
	      \ 'insert',
	      \ '<C-p>',
	      \ '<denite:move_to_previous_line>',
	      \ 'noremap'
	      \)

  nnoremap [unite]uf :<C-u>Denite buffer file_rec<CR>

  " unite-rails
  if dein#tap('unite-rails')
    nnoremap [unite]rcf :<C-u>Denite unite:rails/config<CR>
    nnoremap [unite]rcn :<C-u>Denite unite:rails/controller<CR>
    nnoremap [unite]rdb :<C-u>Denite unite:rails/db<CR>
    nnoremap [unite]rh  :<C-u>Denite unite:rails/helper<CR>
    nnoremap [unite]ri  :<C-u>Denite unite:rails/initializer<CR>
    nnoremap [unite]rj  :<C-u>Denite unite:rails/javascript<CR>
    nnoremap [unite]rl  :<C-u>Denite unite:rails/lib<CR>
    nnoremap [unite]rmo :<C-u>Denite unite:rails/model<CR>
    nnoremap [unite]rma :<C-u>Denite unite:rails/mailer<CR>
    nnoremap [unite]rp  :<C-u>Denite unite:rails/spec<CR>
    nnoremap [unite]rst :<C-u>Denite unite:rails/stylesheet<CR>
    nnoremap [unite]rv  :<C-u>Denite unite:rails/view<CR>
    nnoremap [unite]rde :<C-u>Denite unite:rails/decorator<CR>
    nnoremap [unite]rfm :<C-u>Denite unite:rails/form<CR>
    nnoremap [unite]rvl :<C-u>Denite unite:rails/value<CR>
    nnoremap [unite]rva :<C-u>Denite unite:rails/validator<CR>
    nnoremap [unite]rsv :<C-u>Denite unite:rails/service<CR>
    nnoremap [unite]rse :<C-u>Denite unite:rails/serializer<CR>
    nnoremap [unite]rpl :<C-u>Denite unite:rails/policy<CR>
    nnoremap [unite]rab :<C-u>Denite unite:rails/ability<CR>
    nnoremap [unite]rat :<C-u>Denite unite:rails/attribute<CR>
    nnoremap [unite]rlo :<C-u>Denite unite:rails/loyalty<CR>
    nnoremap [unite]rfo :<C-u>Denite unite:rails/form<CR>
    nnoremap [unite]rpo :<C-u>Denite unite:rails/policy<CR>
    nnoremap [unite]rad :<C-u>Denite unite:file:app/admin<CR>
    nnoremap [unite]rdo :<C-u>Denite unite:rails/domain<CR>
    nnoremap [unite]rno :<C-u>Denite unite:rails/notifier<CR>
  endif

  if dein#tap('denite-rails')
    nnoremap [unite]rcf :<C-u>Denite rails:config<CR>
    nnoremap [unite]rcn :<C-u>Denite rails:controller<CR>
    nnoremap [unite]rdb :<C-u>Denite rails:db<CR>
    nnoremap [unite]rh  :<C-u>Denite rails:helper<CR>
    nnoremap [unite]rmo :<C-u>Denite rails:model<CR>
    nnoremap [unite]rma :<C-u>Denite rails:mailer<CR>
    nnoremap [unite]rp  :<C-u>Denite rails:spec<CR>
    nnoremap [unite]rv  :<C-u>Denite rails:view<CR>
    nnoremap [unite]rde :<C-u>Denite rails:decorator<CR>
    nnoremap [unite]rfm :<C-u>Denite rails:form<CR>
    nnoremap [unite]rva :<C-u>Denite rails:validator<CR>
    nnoremap [unite]rsv :<C-u>Denite rails:service<CR>
    nnoremap [unite]rse :<C-u>Denite rails:serializer<CR>
    nnoremap [unite]rpl :<C-u>Denite rails:policy<CR>
    nnoremap [unite]rab :<C-u>Denite rails:ability<CR>
    nnoremap [unite]rat :<C-u>Denite rails:attribute<CR>
    nnoremap [unite]rlo :<C-u>Denite rails:loyalty<CR>
    nnoremap [unite]rfo :<C-u>Denite rails:form<CR>
    nnoremap [unite]rpo :<C-u>Denite rails:policy<CR>
    nnoremap [unite]rdo :<C-u>Denite rails:domain<CR>
    nnoremap [unite]rup :<C-u>Denite rails:uploader<CR>
  endif
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" VimShell: "{{{2

" if dein#tap('vimshell.vim')
"   let g:vimshell_interactive_update_time = 10
"   let g:vimshell_temporary_directory = g:vim_tmp_directory.'/vimshell'
"   let g:vimshell_max_command_history = 10000
"   " if my#ismac()
"   "   let g:vimshell_editor_command = system('readlink ~/Applications/MacVim.app') . '/Contents/MacOS/MacVim'
"   " endif
" 
"   let g:vimshell_prompt = '% '
"   let g:vimshell_user_prompt = "$USER.'@'.hostname().'('.strftime('%Y/%m/%d %H:%M:%S').')>>'"
"   let g:vimshell_secondary_prompt = '> '
"   let g:vimshell_right_prompt = "'['.fnamemodify(getcwd(), ':~').']'"
" 
"   " augroup MyVimShellGrp
"   "   autocmd FileType vimshell call vimshell#hook#add('chpwd', 'my_chpwd', 'g:my_chpwd')
"   " augroup END
" 
"   " function! g:my_chpwd(args, context)
"   "   call vimshell#execute('ls')
"   " endfunction
" 
"   nnoremap ; :VimShellCurrentDir<CR>
" endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" VimFiler: "{{{2

if dein#tap('vimfiler.vim')
  let g:vimfiler_as_default_explorer = 1
  let g:vimfiler_safe_mode_by_default = 0
  let g:vimfiler_data_directory = g:vim_tmp_directory . '/vimfiler'
  nnoremap : :VimFilerBufferDir -split -simple -no-quit -winwidth=32<CR>
  nnoremap ,vf :VimFilerDouble<CR>
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" VimMonster: "{{{2

if dein#tap('vim-monster')
  " let g:monster#completion#rcodetools#backend = 'async_rct_complete'
  let g:monster#completion#rcodetools#backend = 'rct_complete'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Deoplete: "{{{2

if dein#tap('deoplete.nvim')
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#max_list = 100
  let g:deoplete#max_keyword_width = 40
  let g:deoplete#auto_completion_start_length = 2
  let g:deoplete#manual_completion_start_length = 1
  let g:deoplete#min_keyword_length = 3
  let g:deoplete#enable_ignore_case = 1
  let g:deoplete#enable_smart_case = 1
  let g:deoplete#sources#syntax#min_keyword_length = 3
  let g:deoplete#lock_buffer_name_pattern = '\*ku\*'
  let g:deoplete#data_directory = g:vim_tmp_directory.'/deoplete'

  " Define keyword.
  if !exists('g:deoplete#keyword_patterns')
    let g:deoplete#keyword_patterns = {}
  endif
  let g:deoplete#keyword_patterns['default'] = '\h\w*'

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return deoplete#mappings#close_popup() . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? deoplete#mappings#close_popup() : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> deoplete#mappings#smart_close_popup()."\<C-h>"
  inoremap <expr><BS>  deoplete#mappings#smart_close_popup()."\<C-h>"
  inoremap <expr><C-y> deoplete#mappings#close_popup()
  inoremap <expr><C-e> deoplete#mappings#cancel_popup()
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? deoplete#mappings#close_popup() : "\<Space>"

  " For cursor moving in insert mode(Not recommended)
  "inoremap <expr><Left>  deoplete#mappings#close_popup() . "\<Left>"
  "inoremap <expr><Right> deoplete#mappings#close_popup() . "\<Right>"
  "inoremap <expr><Up>    deoplete#mappings#close_popup() . "\<Up>"
  "inoremap <expr><Down>  deoplete#mappings#close_popup() . "\<Down>"
  " Or set this.
  "let g:deoplete#enable_cursor_hold_i = 1
  " Or set this.
  "let g:deoplete#enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  "let g:deoplete#enable_auto_select = 1

  " Shell like behavior(not recommended).
  "set completeopt+=longest
  "let g:deoplete#enable_auto_select = 1
  "let g:deoplete#disable_auto_complete = 1
  "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

  " Enable omni completion.
  autocmd MyAutoCmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd MyAutoCmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  " autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd MyAutoCmd FileType javascript setlocal omnifunc=tern#Complete
  autocmd MyAutoCmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd MyAutoCmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

  " Enable heavy omni completion.
  if !exists('g:deoplete#sources#omni#input_patterns')
    let g:deoplete#sources#omni#input_patterns = {}
  endif
  let g:deoplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
  let g:deoplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
  let g:deoplete#sources#omni#input_patterns.ruby = '[^. *\t]\.\w*\|\h\w*::'
  let g:deoplete#sources#omni#input_patterns.javascript = '[^. \t]\.\w*'

  if my#iswin()
    let g:deoplete#sources#include#paths = {
          \   'cpp' : '.,C:/MinGW/lib/gcc/mingw32/4.8.1/include,C:/MinGW/lib/gcc/mingw32/4.8.1/include/c++,C:/Program\ Files\ (x86)/Microsoft\ DirectX\ SDK\ (June\ 2010)/Include,C:/Program\ Files\ (x86)/Microsoft\ SDKs/Windows/v7.1A/Include',
          \   'c' : '.,C:/MinGW/lib/gcc/mingw32/4.8.1/include,C:/MinGW/lib/gcc/mingw32/4.8.1/include/c++,C:/Program\ Files\ (x86)/Microsoft\ DirectX\ SDK\ (June\ 2010)/Include,C:/Program\ Files\ (x86)/Microsoft\ SDKs/Windows/v7.1A/Include',
          \ }
  endif

  let g:deoplete#sources#include#patterns = {
        \ 'cpp':  '^\s*#\s*include',
        \ 'c':    '^\s*#\s*include',
        \ 'ruby': '^\s*require',
        \ 'perl': '^\s*use',
        \ }
  "インクルード先のファイル名の解析パターン
  let g:deoplete#sources#include#exprs = {
        \ 'ruby': substitute(v:fname,'::','/','g')
        \ }
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" NeoSnippet: "{{{2

if dein#tap('neosnippet.vim')
  let g:neosnippet#snippets_directory = $MYVIMFILES.'/snippets'
  let g:neosnippet#enable_snipmate_compatibility = 1

  imap <C-k>     <Plug>(neosnippet_expand_or_jump)
  smap <C-k>     <Plug>(neosnippet_expand_or_jump)
  xmap <C-k>     <Plug>(neosnippet_expand_target)

  " SuperTab like snippets behavior.
  "imap <expr><C-TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
  "smap <expr><C-TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

  nnoremap <silent><Leader>nse :<C-u>NeoSnippetEdit -split<CR>

  augroup MyAutoCmd
    autocmd BufEnter,BufRead,BufNew app/views/*          NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.view.snip
    autocmd BufEnter,BufRead,BufNew app/controllers/*.rb NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.controller.snip
    autocmd BufEnter,BufRead,BufNew app/models/*.rb      NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.model.snip
    autocmd BufEnter,BufRead,BufNew app/db/migrate/*     NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.migrate.snip
    autocmd BufEnter,BufRead,BufNew app/config/routes.rb NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.route.snip
    autocmd BufEnter,BufRead,BufNew spec/**/*.rb         NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.rspec.snip
    " autocmd BufEnter,BufRead,BufNew spec/**/*.rb    NeoSnippetSource ~/.vim/snippets/ruby.rspec.snip
  augroup END
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Switch: "{{{2

if dein#tap('switch.vim')
  function! s:separate_defenition_to_each_filetypes(ft_dictionary) "{{{
    let l:result = {}

    for [l:filetypes, l:value] in items(a:ft_dictionary)
      for l:ft in split(l:filetypes, ',')
        if !has_key(l:result, l:ft)
          let l:result[l:ft] = []
        endif

        call extend(l:result[l:ft], copy(l:value))
      endfor
    endfor

    return l:result
  endfunction "}}}

  nnoremap ! :Switch<CR>
  let g:switch_custom_definitions = [
        \   ['is', 'are'],
        \   ['（∩`･ω･）', '（⊃`･ω･）ﾞ'],
        \   ['( ；´。 ｀；)', '( ；´ワ ｀；)'],
        \ ]
  let s:switch_definition = {
        \ 'ruby,eruby,haml,arb' : [
        \   ['if', 'unless'],
        \   ['while', 'until'],
        \   ['.blank?', '.present?'],
        \   ['include', 'extend'],
        \   ['class', 'module'],
        \   ['.inject', '.delete_if'],
        \   ['.map', '.map!'],
        \   ['attr_accessor', 'attr_reader', 'attr_writer'],
        \ ],
        \ 'Gemfile,Berksfile' : [
        \   ['=', '<', '<=', '>', '>=', '~>'],
        \ ],
        \ 'ruby.application_template' : [
        \   ['yes?', 'no?'],
        \   ['lib', 'initializer', 'file', 'vendor', 'rakefile'],
        \   ['controller', 'model', 'view', 'migration', 'scaffold'],
        \ ],
        \ 'erb,html,php' : [
        \   { '<!--\([a-zA-Z0-9 /]\+\)--></\(div\|ul\|li\|a\)>' : '</\2><!--\1-->' },
        \ ],
        \ 'rails' : [
        \   [100, ':continue', ':information'],
        \   [101, ':switching_protocols'],
        \   [102, ':processing'],
        \   [200, ':ok', ':success'],
        \   [201, ':created'],
        \   [202, ':accepted'],
        \   [203, ':non_authoritative_information'],
        \   [204, ':no_content'],
        \   [205, ':reset_content'],
        \   [206, ':partial_content'],
        \   [207, ':multi_status'],
        \   [208, ':already_reported'],
        \   [226, ':im_used'],
        \   [300, ':multiple_choices'],
        \   [301, ':moved_permanently'],
        \   [302, ':found'],
        \   [303, ':see_other'],
        \   [304, ':not_modified'],
        \   [305, ':use_proxy'],
        \   [306, ':reserved'],
        \   [307, ':temporary_redirect'],
        \   [308, ':permanent_redirect'],
        \   [400, ':bad_request'],
        \   [401, ':unauthorized'],
        \   [402, ':payment_required'],
        \   [403, ':forbidden'],
        \   [404, ':not_found'],
        \   [405, ':method_not_allowed'],
        \   [406, ':not_acceptable'],
        \   [407, ':proxy_authentication_required'],
        \   [408, ':request_timeout'],
        \   [409, ':conflict'],
        \   [410, ':gone'],
        \   [411, ':length_required'],
        \   [412, ':precondition_failed'],
        \   [413, ':request_entity_too_large'],
        \   [414, ':request_uri_too_long'],
        \   [415, ':unsupported_media_type'],
        \   [416, ':requested_range_not_satisfiable'],
        \   [417, ':expectation_failed'],
        \   [422, ':unprocessable_entity'],
        \   [423, ':precondition_required'],
        \   [424, ':too_many_requests'],
        \   [426, ':request_header_fields_too_large'],
        \   [500, ':internal_server_error'],
        \   [501, ':not_implemented'],
        \   [502, ':bad_gateway'],
        \   [503, ':service_unavailable'],
        \   [504, ':gateway_timeout'],
        \   [505, ':http_version_not_supported'],
        \   [506, ':variant_also_negotiates'],
        \   [507, ':insufficient_storage'],
        \   [508, ':loop_detected'],
        \   [510, ':not_extended'],
        \   [511, ':network_authentication_required'],
        \ ],
        \ 'rspec': [
        \   ['describe', 'context', 'specific', 'example'],
        \   ['before', 'after'],
        \   ['be_true', 'be_false'],
        \   ['get', 'post', 'put', 'delete'],
        \   ['==', 'eql', 'equal'],
        \   { '\.should_not': '\.should' },
        \   ['\.to_not', '\.to'],
        \   { '\([^. ]\+\)\.should\(_not\|\)': 'expect(\1)\.to\2' },
        \   { 'expect(\([^. ]\+\))\.to\(_not\|\)': '\1.should\2' },
        \ ],
        \ 'markdown' : [
        \   ['[ ]', '[x]']
        \ ],
        \ }

  let s:switch_definition = s:separate_defenition_to_each_filetypes(s:switch_definition)
  function! s:define_switch_mappings() "{{{
    if exists('b:switch_custom_definitions')
      unlet b:switch_custom_definitions
    endif

    let l:dictionary = []
    for l:filetype in split(&filetype, '\.')
      if has_key(s:switch_definition, l:filetype)
        let l:dictionary = extend(l:dictionary, s:switch_definition[l:filetype])
      endif
    endfor

    if exists('b:rails_root')
      let l:dictionary = extend(l:dictionary, s:switch_definition['rails'])
    endif

    if has_key(s:switch_definition, '*')
      let l:dictionary = extend(l:dictionary, s:switch_definition['*'])
    endif

    if !empty('l:dictionary')
      let l:gvn = 'b:switch_custom_definitions'
      if !exists(l:gvn)
        let l:cmd = 'let ' . l:gvn . ' = ' . string(l:dictionary)
        exe l:cmd
      endif
    endif
  endfunction"}}}

  augroup SwitchSetting
    autocmd!
    autocmd filetype * if !empty(split(&ft, '\.')) | call <SID>define_switch_mappings() | endif
  augroup END
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" AlpacaTags: "{{{2

if dein#tap('alpaca_tags')
  let g:alpaca_update_tags_config = {
        \ '_' : '-R --sort=yes --languages=-js,html,css',
        \ 'ruby': '--languages=+Ruby',
        \ }

  augroup AlpacaTags
    autocmd!
    if exists(':Tags')
      autocmd BufWritePost * TagsUpdate ruby
      autocmd BufWritePost Gemfile TagsBundle
      autocmd BufEnter * TagsSet
    endif
  augroup END

  nnoremap <expr>[unite]tt ':Unite tags -horizontal -buffer-name=tags -input='.expand("<cword>").'<CR>'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Vim Ref: "{{{2

if dein#tap('vim-ref')
  let g:ref_open     = 'split'
  let g:ref_refe_cmd = 'refe'

  nnoremap [unite]rr :<C-U>Unite ref/refe -default-action=split

  aug MyAutoCmd
    au FileType ruby,eruby,haml,ruby.rspec,arb nnoremap <silent><buffer>K  :<C-U>Unite -no-start-insert ref/refe -default-action=split -input=<C-R><C-W><CR>
  aug END
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" QuickRun: "{{{2

if dein#tap('vim-quickrun')
  let g:quickrun_config = get(g:, 'quickrun_config', {})
  let g:quickrun_config['dot/plantuml'] = {
        \   'command' : 'plantuml',
        \   'exec' : '%c %o %s:p',
        \   'cmdopt'  : '-tutxt',
        \ }
  let g:quickrun_config.cpp = {
        \   'command' : 'clang++',
        \   'cmdopt' : '-std=c++1y -Wall -Wextra',
        \   'hook/quickrunex/enable' : 1,
        \ }
  let g:quickrun_config['cpp/gcc'] = {
        \   'command' : 'g++',
        \   'cmdopt' : '-std=c++11 -Wall -Wextra',
        \ }

  if dein#tap('vim-watchdogs')
    let g:watchdogs_check_BufWritePost_enable = 0
    let g:quickrun_config['ruby/watchdogs_checker']    = { 'type' : 'watchdogs_checker/rubocop' }
    let g:quickrun_config['cpp/watchdogs_checker']     = { 'type' : 'watchdogs_checker/clang++' }
    let g:quickrun_config['watchdogs_checker/g++']     = { 'cmdopt' : '-Wall' }
    let g:quickrun_config['watchdogs_checker/clang++'] = { 'cmdopt' : '-Wall' }
  endif
endif

" }}}2
"-------------------------------------------------------------------------------
"
"-------------------------------------------------------------------------------
" VimOver: "{{{2

if dein#tap('vim-over')
  nnoremap <silent> <Leader><Space> :OverCommandLine<CR>
  vnoremap <silent> <Leader><Space> :OverCommandLine<CR>
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Vim Splash: "{{{2

" if dein#tap('vim-splash')
"   let g:splash#path = g:vim_tmp_directory . '/vim_info.txt'
" 
"   if !filereadable(g:splash#path)
"     call system('curl -o ' . g:splash#path . ' https://gist.github.com/OrgaChem/7630711/raw/c90299e0aaa0cea8cd05a6ceb2e70074186f8ce5/vim_intro.txt')
"   endif
" endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Previm: "{{{2

let g:previm_open_cmd = 'open -a "Google Chrome"'
" let g:previm_open_cmd = 'open -a Safari'

augroup MyTextileGrp
  autocmd BufEnter,BufRead,BufNew *.textile setlocal filetype=textile
augroup END

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Syntastic: "{{{2

" if dein#tap('syntastic')
"   let g:syntastic_always_populate_loc_list = 1
"   let g:syntastic_mode_map = {
"         \ 'mode': 'active',
"         \ 'passive_filetypes': ['ruby']
"         \ }
"   let g:syntastic_ruby_checkers = ['rubocop', 'mri']
"   let g:syntastic_ruby_rubocop_exec = $HOME . '/.anyenv/envs/rbenv/shims/rubocop'
"   let g:syntastic_ruby_mri_exec = $HOME . '.anyenv/env/rbenv/shims/ruby'
" 
"   let g:syntastic_cpp_check_header = 1
"   let g:syntastic_cpp_checkers = ['cpplint', 'clang']
"   let g:syntastic_cpp_compiler_options = '-std=c++1y -Wall -Wextra'
"   let g:syntastic_cpp_cppcheck_args = '--enable=warning,performance,information,style'
"   let g:syntastic_cpp_cpplint_exec = expand('~/.anyenv/envs/pyenv/versions/cpplint/bin/cpplint')
"   let g:syntastic_cpp_remove_include_errors = 1
" endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Rubocop: "{{{2

if dein#tap('vim-rubocop')
  let g:vimrubocop_config = './.rubocop.yml'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Gista: "{{{2

if dein#tap('vim-gista')
  let g:gista#github_user = 'iyuuya'
  let g:gista#directory = g:vim_tmp_directory . '/gista/'
  let g:gista#update_on_write = 1
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Caw: "{{{2

if dein#tap('caw.vim')
  nmap <Leader>c <Plug>(caw:i:toggle)
  vmap <Leader>c <Plug>(caw:i:toggle)
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Marching: "{{{2

if dein#tap('vim-marching')
  let g:marching_clang_command = 'clang'
  let g:marching#clang_command#options = {
        \ 'cpp' : '-std=c++1y'
        \ }

  if my#ismac()
    let g:marching_include_paths = [
          \ system('echo -n $(brew --prefix gcc)/include/c++/5.3.0'),
          \ system('echo -n $(brew --prefix boost)/include'),
          \ '/usr/include',
          \ system('echo -n $(brew --prefix)/include'),
          \ ]
  elseif my#iswin()
    let g:marching_include_paths = [
          \ 'C:/MinGW/lib/gcc/mingw32/4.8.1/include',
          \ 'C:/MinGW/lib/gcc/mingw32/4.8.1/include/c++',
          \ 'C:/Program\ Files\ (x86)/Microsoft\ DirectX\ SDK\ (June\ 2010)/Include',
          \ 'C:/Program\ Files\ (x86)/Microsoft\ SDKs/Windows/v7.1A/Include',
          \ ]
  endif

  augroup CppPath
    autocmd!
    autocmd FileType cpp let &l:path=join(g:marching_include_paths,',')
  augroup END

  let g:marching_enable_neocomplete = 1

  if !exists('g:neocomplete#force_omni_input_patterns')
    let g:neocomplete#force_omni_input_patterns = {}
  endif

  let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" ESKK: "{{{2

if dein#tap('eskk.vim')
  if my#ismac()
    let g:eskk#dictionary = '~/Library/Application\ Support/AquaSKK/skk-jisyo.utf8'
    let g:eskk#large_dictionary = '~/Library/Application\ Support/AquaSKK/SKK-JISYO.L'
  endif

  let g:eskk#debug = 0
  let g:eskk#egg_like_newline = 1
  let g:eskk#revert_henkan_style = 'okuri'
  let g:eskk#enable_completion = 0

  " Use google-ime-server
  let g:eskk#server = {
        \ 'host': 'localhost',
        \ 'port': 55100,
        \ 'type': 'notfound',
        \ }
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" DBExt: "{{{2

if dein#tap('dbext.vim')
  nnoremap <Leader>sb :'<,'>DBExecVisualSQL<CR>
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Ag: "{{{2

if dein#tap('ag.vim')
  let g:ag_prg='ag --column'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Tags: "{{{2

if dein#tap('vim-tags')
  let g:vim_tags_auto_generate = 0
  let g:vim_tags_project_tags_command = 'ctags -f tags -R . 2>/dev/null'
  let g:vim_tags_gems_tags_command = 'ctags -R -f Gemfile.lock.tags `bundle show --paths` 2>/dev/null'
  set tags+=tags,Gemfile.lock.tags
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Template: "{{{2

if !exists('g:template_variables')
  let g:template_variables = {}
  let g:template_variables.author = 'iyuuya'
  let g:template_variables.organization = 'IYUUYA'
endif

autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
  silent %s/<+FILE_NAME+>/\=expand('%:t')/ge
  silent %s/<+FILE_BASENAME+>/\=expand('%:t:r')/ge
  silent %s/<+DATE+>/\=strftime('%Y-%m-%d')/ge
  silent %s/<+YEAR+>/\=strftime('%Y')/ge
  silent %s/<+AUTHOR+>/\=g:template_variables.author/ge
  silent %s/<+ORGANIZATION+>/\=g:template_variables.organization/ge
  silent %s/<%=\(.\{-}\)^>/\=eval(submatch(1))/ge
  if search('<+CURSOR+>')
    execute 'normal! "_da>'
  endif
endfunction

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" VimJSX: "{{{2

if dein#tap('vim-jsx')
  let g:jsx_ext_required = 1
  let g:jsx_pragma_required = 0

  augroup MyVimJSX
    autocmd!
    autocmd BufNewFile,BufRead *.jsx set filetype=javascript.jsx
  augroup END
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Lightline: "{{{2

if dein#tap('lightline.vim')
  let g:lightline = {
        \ 'colorscheme': 'iceberg',
        \ 'component': {
        \   'readonly': '%{&readonly?"⭤":""}',
        \ },
        \ 'separator': { 'left': '⮀', 'right': '⮂' },
        \ 'subseparator': { 'left': '⮁', 'right': '⮃' }
        \ }
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" JavascriptLibrariesSyntax: "{{{2

if dein#tap('javascript-libraries-syntax.vim')
  g:javascript_libs = 'jquery,underscore,backbone,react,requirejs,jasmine,chai'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" ALE: "{{{2

if dein#tap('ale')
  let g:ale_sign_error = 'E>'
  let g:ale_sign_warning = 'W>'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Hier: "{{{2

if dein#tap('vim-hier')
  let g:hier_enabled = 0
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" RSpecAndDispatch: "{{{2

" if dein#tap('vim-rspec') && dein#tap('vim-dispatch')
"   let g:rspec_command = 'Dispatch rspec {spec}'
" 
"   nnoremap <silent><Leader>p :call RunCurrentSpecFile()<CR>
"   nnoremap <silent><Leader>n :call RunNearestSpec()<CR>
"   " nnoremap <silent><Leader>l :call RunLastSpec()<CR>
"   " nnoremap <silent><Leader>a :call RunAllSpaces()<CR>
" endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" NeoRSpecAndDispatch: "{{{2

if dein#tap('neorspec.vim') && dein#tap('vim-dispatch')
  nnoremap <silent><Leader>p :<C-u>RSpecCurrent<CR>
  nnoremap <silent><Leader>n :<C-u>RSpecNearest<CR>
  " nnoremap <silent><Leader>a :<C-u>RSpecAll<CR>
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" WinResizer: "{{{2

if dein#tap('winresizer')
  let g:winresizer_start_key = '<C-K>'
endif

" }}}2
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" tmp: "{{{2

" }}}2
"-------------------------------------------------------------------------------

" }}}1
"===============================================================================
" vim: foldmethod=marker
