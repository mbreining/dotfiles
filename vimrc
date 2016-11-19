" Inspired by:
" https://github.com/spf13/spf13-vim
" http://dougblack.io/words/a-good-vimrc.html
" http://statico.github.io/vim.html
" https://realpython.com/blog/python/vim-and-python-a-match-made-in-heaven/

" Modeline {{{
" http://www.cs.swarthmore.edu/help/vim/modelines.html
set modelines=10
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:
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
syntax enable

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

if filereadable(expand("~/.vim/bundle/vim-colorschemes/colors/gotham256.vim"))
  "colorscheme gotham256
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
nnoremap <Leader><F2> :colorscheme gotham256<CR>
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

" Disable VIM's broken default regex
nnoremap / /\v
vnoremap / /\v
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
" }}}

" Backups {{{
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

  " Find merge conflict markers
  nnoremap <Leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

  " Save session, reopen with vim -S
  nnoremap <Leader>save :mksession<CR>
" }}}

" Other key mappings {{{
" Window navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Navigation
"nnoremap <C-J> gjh " move one unnumbered line down
"nnoremap <C-K> gkh " move one unnumbered line up
nnoremap gV `[v`] " highlight last inserted text

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

inoremap <C-d> <ESC>ddi " delete a line in insert mode
inoremap jk <esc> " exit insert mode

" Hide Ex mode http://www.bestofvim.com/tip/leave-ex-mode-good/
nnoremap Q <NOP>

" Save changes
nnoremap <C-S> :w<CR>
inoremap <C-S> <ESC>:w<CR>a

" Force save
cmap w!! %!sudo tee > /dev/null %
" }}}

" NERDTree {{{
if isdirectory(expand("~/.vim/bundle/nerdtree"))
  nnoremap <Leader>n :NERDTree<CR>
  "nnoremap <C-e> <plug>NERDTreeTabsToggle<CR>
  nnoremap <Leader>e :NERDTreeFind<CR>
  nnoremap <Leader>nt :NERDTreeFind<CR>

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
if isdirectory(expand("~/.vim/bundle/ctrlp.vim"))
  let g:ctrlp_map='<C-P>'
  let g:ctrlp_cmd='CtrlP'
  let g:ctrlp_working_path_mode='ra'
  let g:ctrlp_match_window='bottom,order:btt,min:1,max:30'
  let g:ctrlp_custom_ignore={
    \ 'dir':  '\v[\/]\.(git|hg|svn)$',
    \ 'file': '\v\.(exe|so|dll|pyc)$'
    \ }
  let g:ctrlp_show_hidden=1
endif
" }}}

" Ack plugin {{{
nnoremap <Leader>a :Ack<Space>
if executable("ack")
  " Use Ack instead of Grep when available
  set grepprg=ack\ -H\ --nogroup\ --nocolor
  let g:ackhighlight = 1
  " Search for word under cursor
  nnoremap <Leader>A :Ack <C-r><C-w><CR>
endif
" }}}

" Airline {{{
if isdirectory(expand("~/.vim/bundle/vim-airline"))
  let g:airline_powerline_fonts=1
  let g:airline#extensions#bufferline#enabled = 1
endif
" }}}

" vim-buffergator {{{
if isdirectory(expand("~/.vim/bundle/vim-buffergator"))
  let g:buffergator_viewport_split_policy='B'
  let g:buffergator_hsplit_size=10
endif
" }}}

" python-mode {{{
  " <leader>b is already used by vim-buffergator
  let g:pymode_breakpoint_bind = '<leader>br'
" }}}

" Tagbar {{{
if executable('ctags')
  noremap <Leader>t :TagbarToggle<CR>
endif
" }}}

" Easytags {{{
if executable('ctags')
  let g:easytags_async=1
endif
" }}}
