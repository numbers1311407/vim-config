set nocompatible

filetype on
filetype plugin on
filetype indent on

syntax enable
 
let mapleader=","

set ignorecase
set smartcase
set cf                                        " Enable error files & error jumping.
set clipboard+=unnamed                        " Yanks go on clipboard instead.
set history=256                               " Number of things to remember in history.
set autowrite                                 " Writes on make/shell commands
set ruler                                     " Ruler on
set nu                                        " Line numbers on
set nowrap                                    " Line wrapping off
set timeoutlen=350                            " Timeout for chained commands (leader, etc)
set ts=2                                      " Tabs are 2 spaces
set bs=2                                      " Backspace over everything in insert mode
set shiftwidth=2                              " Tabs under smart indent
set softtabstop=2
set expandtab
set smarttab
set autoindent
set nocp incsearch
set hlsearch
set formatoptions=tcqr
set cinoptions=:0,p0,t0
set cinwords=if,else,while,do,for,switch,case
set cindent
set tabline=2
set showmatch                                 " Show matching brackets.
set showcmd                                   " show incomplete cmds down the bottom
set showmode                                  " show current mode down the bottom
set mat=5                                     " Bracket blinking.
set list
set lcs=tab:\ \ ,extends:>,precedes:<         " ,eol:$,trail:~
set noerrorbells                              " No noise.
set laststatus=2                              " Always show status line.
set backspace=indent,eol,start                " allow backspacing over everything in insert mode
set linebreak                                 " wrap lines at convenient points
set foldmethod=indent                         " fold based on indent
set foldnestmax=3                             " deepest fold is 3 levels
set nofoldenable                              " dont fold by default
set wildmode=list:longest                     " make cmdline tab completion similar to bash
set wildmenu                                  " enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~,*.swp             " stuff to ignore when tab completing
set formatoptions-=o                          " dont continue comments when pushing o/O
set scrolloff=3
set sidescrolloff=7
set sidescroll=5
set scrolljump=3
set hidden
set mousehide                                 " Hide mouse after chars typed
set mouse=a                                   " Mouse in all modes
set guioptions-=rRlLTm
" set relativenumber

" cycle through buffers with H and L
map <silent> H :bp<CR>
map <silent> L :bn<CR>

" leader+direction for directional buffer nav
nmap <Leader>k <C-W>k
nmap <Leader>j <C-W>j
nmap <Leader>h <C-W>h
nmap <Leader>l <C-W>l

" leader+s to pull word under cursor into a search/replace (global)
nmap <Leader>s :%s/<c-r><c-w>//g<Left><Left>

" maps esc to break out of autocompletion and reset to 
" original word
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"

nmap <silent> Q :bdelete<CR>
nmap ZZ :qa<CR>

"make Y consistent with C and D
nnoremap Y y$

"visual search mappings
function! s:VSetSearch()
    let temp = @@
    norm! gvy
    let @/ = '\V' . substitute(escape(@@, '\'), '\n', '\\n', 'g')
    let @@ = temp
endfunction
vnoremap * :<C-u>call <SID>VSetSearch()<CR>//<CR>
vnoremap # :<C-u>call <SID>VSetSearch()<CR>??<CR>

"jump to last cursor position when opening a file
"dont do it when writing a commit log entry
autocmd BufReadPost * call SetCursorPosition()
function! SetCursorPosition()
    if &filetype !~ 'commit\c'
        if line("'\"") > 0 && line("'\"") <= line("$")
            exe "normal g`\""
        endif
    end
endfunction

" add jbuilder syntax highlighting
au BufNewFile,BufRead *.json.jbuilder set ft=ruby

" force backupcopy=yes for js, this fixes an issue with webpack file watch
au BufNewFile,BufReadPre *.js set backupcopy=yes

" Open grep commands in quickfix (this includes vim-fugitive log, etc)
au QuickFixCmdPost *grep* cwindow

" ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading\ -S
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

"-------------------------------------------------------------------------------
" FZF
"-------------------------------------------------------------------------------

" This is the default extra key bindings
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

" Default fzf layout
" - down / up / left / right
let g:fzf_layout = { 'down': '~40%' }

" In Neovim, you can set up fzf window using a Vim command
" let g:fzf_layout = { 'window': 'enew' }
" let g:fzf_layout = { 'window': '-tabnew' }
" let g:fzf_layout = { 'window': '10split enew' }

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Enable per-command history.
" CTRL-N and CTRL-P will be automatically bound to next-history and
" previous-history instead of down and up. If you don't like the change,
" explicitly bind the keys to down and up in your $FZF_DEFAULT_OPTS.
let g:fzf_history_dir = '~/.local/share/fzf-history'"

nnoremap <silent> <Leader>a :Ag<CR>
nnoremap <silent> <Leader>f :Files<CR>
nnoremap <silent> <Leader>t :Tags<CR>
nnoremap <silent> <C-n> :Buffers<CR>

"-------------------------------------------------------------------------------
" SuperTab
"-------------------------------------------------------------------------------

let g:SuperTabDefaultCompletionType='context'

"-------------------------------------------------------------------------------
" vim-commentary
"-------------------------------------------------------------------------------

nmap K gcc
vmap K gc

"-------------------------------------------------------------------------------
" Gundo
"-------------------------------------------------------------------------------

nnoremap U :GundoToggle<CR>

"-------------------------------------------------------------------------------
" vim-jsx
"-------------------------------------------------------------------------------

let g:jsx_ext_required = 1

"-------------------------------------------------------------------------------
" lightline.vim
"-------------------------------------------------------------------------------
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ }

"-------------------------------------------------------------------------------
" ack.vim
"-------------------------------------------------------------------------------
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

"-------------------------------------------------------------------------------
" ale
"-------------------------------------------------------------------------------
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 1

"-------------------------------------------------------------------------------

" colo jellybeans
colo vilight
