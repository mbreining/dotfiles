" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:

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
set foldlevel=99 " do not fold by default

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
" zR: open all
" zM: close all

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
nnoremap <leader>s :w<cr>
inoremap <leader>s <esc>:w<cr>a

" Quickfix toggle
nnoremap <leader>q :call QuickfixToggle()<cr>

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
filetype plugin indent on

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
  call minpac#add('qpkorr/vim-bufkill') " C-x
  call minpac#add('tpope/vim-surround') " cs, ds, yss, ysiw
  call minpac#add('tpope/vim-repeat') " .
  call minpac#add('tpope/vim-fugitive') " :Git, :G
  call minpac#add('tomtom/tcomment_vim') " gcc, gc<movement>
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

  " markdown
  call minpac#add('godlygeek/tabular')
  call minpac#add('preservim/vim-markdown')

  " python
  call minpac#add('klen/python-mode')

  " terraform
  call minpac#add('hashivim/vim-terraform')

  " code snippets
  call minpac#add('honza/vim-snippets')
endfunction

command! PackUpdate source $MYVIMRC | call PackInit() | call minpac#update()
command! PackClean source $MYVIMRC | call PackInit() | call minpac#clean()
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
nnoremap <leader>cd :set background=dark<cr>
nnoremap <leader>cl :set background=light<cr>
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
" https://gist.github.com/danidiaz/37a69305e2ed3319bfff9631175c5d0f
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altfile = 1
nnoremap <C-n> :Explore<cr>
" }}}

" Fzf {{{
if isdirectory(expand("~/.vim/pack/minpac/start/fzf.vim"))
  nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<cr>"
  nnoremap <C-b> :Buffers<cr>
  nnoremap <C-a> :Ag<cr>
endif
" }}}

" vim-notes {{{
if isdirectory(expand("~/.vim/pack/minpac/start/vim-notes"))
  let g:notes_directories = ['~/notes']
  let g:notes_suffix = '.txt'
  nnoremap <leader>nn :Note<space>
  nnoremap <leader>nj :execute 'Note '.strftime('%Y-%m-%d')<cr>
  nnoremap <leader>ns :SearchNotes<space>
  nnoremap <leader>nd :DeleteNote<space>
endif
" }}}

" Coc {{{
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl <Plug>(coc-codelens-action)

" Map function and class text objects.
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" if has('nvim-0.4.0') || has('patch-8.2.0750')
"   nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"   inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"   inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
"   vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"   vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
" endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
" }}}

" python-mode {{{
let g:pymode_options_max_line_length = 100
" }}}

" python-mode {{{
let g:pymode_options_max_line_length = 100
" }}}

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
