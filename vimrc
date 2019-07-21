" Inspired by:
" https://github.com/spf13/spf13-vim
" http://dougblack.io/words/a-good-vimrc.html
" http://statico.github.io/vim.html
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
" https://begriffs.com/posts/2019-07-19-history-use-vim.html#third-party-plugins

" Modeline {{{
" http://www.cs.swarthmore.edu/help/vim/modelines.html
set modelines=10
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
"  }}}

set nocompatible " vim settings rather than vi (must be first!)
filetype off

" Plugins {{{
" now using vim 8 plugin manager as opposed to vundle, see install_vim_plugins.sh
" }}}

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

" http://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim
set pastetoggle=<F12>
set paste " do not auto-indent when pasting text

set shortmess+=filmnrxoOtT " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better Unix / Windows compatibility
"set virtualedit=onemore " allow for cursor beyond last character
set iskeyword-=. " '.' is an end of word designator
set iskeyword-=# " '#' is an end of word designator
set iskeyword-=- " '-' is an end of word designator
" }}}

" Colors {{{
" iTerm and vim colorschemes should match. However currently using monokai in iterm
" and solarized in vim (i like the result in tmux).
" For a list of iterm colorschemes: https://iterm2colorschemes.com/
" For a list of vim colorschemes: https://github.com/flazz/vim-colorschemes
syntax enable

" https://github.com/altercation/solarized/tree/master/vim-colors-solarized
" iTerm2 setting: http://stackoverflow.com/questions/7278267/incorrect-colors-with-vim-in-iterm2-using-solarized
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  let g:solarized_contrast="normal"
  let g:solarized_visibility="normal"
  colorscheme solarized
endif

" Allow to trigger background
function! ToggleBG()
  let s:tbg = &background
  if s:tbg == "dark"
    set background=light
  else
    set background=dark
  endif
endfunction
noremap <Leader>bg :call ToggleBG()<CR>

nnoremap <Leader><F1> :colorscheme solarized<CR>
" }}}

" Spaces and tabs {{{
set tabstop=2 " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tabs are spaces
set shiftwidth=2
" }}}

" Status bar {{{
if has('cmdline_info')
  set ruler " show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " a ruler on steroids
  set showcmd " show partial commands in status line and
              " selected characters/lines in visual mode
endif

if has('statusline')
  set laststatus=2 " always display the status line
  set statusline=%<%f\                     " filename
  set statusline+=%w%h%m%r                 " options
  set statusline+=%{fugitive#statusline()} " git Hotness
  set statusline+=\ [%{&ff}/%Y]            " filetype
  set statusline+=\ [%{getcwd()}]          " current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " right aligned file nav info
endif
" }}}

" Search {{{
set ignorecase
set smartcase
set incsearch " search as characters are entered
set showmatch " highlight matching [{()}]
set hlsearch " highlight all matches
" Toggle search highlighting
nnoremap <Leader><Space> :set invhlsearch<CR>
" Alternatively, hide search highlighting
"nnoremap <Leader><space> :noh<CR>
" }}}

" Completion {{{
set wildmode=list:longest,list:full " tab completion options
set complete=.,t
" Map autocomplete to tab
inoremap <Tab> <C-P>
" }}}

" Folding {{{
set foldenable " fold files by default on open
set foldmethod=indent " fold based on indent level
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max"

  " Code folding key mappings {{{
  " Toggle fold w/ space
  nnoremap <Space> za
  vnoremap <Space> za

  " Fold level
  nnoremap <Leader>f0 :set foldlevel=0<CR>
  nnoremap <Leader>f1 :set foldlevel=1<CR>
  nnoremap <Leader>f2 :set foldlevel=2<CR>
  nnoremap <Leader>f3 :set foldlevel=3<CR>
  nnoremap <Leader>f4 :set foldlevel=4<CR>
  nnoremap <Leader>f5 :set foldlevel=5<CR>
  nnoremap <Leader>f6 :set foldlevel=6<CR>
  nnoremap <Leader>f7 :set foldlevel=7<CR>
  nnoremap <Leader>f8 :set foldlevel=8<CR>
  nnoremap <Leader>f9 :set foldlevel=9<CR>
  " }}}
" }}}

" Filetypes {{{
filetype on " enable file-type detection
filetype indent on " load indent files to automatically do language-dependent indenting
filetype plugin on " enable file-type plugins

  " Coding {{{
  "https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/
  au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=89 |
    \ set expandtab |
    \ set autoindent |
    \ set foldlevel=0 |
    \ set fileformat=unix

  au BufNewFile,BufRead *.js,*.html,*.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
  " }}}
" }}}

" Backups {{{
" Also see vim-autoswap plugin which auto manages swap files.
set nobackup
set nowritebackup
silent execute '!mkdir -p ~/.vim_bak'
set backupdir=~/.vim_bak//
set directory=~/.vim_bak//
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
nnoremap <Leader>q :call QuickfixToggle()<CR>

let g:quickfix_is_open = 0

function! QuickfixToggle()
  if g:quickfix_is_open
    cclose
    let g:quickfix_is_open = 0
    execute g:quickfix_return_to_window . "wincmd w"
  else
    let g:quickfix_return_to_window = winnr()
    copen
    let g:quickfix_is_open = 1
  endif
endfunction
" }}}

" Autocommands {{{
" Always switch to the current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
" }}}

" Leader key mappings {{{
  " .vimrc {{{
  " Edit .vimrc in vertical split
  nnoremap <Leader>ev :split $MYVIMRC<CR>
  " Reload .vimrc (:edit! to play nice with Airline, folding, etc)
  nnoremap <Leader>sv :source $MYVIMRC<CR> :edit!<CR>
  " }}}

  " Tabs {{{
  nnoremap <Leader>tn :tabnew<CR>
  nnoremap <Leader>to :tabonly<CR>
  nnoremap <Leader>tc :tabclose<CR>
  nnoremap <Leader>tm :tabmove
  " Open a new tab with the current buffer's path
  nnoremap <Leader>te :tabedit <C-R>=expand("%:p:h")<CR>/
  " }}}

  nnoremap <Leader>. :cd %:h<CR>

  " Open an edit command with the path of the currently edited file filled in
  " http://vimcasts.org/episodes/the-edit-command/
  cnoremap %% <C-R>=fnameescape(expand('%:p:h')).'/'<CR>
  nnoremap <Leader>ew :e %%
  nnoremap <Leader>es :sp %%
  "nnoremap <Leader>ev :vsp %%
  nnoremap <Leader>et :tabe %%

  " Display all lines with keyword under cursor and ask which one to jump to
  nnoremap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

  " Convert one-line comment into end-of-line comment
  nnoremap <Leader>dp ddpkJ
" }}}

" Other key mappings {{{
" Highlight last inserted text
nnoremap gV `[v`]

