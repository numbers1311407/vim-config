
set nocompatible  " We don't want vi compatibility.

filetype on  " Automatically detect file types.
 
" Add recently accessed projects menu (project plugin)
set viminfo^=!

let mapleader=","

" maps esc to break out of autocompletion and reset to 
" original word
inoremap <expr> <Esc> pumvisible() ? "\<C-e>" : "\<Esc>"

set ignorecase
set smartcase

" alt+n or alt+p to navigate between entries in QuickFix
" (this isn't working, think it's a shell thing with alt)
map <silent> <m-p> :cp <cr>
map <silent> <m-n> :cn <cr>

" mapping for modified recently menu to \r
map <silent> <Leader>r :MRU<cr>

nmap <silent> Q <Leader>bd<CR>

nmap ZZ :qa<CR>

map <silent> <space> <C-6>

set cf  " Enable error files & error jumping.
set clipboard+=unnamed  " Yanks go on clipboard instead.
set history=256  " Number of things to remember in history.
set autowrite  " Writes on make/shell commands
set ruler  " Ruler on
set nu  " Line numbers on
set nowrap  " Line wrapping off
set timeoutlen=500 " Time to wait after ESC (default causes an annoying delay)

" Formatting (some of these are for coding in C and C++)
set ts=2  " Tabs are 2 spaces
set bs=2  " Backspace over everything in insert mode
set shiftwidth=2  " Tabs under smart indent
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

" Visual
set showmatch  " Show matching brackets.
set showcmd     "show incomplete cmds down the bottom
set showmode    "show current mode down the bottom
set mat=5       " Bracket blinking.
set list
set lcs=tab:\ \ ,extends:>,precedes:< ",eol:$,trail:~
set noerrorbells  " No noise.
set laststatus=2  " Always show status line.

" macro to automatically switch directories when opening files
" autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9]*://" | lcd %:p:h | endif

autocmd QuickfixCmdPost grep,vimgrep,make cw

"map <silent> ,cd :cd %:p:h<CR>

let g:plaintex_delimiters = 0

highlight Pmenu ctermbg=238 gui=bold
"highlight Pmenu ctermfg=0 ctermbg=3 
highlight PmenuSel ctermfg=0 ctermbg=7 
highlight Normal ctermbg=black

" left/right arrows change buffers
map <silent> <C-right> :bn<CR>
map <silent> <C-left> :bp<CR>
map <silent> <C-h> :bp<CR>
map <silent> <C-l> :bn<CR>

" comma+dir for directional buffer nav
nmap ,k <C-W>k
nmap ,j <C-W>j
nmap ,h <C-W>h
nmap ,l <C-W>l

nmap <C-j> <C-d>
nmap <C-k> <C-u>

",s to pull word under cursor into a search/replace (global)
nmap ,s :%s/<c-r><c-w>//g<Left><Left>

"allow backspacing over everything in insert mode
set backspace=indent,eol,start
set linebreak   "wrap lines at convenient points

"statusline setup
set statusline+=%n:   "buffer number
set statusline+=%f\   "relative filename

"display a warning if fileformat isnt unix
"set statusline+=%#warningmsg#
"set statusline+=%{&ff!='unix'?'['.&ff.']':''}
"set statusline+=%*

"display a warning if file encoding isnt utf-8
"set statusline+=%#warningmsg#
"set statusline+=%{(&fenc!='utf-8'&&&fenc!='')?'['.&fenc.']':''}
"set statusline+=%*

set statusline+=%y      "filetype
set statusline+=%m      "modified flag

"display a warning if &et is wrong, or we have mixed-indenting
"set statusline+=%#error#
"set statusline+=%{StatuslineTabWarning()}
"set statusline+=%*


"display a warning if &paste is set
"set statusline+=%#error#
"set statusline+=%{&paste?'[paste]':''}
"set statusline+=%*

set statusline+=%=      "left/right separator
set statusline+=%{StatuslineCurrentHighlight()}\  "current highlight
set statusline+=%c,     "cursor column
set statusline+=%l/%L   "cursor line/total lines
set statusline+=\ %P    "percent through file

"return the syntax highlight group under the cursor ''
function! StatuslineCurrentHighlight()
    let name = synIDattr(synID(line('.'),col('.'),1),'name')
    if name == ''
        return ''
    else
        return '[' . name . ']'
    endif
endfunction

"folding settings
set foldmethod=indent   "fold based on indent
set foldnestmax=3       "deepest fold is 3 levels
set nofoldenable        "dont fold by default

set wildmode=list:longest   "make cmdline tab completion similar to bash
set wildmenu                "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

set formatoptions-=o "dont continue comments when pushing o/O

"vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

"load ftplugins and indent files
filetype plugin on
filetype indent on

"turn on syntax highlighting
syntax on
set t_Co=256

"hide buffers when not displayed
set hidden

" note for whatever reason ttymouse must be set after term is set
" or it will cause problems with the terminal
set ttymouse=xterm2

set mousehide  " Hide mouse after chars typed
set mouse=a  " Mouse in all modes
set guioptions-=rRlLTm

"make <c-l> clear the highlight as well as redraw
"nnoremap <C-L> :nohls<CR><C-L>
"inoremap <C-L> <C-O>:nohls<CR>


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

" overcome
"cmap W %!sudo tee > /dev/null %

" command to get urls
let g:netrw_http_cmd = "wget -q -O"

