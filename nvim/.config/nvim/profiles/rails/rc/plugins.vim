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
  nnoremap [unite]rda :<C-u>Denite rails:dashboard<CR>
endif

if dein#tap('neosnippet.vim')
  augroup MyAutoCmd
    autocmd BufEnter,BufRead,BufNew app/views/*          NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.view.snip
    autocmd BufEnter,BufRead,BufNew app/controllers/*.rb NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.controller.snip
    autocmd BufEnter,BufRead,BufNew app/models/*.rb      NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.model.snip
    autocmd BufEnter,BufRead,BufNew app/db/migrate/*     NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.migrate.snip
    autocmd BufEnter,BufRead,BufNew app/config/routes.rb NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.route.snip
    autocmd BufEnter,BufRead,BufNew spec/**/*.rb         NeoSnippetSource ~/.config/nvim/snippets/ruby.rails.rspec.snip
endif

if dein#tap('vim-rails')
  let g:rails_ctags_arguments = [
        \   '--languages=Ruby',
        \   '--exclude=doc',
        \   '--exclude=docs',
        \ ]

endif