" Change working directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Insert the path of the currently edited file into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

" Duplicate a selection in visual mode
vnoremap D y'>p

" Disable F1 help
nnoremap <F1> <Esc>

" Yank from the cursor to the end of the line, to be consistent with C and D.
nnoremap Y y$

" Delete a line in insert mode
inoremap <C-d> <ESC>ddi
" Exit insert mode
inoremap jk <esc>

" Hide Ex mode http://www.bestofvim.com/tip/leave-ex-mode-good/
nnoremap Q <NOP>

" Save changes
nnoremap <C-S> :w<CR>
inoremap <C-S> <ESC>:w<CR>a

" Force save
cmap w!! %!sudo tee > /dev/null %
" }}}

" NERDTree {{{
if isdirectory(expand("~/.vim/pack/general/start/nerdtree"))
  nnoremap <C-n> :NERDTreeToggle<CR>
  nnoremap <C-n><C-f> :NERDTreeFind<CR>

  let NERDTreeDirArrows = 1
  let NERDTreeShowBookmarks=1
  let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
  let NERDTreeChDirMode=0
  let NERDTreeQuitOnOpen=1
  let NERDTreeMouseMode=2
  let NERDTreeShowHidden=1
  let NERDTreeKeepTreeInNewTab=1
  let g:nerdtree_tabs_open_on_gui_startup=0
endif
" }}}

" Fzf {{{
if isdirectory(expand("~/.vim/pack/general/start/fzf.vim"))
  nnoremap <C-p> :GFiles<CR>
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

" vim-rooter {{{
if isdirectory(expand("~/.vim/pack/general/start/vim-rooter"))
  let g:rooter_silent_chdir = 1
endif
" }}}

" Prettier {{{
if isdirectory(expand("~/.vim/pack/general/start/vim-prettier"))
  " Run Prettier async before saving
  let g:prettier#autoformat = 0
  " autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync
endif
" }}}

" python-mode {{{
if isdirectory(expand("~/.vim/pack/general/start/python-mode"))
  let g:pymode_breakpoint_bind = '<Leader>b'
endif
" }}}

" SimpylFold {{{
if isdirectory(expand("~/.vim/pack/general/start/SimpylFold"))
  " To see in action options below, set fold level to 0
  " Fold docstrings
  let g:SimpylFold_fold_docstring = 1
  " Do not fold imports
  let g:SimpylFold_fold_import = 0
endif
" }}}
