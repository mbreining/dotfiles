" Inspired by:
" https://github.com/spf13/spf13-vim
" http://dougblack.io/words/a-good-vimrc.html

" Modeline {{{
" http://www.cs.swarthmore.edu/help/vim/modelines.html
set modelines=10
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
"  }}}

" Vundle {{{
set nocompatible " vim settings rather than vi (must be first!)
filetype off
if filereadable(expand("~/.vimrc.bundles"))
  source ~/.vimrc.bundles
endif
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
set encoding=utf-8 " character encoding used inside vim (buffers, registers, etc)
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

" Always switch to the current file directory
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif

set shortmess+=filmnrxoOtT " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better Unix / Windows compatibility
set virtualedit=onemore " allow for cursor beyond last character
set iskeyword-=. " '.' is an end of word designator
set iskeyword-=# " '#' is an end of word designator
set iskeyword-=- " '-' is an end of word designator
" }}}

" Colors {{{
syntax enable
set background=dark

" Fix colorschemes in tmux
" http://sunaku.github.io/vim-256color-bce.html
if &term =~ '256color'
  set t_ut=
endif

" https://github.com/altercation/solarized/tree/master/vim-colors-solarized
" iTerm2 setting: http://stackoverflow.com/questions/7278267/incorrect-colors-with-vim-in-iterm2-using-solarized
if filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
  "let g:solarized_termcolors=256
  "let g:solarized_termtrans=1
  "let g:solarized_contrast="normal"
  "let g:solarized_visibility="normal"
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
noremap <leader>bg :call ToggleBG()<CR>
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
nnoremap <leader><space> :set invhlsearch<CR>
" Alternatively, hide search highlighting
"nnoremap <leader><space> :noh<CR>

" Disable VIM's broken default regex
nnoremap / /\v
vnoremap / /\v
" }}}

" Completion {{{
set wildmode=list:longest,list:full " tab completion options
set complete=.,t
" Map autocomplete to tab
inoremap <tab> <C-P>
" }}}

" Folding {{{
set foldenable " fold files by default on open
set foldmethod=indent " fold based on indent level
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max"
" Toggle fold w/ space
nnoremap <space> za
vnoremap <space> za

" Code folding options
nnoremap <leader>f0 :set foldlevel=0<CR>
nnoremap <leader>f1 :set foldlevel=1<CR>
nnoremap <leader>f2 :set foldlevel=2<CR>
nnoremap <leader>f3 :set foldlevel=3<CR>
nnoremap <leader>f4 :set foldlevel=4<CR>
nnoremap <leader>f5 :set foldlevel=5<CR>
nnoremap <leader>f6 :set foldlevel=6<CR>
nnoremap <leader>f7 :set foldlevel=7<CR>
nnoremap <leader>f8 :set foldlevel=8<CR>
nnoremap <leader>f9 :set foldlevel=9<CR>
" }}}

" Filetypes {{{
filetype on " enable file-type detection
filetype indent on " load indent files to automatically do language-dependent indenting
filetype plugin on " enable file-type plugins
" }}}

" Backups {{{
set nobackup
set nowritebackup
silent execute '!mkdir -p ~/.vim_tmp'
set backupdir=~/.vim_tmp//
set directory=~/.vim_tmp//
" }}}

" Spelling {{{
set nospell " disable spell checking by default
set spelllang=en_us " set region to US English
nnoremap <leader>ss :setlocal spell!<CR>
nnoremap <leader>sn ]s " go to next error
nnoremap <leader>sp [s " got to previous error
"nnoremap <leader>ss z= " show suggestions
nnoremap <leader>sl 1z= " feeling lucky
" }}}

" Key mappings {{{
" Edit .vimrc in vertical split
nnoremap <leader>ev :split $MYVIMRC<CR>
" Reload .vimrc (:edit! to play nice with Airline, folding, etc)
nnoremap <leader>sv :source $MYVIMRC<CR> :edit!<CR>

" Navigation
nnoremap <C-J> gjh " move one unnumbered line down
nnoremap <C-K> gkh " move one unnumbered line up
nnoremap gV `[v`] " highlight last inserted text

" Open an edit command with the path of the currently edited file filled in
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:p:h')).'/'<CR>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Useful mappings for managing tabs
map <leader>tn :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove
" Open a new tab with the current buffer's path
map <leader>te :tabedit <C-R>=expand("%:p:h")<CR>/

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

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

" Map <leader>ff to display all lines with keyword under cursor
" and ask which one to jump to
nnoremap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

" Convert one-line comment into end-of-line comment
nnoremap <leader>dp ddpkJ

inoremap <C-d> <ESC>ddi " delete a line in insert mode
inoremap jk <esc> " exit insert mode

" Hide Ex mode http://www.bestofvim.com/tip/leave-ex-mode-good/
nnoremap Q <nop>

" Save changes
nnoremap <C-S> :w<CR>
inoremap <C-S> <ESC>:w<CR>a

" Save session, reopen with vim -S
nnoremap <leader>save :mksession<CR>

" Force save
cmap w!! %!sudo tee > /dev/null %
" }}}

" NERDTree {{{
if isdirectory(expand("~/.vim/bundle/nerdtree"))
  nnoremap <leader>n :NERDTree<CR>
  "map <C-e> <plug>NERDTreeTabsToggle<CR>
  nnoremap <leader>e :NERDTreeFind<CR>
  nnoremap <leader>nt :NERDTreeFind<CR>

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

" CtrlP {{{
let g:ctrlp_map='<C-P>'
let g:ctrlp_cmd='CtrlP'
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_custom_ignore={
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }
"let g:ctrlp_show_hidden=1
" }}}

" Ack plugin {{{
nnoremap <Leader>a :Ack
" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif
" }}}

" Airline {{{
let g:airline_powerline_fonts=1
" }}}

" Vim-Buffergator {{{
" Display buffergator as a bottom horizontal split
let g:buffergator_viewport_split_policy="B"
" }}}
