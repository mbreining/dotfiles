" http://www.cs.swarthmore.edu/help/vim/modelines.html
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:

" Inspired by:
" https://github.com/spf13/spf13-vim
" http://dougblack.io/words/a-good-vimrc.html
" http://statico.github.io/vim.html
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
" https://begriffs.com/posts/2019-07-19-history-use-vim.html#third-party-plugins

set nocompatible " vim settings rather than vi (must be first!)
filetype off

" Leader keys {{{
let mapleader = ","
let maplocalleader = "\\"
" }}}

" General settings {{{
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=1000 " keep 1000 lines of command line history
set ruler " show the cursor position all the time
set showcmd " show command in bottom bar
scriptencoding utf-8 " character encoding used in this script
if !has("nvim")
  set encoding=utf-8 " character encoding used inside vim (buffers, registers, etc)
endif
set scrolloff=3
set showmode " show current mode
set hidden " allow buffer switching w/o saving
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to
set ttyfast
set visualbell " display error bells visually
set list listchars=tab:»·,trail:· " display extra whitespace
set cursorline " highlight current line
set mouse=a " automatically enable mouse usage
set mousehide " hide mouse cursor while typing

" https://github.com/jeffkreeftmeijer/vim-numbertoggle
set nonumber
set relativenumber
set numberwidth=5

set shortmess+=filmnrxoOtT " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
"set virtualedit=onemore " allow for cursor beyond last character
set iskeyword-=. " . is an end of word designator
set iskeyword-=# " # is an end of word designator
set iskeyword-=- " - is an end of word designator
" }}}

" Colors {{{
syntax enable

" Force 256 colors
if $TERM == "xterm-256color" || $TERM == "screen-256color" || $COLORTERM == "gnome-terminal"
  set t_Co=256
endif

hi CursorLine term=bold cterm=bold " no underline on current line
" }}}

" Spaces and tabs {{{
set tabstop=2 " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tabs are spaces
set shiftwidth=2
" }}}

" Status line {{{
" https://github.com/itchyny/lightline.vim
set laststatus=2 " always display the status line
set noshowmode
" }}}

" Search {{{
set ignorecase
set smartcase
set incsearch " search as characters are entered
set showmatch " highlight matching [{()}]
set hlsearch " highlight all matches
" Toggle search highlighting
nnoremap <Leader><Space> :set invhlsearch<CR>
" }}}

" Completion {{{
set wildmode=list:longest,list:full " tab completion options
set complete=.,t
" Map autocomplete to tab
inoremap <Tab> <C-P>
" }}}

" Folding {{{
set foldmethod=indent " fold based on indent level
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max

  " Code folding key mappings {{{
  " Toggle fold w/ space
  nnoremap <Space> za
  vnoremap <Space> za

  " Open all / Close all
  nnoremap <Leader>fo :set foldlevel=10<CR>
  nnoremap <Leader>fc :set foldlevel=0<CR>
  " }}}
" }}}

" Filetypes {{{
filetype on " enable file-type detection
filetype indent on " load indent files to automatically do language-dependent indenting
filetype plugin on " enable file-type plugins

"https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
autocmd BufNewFile,BufRead *.py
  \ set tabstop=4 |
  \ set softtabstop=4 |
  \ set shiftwidth=4 |
  \ set textwidth=89 |
  \ set colorcolumn=+1 |
  \ set expandtab |
  \ set autoindent |
  \ set fileformat=unix

autocmd BufNewFile,BufRead *.js,*.html,*.css
  \ set tabstop=2 |
  \ set softtabstop=2 |
  \ set shiftwidth=2

autocmd BufRead,BufNewFile *.md set filetype=markdown
autocmd BufRead,BufNewFile .{jscs,jshint,eslint}rc set filetype=json
" }}}

" Backups {{{
" Also see vim-autoswap plugin which auto manages swap files.
set nobackup
set nowritebackup
silent execute '!mkdir -p ~/.vim_bak'
set backupdir=~/.vim_bak//
set directory=~/.vim_bak//
set updatetime=100
" }}}

