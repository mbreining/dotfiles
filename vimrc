call pathogen#infect() " load plugins under ./vim/bundle.
call pathogen#helptags() " generate documentation from ./vim/bundle/*/doc.

" Leader character
let mapleader = ","
let maplocalleader = "\\"

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Miscellaneous settings
if has("gui_running")
  set lines=48 columns=170 " maximize gvim window
endif
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=50 " keep 50 lines of command line history
set ruler " show the cursor position all the time
set showcmd " display incomplete commands
set encoding=utf-8
set scrolloff=3
set showmode
set hidden
set wildmenu
set ttyfast
set visualbell " display error bells visually
set list listchars=tab:»·,trail:· " display extra whitespace

" Tabs
set tabstop=2
set shiftwidth=2
set expandtab

" Color scheme
" https://github.com/altercation/solarized/tree/master/vim-colors-solarized
" iTerm2 setting: http://stackoverflow.com/questions/7278267/incorrect-colors-with-vim-in-iterm2-using-solarized
syntax enable
if has('gui_running')
  set background=light
else
  set background=dark
endif
colorscheme solarized
call togglebg#map("<F5>")
"highlight NonText guibg=#060606
"highlight Folded  guibg=#0A0A0A guifg=#9090D0

" Search
set ignorecase
set smartcase
"set gdefault
set incsearch
set showmatch
set hlsearch
nnoremap <Leader><Space> :noh<CR> " hide search highlighting
"nnoremap <Leader>l :set invhls <CR>
" Disable VIM's broken default regex
nnoremap / /\v
vnoremap / /\v

" Status line
set laststatus=2 " always display the status line
" Show file path and file type in status line
set statusline=%f         " Path to the file
set statusline+=\ -\      " Separator
set statusline+=FileType: " Label
set statusline+=%y        " Filetype of the file
set statusline+=%=        " Switch to the right side
set statusline+=%l        " Current line
set statusline+=,         " Separator
set statusline+=%c        " Current column
set statusline+=/         " Separator
set statusline+=%L        " Total lines
set statusline+=\ \       " Separator
set statusline+=%p%%      " Percentage page scroll

" Line numbers
" See https://github.com/jeffkreeftmeijer/vim-numbertoggle
set numberwidth=5
set cursorline " highlight current line

" Completion
set wildmode=list:longest,list:full " tab completion options
set complete=.,t
imap <Tab> <C-P> " map autocomplete to tab

" Folding
" if has("folding")
  " set foldenable
  " set foldmethod=syntax
  " set foldlevel=1
  " set foldnestmax=2
  " set foldtext=strpart(getline(v:foldstart),0,50).'\ ...\ '.substitute(getline(v:foldend),'^[\ #]*','','g').'\ '
" endif

" Backups
set nobackup
set nowritebackup
silent execute '!mkdir -p ~/.vim_store'
set backupdir=~/.vim_store// directory=~/.vim_store//

" Navigation
nnoremap <C-Tab> <C-W><C-W> " cycle through windows
nnoremap <C-J> gj " move one unnumbered line down
nnoremap <C-K> gk " move one unnumbered line up

" Spelling
set spelllang=en_us " set region to US English
nnoremap <silent> <leader>s :set spell!<CR>
nnoremap <leader>sn ]s " go to next error
nnoremap <leader>sp [s " got to previous error
nnoremap <leader>ss z= " show suggestions
nnoremap <leader>sl 1z= " feeling lucky

" Miscellaneous shortcuts
" Edit .vimrc
nnoremap <Leader>er :vsplit $MYVIMRC<CR> " edit .vimrc file in vertical window
nnoremap <Leader>sr :source $MYVIMRC<CR> " reload .vimrc

" Open an edit command with the path of the currently edited file filled in
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=expand('%:p:h').'/'<CR>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Insert the path of the currently edited file into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

vmap D y'>p " Duplicate a selection in visual mode
nmap <F1> <Esc> " disable F1 Help

" Save changes
nnoremap <C-S> :w<CR>
inoremap <C-S> <ESC>:w<CR>a

" Convert one-line comment into end-of-line comment
nnoremap <Leader>dp ddpkJ

inoremap <C-d> <ESC>ddi " delete a line in insert mode
inoremap jk <esc> " exit insert mode

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Enable file type detection and load indent files to automatically
  " do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup global
    autocmd!
    autocmd FileType text setlocal textwidth=78 " for all text files set 'textwidth' to 78 characters.

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

  augroup END

  augroup programming
    autocmd!
    " Rails plugin customizations
    autocmd User Rails Rnavcommand services app/services -glob=**/* -suffix=_service.rb
    autocmd User Rails Rnavcommand features features -glob=**/* -suffix=.feature

    " Easy commenting
    autocmd FileType ruby nnoremap <buffer> <localleader>c I#<ESC>
    autocmd FileType python nnoremap <buffer> <localleader>c I#

    " For Haml
    autocmd! BufRead,BufNewFile *.haml setfiletype haml

    " Use .as for ActionScript files, not Atlas files.
    autocmd BufNewFile,BufRead *.as set filetype=actionscript

    " For BrightScript
    autocmd BufNewFile,BufRead *.brs setfiletype brs
  augroup END
else
  set autoindent " always set autoindenting on
endif " has("autocmd")

" NERDTree
nnoremap <Leader>n :NERDTree<CR>

"Ack
nnoremap <Leader>a :Ack
" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif

" Rails
" The plugin gets loaded the first a file in a rails project is opened.
" Edit the README_FOR_APP to make :R commands work.
nnoremap <Leader>R :e doc/README_FOR_APP<CR>
nnoremap <Leader>TR :tabe doc/README_FOR_APP<CR>
nnoremap <Leader>m :Rmodel
nnoremap <Leader>c :Rcontroller
nnoremap <Leader>v :Rview
nnoremap <Leader>j :Rjavascript
nnoremap <Leader>u :Runittest
nnoremap <Leader>f :Rfunctionaltest
nnoremap <Leader>i :Rintegrationtest
nnoremap <Leader>h :Rhelper
nnoremap <Leader>tm :RTmodel
nnoremap <Leader>tc :RTcontroller
nnoremap <Leader>tv :RTview
nnoremap <Leader>tu :RTunittest
nnoremap <Leader>tf :RTfunctionaltest
nnoremap <Leader>sm :RSmodel
nnoremap <Leader>sc :RScontroller
nnoremap <Leader>sv :RSview
nnoremap <Leader>su :RSunittest
nnoremap <Leader>sf :RSfunctionaltest
nnoremap <Leader>si :RSintegrationtest
command! Rroutes :e config/routes.rb
command! RTroutes :tabe config/routes.rb

" tmux
" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users
if exists('$TMUX')
  let &t_SI = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[0 q"
endif

" Local config
if filereadable(".vimrc.local")
  source .vimrc.local
endif