" yes, GLVS, install what you download
let g:GetLatestVimScripts_allowautoinstall=1

colorscheme vilight
"colorscheme sand
"colorscheme breeze
"colorscheme blackdust
"colorscheme vividchalk
"colorscheme fnaqevan " like dante but more pastel and less contrast
"colorscheme vibrantink " multi, high contrast

"-------------------------------------------------------------------------------
" Minibuffer Explorer Settings
"-------------------------------------------------------------------------------

"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs=1
let g:miniBufExplorerMoreThanOne=1 
let g:miniBufExplMaxSize=2
let g:miniBufExplTabWrap=1


"-------------------------------------------------------------------------------
" Rails.vim
"-------------------------------------------------------------------------------

" Change which file opens after executing :Rails command
let g:rails_default_file='config/database.yml'
nnoremap <silent> ,a :A<CR>
nnoremap <silent> ,,a :AV<CR>
nnoremap <silent> ,r :R<CR>
nnoremap <silent> ,,r :RV<CR>

nnoremap ! :!touch tmp/restart.txt<CR><CR>:echo "Passenger restarted..."<CR>


"-------------------------------------------------------------------------------
" FuzzyFileFinder
"-------------------------------------------------------------------------------

let g:fuf_modesDisable = []
let g:fuf_abbrevMap = {
      \   '^vr:' : map(filter(split(&runtimepath, ','), 'v:val !~ "after$"'), 'v:val . ''/**/'''),
      \   '^m0:' : [ '/mnt/d/0/', '/mnt/j/0/' ],
      \ }
let g:fuf_mrufile_maxItem = 100 
let g:fuf_mrucmd_maxItem = 100
let g:fuf_previewHeight = 0

" not sure if this one was for fuf_textmate
let g:fuzzy_ignore = "gems/*;*.pyc;*.log;*.swf;*.fla"

nnoremap <silent> <C-n>      :FufBuffer<CR>
nnoremap <silent> <C-p>      :FufFileWithCurrentBufferDir<CR>
nnoremap <silent> <C-f><C-p> :FufFileWithFullCwd<CR>
nnoremap <silent> <C-f>p     :FufFile<CR>
nnoremap <silent> <C-f>d     :FufDirWithCurrentBufferDir<CR>
nnoremap <silent> <C-f><C-d> :FufDirWithFullCwd<CR>
nnoremap <silent> <C-f>D     :FufDir<CR>
nnoremap <silent> <C-f>r     :FufMruFile<CR>

"nnoremap <silent> <C-f><C-t> :FufTag<CR>
"nnoremap <silent> <C-f>t     :FufTag!<CR>
"noremap  <silent> g]         :FufTagWithCursorWord!<CR>
"nnoremap <silent> <C-f><C-f> :FufTaggedFile<CR>


"-------------------------------------------------------------------------------
" NERD Tree
"-------------------------------------------------------------------------------

nnoremap <silent> - :NERDTreeToggle<CR>
" close tree when opening a file
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeMapQuit="<Esc>"


"-------------------------------------------------------------------------------
" NERD Commenter
"-------------------------------------------------------------------------------

" Turns off annoying NERDCommenter error messages
let g:NERDShutUp=1
map K <Leader>c<Space>

"-------------------------------------------------------------------------------
" Bufexplorer
"-------------------------------------------------------------------------------

let g:bufExplorerDefaultHelp=0


"-------------------------------------------------------------------------------
" SuperTab
"-------------------------------------------------------------------------------

let g:SuperTabDefaultCompletionType='context'

"-------------------------------------------------------------------------------
" BufClose
"-------------------------------------------------------------------------------

"-------------------------------------------------------------------------------
" Buftabs
"-------------------------------------------------------------------------------

let g:buftabs_only_basename=1

"-------------------------------------------------------------------------------
" NeoComplCache 
"-------------------------------------------------------------------------------

"Use neocomplcache.
"let g:NeoComplCache_EnableAtStartup = 1
"Use smartcase.
"let g:NeoComplCache_SmartCase = 1
"Use camel case completion.
"let g:NeoComplCache_EnableCamelCaseCompletion = 1
"Use underbar completion.
"let g:NeoComplCache_EnableUnderbarCompletion = 1
"Set minimum syntax keyword length.
"let g:NeoComplCache_MinSyntaxLength = 3

"Define dictionary.
"let g:NeoComplCache_DictionaryFileTypeLists = {
    "\ 'default' : '',
    "\ 'vimshell' : $HOME.'/.vimshell_hist',
    "\ 'scheme' : $HOME.'/.gosh_completions'
    "\ }

"Define keyword.
"if !exists('g:NeoComplCache_KeywordPatterns')
    "let g:NeoComplCache_KeywordPatterns = {}
"endif
"let g:NeoComplCache_KeywordPatterns['default'] = '\h\w*'

"Plugin key-mappings.
"imap <C-l>     <Plug>(neocomplcache_snippets_expand)
"smap <C-l>     <Plug>(neocomplcache_snippets_expand)
"inoremap <expr><C-h> pumvisible() ? '\<C-y>\<C-h>' : '\<C-h>'
"inoremap <expr><C-g>     neocomplcache#undo_completion()
"inoremap <expr><C-l>     neocomplcache#complete_common_string()

let g:CSApprox_hook_post = ['hi Normal  ctermbg=NONE ctermfg=NONE',
                          \ 'hi NonText ctermbg=NONE ctermfg=NONE' ]
