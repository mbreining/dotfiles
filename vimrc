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

" Sets {{{
set autoindent " maintain indent of current line
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=1000 " keep 1000 lines of command line history
set ruler " show the cursor position all the time
set showcmd " show command in bottom bar
set scrolloff=8
set showmode " show current mode
set hidden " allow buffer switching w/o saving
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to
set ttyfast
set list listchars=tab:»·,trail:· " display extra whitespace
set cursorline " highlight current line
set mouse=a " automatically enable mouse usage
set mousehide " hide mouse cursor while typing
syntax enable " enable colors

set shortmess+=filmnrxoOtT " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set iskeyword-=. " . is an end of word designator
set iskeyword-=# " # is an end of word designator
set iskeyword-=- " - is an end of word designator

if has('linebreak')
  set breakindent " indent wrapped lines to match start
endif

" Line numbers
" https://github.com/jeffkreeftmeijer/vim-numbertoggle
set nonumber
set relativenumber
set number " show current line number
set numberwidth=5

" Bell
set visualbell " display error bells visually
if exists('&belloff')
  set belloff=all " never ring the bell for any reason
endif

" Spelling
set nospell " disable spell checking by default
set spelllang=en_us " set region to US English

" Spaces and tabs
set tabstop=2 " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tabs are spaces
set shiftwidth=2

" Status line
" https://github.com/itchyny/lightline.vim
set laststatus=2 " always display the status line
set noshowmode

" Search
set ignorecase
set smartcase
set incsearch " search as characters are entered
set showmatch " highlight matching [{()}]
set hlsearch " highlight all matches

" Completion
set wildmode=list:longest,list:full " tab completion options
set complete=.,t

" Folding
set foldmethod=indent " fold based on indent level
set foldlevelstart=10 " open most folds by default
set foldnestmax=10 " 10 nested fold max

" No backup files, no swap files
set noswapfile
set nobackup
set nowritebackup
set undodir=~/.vim/undo
" }}}

" Key mappings {{{
" vimrc config
nnoremap <leader>ve :split ~/dotfiles/vimrc<cr>
nnoremap <leader>vs :w<cr> :source $MYVIMRC<cr> :edit!<cr>

" Toggle search highlighting
nnoremap <leader><space> :set invhlsearch<cr>

" Map autocomplete to tab
inoremap <Tab> <C-P>

" Windows
nnoremap <C-J> <C-W>j
nnoremap <C-K> <C-W>k
nnoremap <C-L> <C-W>l
nnoremap <C-H> <C-W>h

" Tabs
nnoremap <leader>tn :tabnew<cr>
nnoremap <leader>to :tabonly<cr>
nnoremap <leader>tc :tabclose<cr>
nnoremap <leader>tm :tabmove<space>

" Open an edit command with the path of the current buffer.
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=fnameescape(expand('%:p:h')).'/'<cr>
nmap <leader>ew :e %%
nmap <leader>es :sp %%
nmap <leader>ev :vsp %%
nmap <leader>et :tabe %%

" Open an edit command with the path of the current working directory.
cnoremap PWD <C-R>=getcwd().'/'<cr>
nmap <leader>eW :e PWD
nmap <leader>eS :sp PWD
nmap <leader>eV :vsp PWD
nmap <leader>eT :tabe PWD

" Folding
" Toggle fold w/ space
nnoremap <space> za
vnoremap <space> za
" Open all / Close all
nnoremap <leader>fo :set foldlevel=10<cr>
nnoremap <leader>fc :set foldlevel=0<cr>

" Move up and down on a row basis
nnoremap j gj
nnoremap k gk

" Display all lines with keyword under cursor and ask which one to jump to
nnoremap <leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<cr>

" Disable F1 help
nnoremap <F1> <Esc>

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
nnoremap <C-x> :bd!<cr>

" Show absolute file path and number of lines
nnoremap <C-g> 1<C-g>

" Change working directory to that of the current file
cmap cd. lcd %:p:h<cr>

" Duplicate a selection in visual mode
vnoremap D y'>p

" Yank from the cursor to the end of the line, to be consistent with C and D
nnoremap Y y$

" Hide Ex mode http://www.bestofvim.com/tip/leave-ex-mode-good/
nnoremap Q <nop>

" Save changes
nnoremap <C-s> :w<cr>
inoremap <C-s> <esc>:w<cr>a

" Quickfix toggle
nnoremap <leader>qt :call QuickfixToggle()<cr>

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

" Plugins {{{
function! PackInit() abort
  packadd minpac

  call minpac#init()
  call minpac#add('k-takata/minpac', {'type': 'opt'})

  " general
  call minpac#add('qpkorr/vim-bufkill')
  call minpac#add('tpope/vim-surround')
  call minpac#add('tpope/vim-repeat')
  call minpac#add('tpope/vim-fugitive')
  call minpac#add('tomtom/tcomment_vim')
  call minpac#add('easymotion/vim-easymotion')
  call minpac#add('christoomey/vim-system-copy')
  call minpac#add('itchyny/lightline.vim')

  " file management
  call minpac#add('junegunn/fzf')
  call minpac#add('junegunn/fzf.vim')

  " colorscheme
  call minpac#add('morhetz/gruvbox')

  " notes
  call minpac#add('xolox/vim-misc')
  call minpac#add('xolox/vim-notes')

  " syntax / lsp
  " https://www.youtube.com/watch?v=OXEVhnY621M
  call minpac#add('neoclide/coc.nvim', {'branch': 'release'})
  call minpac#add('scrooloose/syntastic')

  " markdown
  call minpac#add('tpope/vim-markdown')

  " cpp
  " call minpac#add('preservim/tagbar')

  " python https://www.vimfromscratch.com/articles/vim-for-python/
  " call minpac#add('tmhedberg/SimpylFold')
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

" bufkill {{{
nnoremap <leader>bx :BD<cr>
nnoremap <leader>bb :BB<cr>
nnoremap <leader>bf :BF<cr>
" }}}

" gruvbox {{{
colorscheme gruvbox
set background=dark
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
let g:netrw_browse_split = 0
nnoremap <C-n> :Explore<cr>
" }}}

" Fzf {{{
if isdirectory(expand("~/.vim/pack/minpac/start/fzf.vim"))
  nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<cr>"
  nnoremap <C-b> :Buffers<cr>
endif
" }}}

" vim-notes {{{
if isdirectory(expand("~/.vim/pack/minpac/start/vim-notes"))
  let g:notes_directories = ['~/notes']
  let g:notes_suffix = '.txt'
  nnoremap <leader>cn :Note<space>
  nnoremap <leader>cj :execute 'Note '.strftime('%Y-%m-%d')<cr>
  nnoremap <leader>cs :SearchNotes<space>
  nnoremap <leader>cd :DeleteNote<space>
endif
" }}}

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
