if !exists('g:polyglot_disabled') || index(g:polyglot_disabled, 'handlebars') == -1
  
if has("autocmd")
  au  BufNewFile,BufRead *.html set filetype=html.mustache syntax=mustache | runtime! ftplugin/mustache.vim ftplugin/mustache*.vim ftplugin/mustache/*.vim
endif
endif
