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
set autoindent " maintain indent of current line
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=1000 " keep 1000 lines of command line history
set ruler " show the cursor position all the time
set showcmd " show command in bottom bar
set scrolloff=3
set showmode " show current mode
set hidden " allow buffer switching w/o saving
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to
set ttyfast
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

if has('linebreak')
  set breakindent " indent wrapped lines to match start
endif

set visualbell " display error bells visually
if exists('&belloff')
  set belloff=all " never ring the bell for any reason
endif
" }}}

" Colors {{{
syntax enable
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
nnoremap <leader><space> :set invhlsearch<CR>
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
  nnoremap <leader>fo :set foldlevel=10<CR>
  nnoremap <leader>fc :set foldlevel=0<CR>
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
silent execute '!mkdir -p ~/.vim/tmp/{backup,swap,undo}'
set backupdir=~/.vim/tmp/backup
set directory=~/.vim/tmp/swap
set undodir=~/.vim/tmp/undo
set updatetime=100
" }}}

" Spelling {{{
set nospell " disable spell checking by default
set spelllang=en_us " set region to US English
" nnoremap <leader>ss :setlocal spell!<CR>
" nnoremap <leader>sn ]s " go to next error
" nnoremap <leader>sp [s " got to previous error
" nnoremap <leader>ss z= " show suggestions
" nnoremap <leader>sl 1z= " feeling lucky
" }}}

" Quickfix {{{
nnoremap <leader>qt :call QuickfixToggle()<CR>

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
" }}}

" Key mappings {{{
" vimrc config
nnoremap <leader>ve :split $MYVIMRC<CR>
nnoremap <leader>vs :w<CR> :source $MYVIMRC<CR> :edit!<CR>

" Windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" Tabs
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tc :tabclose<CR>
nnoremap <leader>tm :tabmove
" Open a new tab with the current buffer's path
nnoremap <leader>te :tabedit <C-R>=expand("%:p:h")<CR>/

nnoremap <leader>. :cd %:h<CR>

" Open an edit command with the path of the currently edited file filled in
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:p:h')).'/'<CR>
nmap <leader>ew :e %%
nmap <leader>es :sp %%
nmap <leader>ev :vsp %%
nnoremap <leader>et :tabe %%

" Display all lines with keyword under cursor and ask which one to jump to
nnoremap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

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
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tomtom/tcomment_vim')
  call minpac#add('easymotion/vim-easymotion')
  call minpac#add('christoomey/vim-system-copy')
  call minpac#add('itchyny/lightline.vim')

  " colorscheme
  call minpac#add('morhetz/gruvbox')

  " syntax
  " call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
  " call minpac#add('dense-analysis/ale')
  call minpac#add('scrooloose/syntastic')

  " markdown
  call minpac#add('tpope/vim-markdown')

  " cpp
  " call minpac#add('preservim/tagbar')

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
  " call minpac#add('prettier/vim-prettier')
  " call minpac#add ('leafgarland/typescript-vim')
endfunction

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus packadd minpac | call minpac#status()

if isdirectory(expand("~/.vim/pack/minpac"))
  call PackInit()
endif
" }}}

" gruvbox {{{
colorscheme gruvbox
set background=dark
" }}}

" bufkill {{{
nnoremap <leader>bx :BD<cr>
nnoremap <leader>bb :BB<cr>
nnoremap <leader>bf :BF<cr>
" }}}

" lightline {{{
let g:lightline = {
      \ 'component_function': {
      \   'filename': 'LightlineFilename',
      \ }
      \ }

function! LightlineFilename()
  let root = fnamemodify(get(b:, 'git_dir'), ':h')
  let path = expand('%:p')
  if path[:len(root)-1] ==# root
    return path[len(root)+1:]
  endif
  return expand('%')
endfunction
" }}}

" Netrw {{{
let g:netrw_banner = 0
let g:netrw_liststyle = 3
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

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
