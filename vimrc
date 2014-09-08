" Pathogen {{{
call pathogen#infect() " load plugins under ./vim/bundle.
call pathogen#helptags() " generate documentation from ./vim/bundle/*/doc.
" }}}

" Leader keys {{{
let mapleader = ","
let maplocalleader = "\\"
" }}}

" General settings {{{
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible
set backspace=indent,eol,start " allow backspacing over everything in insert mode
set history=50 " keep 50 lines of command line history
set ruler " show the cursor position all the time
set showcmd " show command in bottom bar
set encoding=utf-8
set scrolloff=3
set showmode
set hidden
set wildmenu " visual autocomplete for command menu
set lazyredraw " redraw only when we need to
set ttyfast
set visualbell " display error bells visually
set list listchars=tab:»·,trail:· " display extra whitespace
set cursorline " highlight current line

" https://github.com/jeffkreeftmeijer/vim-numbertoggle
set nonumber
set relativenumber
set numberwidth=5

" http://stackoverflow.com/questions/2514445/turning-off-auto-indent-when-pasting-text-into-vim
set pastetoggle=<F10>
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
colorscheme solarized
call togglebg#map("<F6>")

" Add installed colorschemes here. See NextColor() function.
let s:my_colors = ['solarized', 'badwolf']
" }}}

" Spaces and tabs {{{
set tabstop=2 " number of visual spaces per TAB
set softtabstop=2 " number of spaces in tab when editing
set expandtab " tabs are spaces
set shiftwidth=2
" }}}

" Status line {{{
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
" }}}

" Search {{{
set ignorecase
set smartcase
set incsearch " search as characters are entered
set showmatch
set hlsearch " highlight all matches
nnoremap <Leader><Space> :noh<CR> " hide search highlighting

" Disable VIM's broken default regex
nnoremap / /\v
vnoremap / /\v
" }}}

" Completion {{{
set wildmode=list:longest,list:full " tab completion options
set complete=.,t
imap <Tab> <C-P> " map autocomplete to tab
" }}}

" Folding {{{
set nofoldenable " don't fold files by default on open
set foldmethod=indent " fold based on indent level
set foldlevelstart=99 " start with fold level of 99
nnoremap <space> za
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
set spelllang=en_us " set region to US English
nnoremap <leader>ss :setlocal spell!<CR>
nnoremap <leader>sn ]s " go to next error
nnoremap <leader>sp [s " got to previous error
nnoremap <leader>ss z= " show suggestions
nnoremap <leader>sl 1z= " feeling lucky
" }}}

" Shortcuts {{{
" Edit .vimrc
nnoremap <Leader>evi :vsplit $MYVIMRC<CR> " edit .vimrc file in vertical window
nnoremap <Leader>svi :source $MYVIMRC<CR> " reload .vimrc

" Navigation
nnoremap <C-J> gj " move one unnumbered line down
nnoremap <C-K> gk " move one unnumbered line up
nnoremap <C-Tab> <C-W><C-W> " cycle through windows
nnoremap gV `[v`] " highlight last inserted text

" Open an edit command with the path of the currently edited file filled in
" http://vimcasts.org/episodes/the-edit-command/
cnoremap %% <C-R>=expand('%:p:h').'/'<CR>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Useful mappings for managing tabs
map <leader>tn :tabnew<CR>
map <leader>to :tabonly<CR>
map <leader>tc :tabclose<CR>
map <leader>tm :tabmove
map <leader>te :tabedit <C-R>=expand("%:p:h")<CR>/ " open a new tab with the current buffer's path

" Change current directory to the file being edited
nnoremap <Leader>cd :cd %:p:h<CR>:pwd<CR>

" Insert the path of the currently edited file into a command
cmap <C-P> <C-R>=expand("%:p:h") . "/" <CR>

vmap D y'>p " Duplicate a selection in visual mode
nmap <F1> <Esc> " disable F1 Help

" Convert one-line comment into end-of-line comment
nnoremap <Leader>dp ddpkJ

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

" Functions {{{
function! NextColor()
  if exists('g:colors_name')
    let current = index(s:my_colors, g:colors_name)
  else
    let current = -1
  endif
  let missing = []
  let new_color = current + 1
  if new_color >= len(s:my_colors) " wrap around array
    let new_color = 0
  endif
  try
    execute 'colorscheme '.s:my_colors[new_color]
    if new_color == 'badwolf'
      let g:badwolf_darkgutter = 1
      let g:badwolf_tabline = 2
    endif
  catch /E185:/
    call add(missing, s:my_colors[new_color])
  endtry
  redraw
  echom 'Switched to colorscheme' s:my_colors[new_color]
  if len(missing) > 0
    echom 'Error: colorscheme not found:' join(missing)
  endif
endfunction
nnoremap <F5> :call NextColor()<CR>

" http://lanyrd.com/2011/madison-ruby/sgtmd/
function! RubyInfo()
  ruby << RUBY
    puts "#{RUBY_VERSION} #{RUBY_PLATFORM} #{RUBY_RELEASE_DATE}"
RUBY
endfunction
" }}}

" Autogroups {{{
" Only do this part when compiled with support for autocommands
if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily
  augroup global
    autocmd!
    autocmd FileType text setlocal textwidth=78 " for all text files set 'textwidth' to 78 characters

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    autocmd BufReadPost *
      \ if line("'\"") > 0 && line("'\"") <= line("$") |
      \   exe "normal g`\"" |
      \ endif

    " Auto reload of vimrc
    " http://www.bestofvim.com/tip/auto-reload-your-vimrc/
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
  augroup END

  augroup programming
    autocmd!
    autocmd BufEnter Makefile setlocal noexpandtab
    autocmd BufEnter *.sh setlocal tabstop=2
    autocmd BufEnter *.sh setlocal shiftwidth=2
    autocmd BufEnter *.sh setlocal softtabstop=2

    " Easy commenting
    autocmd FileType ruby nnoremap <buffer> <localleader>c I#<ESC>
    autocmd FileType python nnoremap <buffer> <localleader>c I#

    " Use .as for ActionScript files, not Atlas files.
    autocmd BufRead,BufNewFile *.as setlocal filetype=actionscript
  augroup END
else
  set autoindent " always set autoindenting on
endif
" }}}

" File management plugins {{{
" NERDTree
nnoremap <Leader>n :NERDTree<CR>

" CtrlP
let g:ctrlp_map = '<C-P>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$'
  \ }

" BufExplorer
let g:bufExplorerShowTabBuffer=1 " only show buffers for current tab
" }}}

" Ack plugin {{{
nnoremap <Leader>a :Ack
" Use Ack instead of Grep when available
if executable("ack")
  set grepprg=ack\ -H\ --nogroup\ --nocolor
endif
" }}}

" Rails  plugin {{{
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
" }}}

" Tmux {{{
" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users
if exists('$TMUX')
  let &t_SI = "\<Esc>[3 q"
  let &t_EI = "\<Esc>[0 q"
endif
" }}}

" Local config {{{
if filereadable($HOME . "/.vimrc.local")
  source $HOME/.vimrc.local
endif
" }}}

" http://www.cs.swarthmore.edu/help/vim/modelines.html
set modelines=1
" vim:foldenable:foldmethod=marker:foldlevel=0