" Spelling {{{
set nospell " disable spell checking by default
set spelllang=en_us " set region to US English
nnoremap <Leader>ss :setlocal spell!<CR>
nnoremap <Leader>sn ]s " go to next error
nnoremap <Leader>sp [s " got to previous error
"nnoremap <Leader>ss z= " show suggestions
nnoremap <Leader>sl 1z= " feeling lucky
" }}}

" Quickfix {{{
nnoremap <Leader>qt :call QuickfixToggle()<CR>

function! QuickfixToggle()
  for i in range(1, winnr('$'))
    let bnum = winbufnr(i)
    if getbufvar(bnum, '&buftype') == 'quickfix'
      cclose
      return
    endif
  endfor
  copen
endfunction
" }}}

" Autocommands {{{
" Always switch to the current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
" }}}

" Leader mappings {{{
" VIM config
nnoremap <Leader>ve :split $MYVIMRC<CR>
nnoremap <Leader>vs :w<CR> :source $MYVIMRC<CR> :edit!<CR>

" Tabs
nnoremap <Leader>tn :tabnew<CR>
nnoremap <Leader>to :tabonly<CR>
nnoremap <Leader>tc :tabclose<CR>
nnoremap <Leader>tm :tabmove
" Open a new tab with the current buffer's path
nnoremap <Leader>te :tabedit <C-R>=expand("%:p:h")<CR>/

nnoremap <Leader>. :cd %:h<CR>

" Open an edit command with the path of the currently edited file filled in
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:p:h')).'/'<CR>
nmap <Leader>ew :e %%
nmap <Leader>es :sp %%
nmap <Leader>ev :vsp %%
nnoremap <Leader>et :tabe %%

" Display all lines with keyword under cursor and ask which one to jump to
nnoremap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>
" }}}

" Other mappings {{{
" Disable F1 help
nnoremap <F1> <Esc>

" Move up and down on a row basis
nnoremap j gj
nnoremap k gk

" Emacs-style movement keys in command mode
cnoremap <C-a>  <Home>
cnoremap <C-b>  <Left>
cnoremap <C-f>  <Right>
cnoremap <C-d>  <Delete>
cnoremap <M-b>  <S-Left>
cnoremap <M-f>  <S-Right>
cnoremap <M-d>  <S-right><Delete>
cnoremap <Esc>b <S-Left>
cnoremap <Esc>f <S-Right>
cnoremap <Esc>d <S-right><Delete>
cnoremap <C-g>  <C-c>

" Close current buffer
nnoremap <C-x> :bd!<CR>

" Show absolute file path and number of lines
nnoremap <C-g> 1<C-g>

" Change working directory to that of the current file
cmap cd. lcd %:p:h<CR>

" Duplicate a selection in visual mode
vnoremap D y'>p

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" Hide Ex mode http://www.bestofvim.com/tip/leave-ex-mode-good/
nnoremap Q <NOP>

" Save changes
nnoremap <C-s> :w<CR>
inoremap <C-s> <ESC>:w<CR>a
" }}}

" Plugins {{{
function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " general
  call minpac#add('qpkorr/vim-bufkill')
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')
  call minpac#add('mileszs/ack.vim')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tomtom/tcomment_vim')
  call minpac#add('easymotion/vim-easymotion')
  call minpac#add('christoomey/vim-system-copy')
  call minpac#add('itchyny/lightline.vim')

  " syntax
  call minpac#add('tpope/vim-markdown')
  call minpac#add('dense-analysis/ale')
  call minpac#add('prettier/vim-prettier')
  call minpac#add('scrooloose/syntastic')

  " python https://www.vimfromscratch.com/articles/vim-for-python/
  call minpac#add('tmhedberg/SimpylFold')
  call minpac#add('klen/python-mode')
  " call minpac#add('sheerun/vim-polyglot')
  call minpac#add('yssource/python.vim')

  " ruby
  " call minpac#add('tpope/vim-rails')
  " call minpac#add('tpope/vim-rake')
  " call minpac#add('tpope/vim-bundler')
  " call minpac#add('tpope/vim-endwise')

  " web
  " call minpac#add ('leafgarland/typescript-vim')
endfunction

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

if isdirectory(expand("~/.vim/pack/minpac"))
  call PackInit()
endif
" }}}

" bufkill {{{
nnoremap <Leader>bx :BD<CR>
nnoremap <Leader>bb :BB<CR>
nnoremap <Leader>bf :BF<CR>
" }}}

" Netrw {{{
let g:netrw_banner = 0
let g:netrw_winsize = 25
let g:netrw_browse_split = 4
nnoremap <C-n> :Vexplore<CR>
" }}}

" Fzf {{{
if isdirectory(expand("~/.vim/pack/minpac/start/fzf.vim"))
  nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<CR>"
  nnoremap <C-b> :Buffers<CR>
endif
" }}}

" Ack {{{
if executable("ack")
  " Use Ack instead of Grep when available
  set grepprg=ack\ -H\ --nogroup\ --nocolor
  let g:ackhighlight = 1
endif
nnoremap <C-k> :Ack!<Space>
" Search for word under cursor
nnoremap <C-k><C-d> :Ack! -w <C-r><C-w><CR>
" }}}

" Prettier {{{
if isdirectory(expand("~/.vim/pack/minpac/start/vim-prettier"))
  " Run Prettier async before saving
  let g:prettier#autoformat = 0
  autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
endif
" }}}

" SimpylFold {{{
if isdirectory(expand("~/.vim/pack/minpac/start/SimpylFold"))
  let g:SimpylFold_fold_docstring = 1
  let g:SimpylFold_fold_import = 1
endif
" }}}
