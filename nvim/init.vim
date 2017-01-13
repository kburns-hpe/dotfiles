set autochdir " Auto change windows CWD to the file's directory
set colorcolumn=80 " Shows where 80 characters is
set ignorecase smartcase " enable case insensitive searching
set iskeyword+=_,$,@,%,# " set additioanl keywords for navigation purposes
set linebreak " only wrap lines at a breakat
set number " Enable line number in gutter
set relativenumber " Enables relative numbers for column
set numberwidth=4 " Sets numbered column width
set ruler " show rule in bottom right (ROW, COL)
set showmatch " highlight matching brackets
set vb t_vb= "Disable visual bell
set wrap " Autowrap lines that hit end of screen
set tabstop=4 " Set a tab to be 4 spaces in width
set shiftwidth=4 " Sets how many spaces to move line when using <<, >>
set expandtab " Use spaces instead of a tab
set hidden " Allow switching buffers without saving first
set mouse= " Disable mouse support
syntax on " enable syntax highlighting
filetype plugin indent on " Enable indent based on filetype
set termguicolors " enable true color

" Disable autocomplete of comments on new lines
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

" Set the terminal title bar to the full path of the open file
autocmd BufEnter * let &titlestring = 'nvim - ' . expand("%:p")
set title

" Rename tmux window title to current file
if exists('$TMUX')
    autocmd BufEnter * call system("tmux rename-window '" . expand("%:t") . "'")
    autocmd VimLeave * call system("tmux setw automatic-rename")
endif

" Setup backups
set backup
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/tmp

" Enable per file undos that are kept after quitting
set undodir=~/.config/nvim/undo
set undofile
set undolevels=1000
set undoreload=10000

" Change ZZ to quit all buffers instead of just the current one
map ZZ :wqa<CR>

" Change leader from \ to Space
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

" Copy to X CLIPBOARD
map <leader>cb "+y
map <leader>cp "*y
map <leader>cs :w !xsel -i -s<CR>
" Paste from X CLIPBOARD
map <leader>pp "*p
map <leader>ps :r!xsel -s<CR>
map <leader>pb "+p
map <leader>Pp "*P
map <leader>Pb "+P

" Reformat paragrahs
vmap Q gq
nmap Q gqap

" Buffer shortcuts
nnoremap <C-Left> :bprevious<CR>
nnoremap <C-Right> :bnext<CR>
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>d :bd<CR>
nnoremap <Leader>1 :1b<CR>
nnoremap <Leader>2 :2b<CR>
nnoremap <Leader>3 :3b<CR>
nnoremap <Leader>4 :4b<CR>
nnoremap <Leader>5 :5b<CR>
nnoremap <Leader>6 :6b<CR>
nnoremap <Leader>7 :7b<CR>
nnoremap <Leader>8 :8b<CR>
nnoremap <Leader>9 :9b<CR>
nnoremap <Leader>0 :10b<CR>

" Make splits easier to switch to
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <Tab> <c-w>w
nnoremap <bs> <c-w>W

" Open new splits to the right and bottom
set splitbelow
set splitright

" Shortcut to delete trailing white space
nnoremap <Leader>rtw :%s/\s\+$//e<CR>

" Bind F2 to enable/disable paste mode
set pastetoggle=<F2>

" This lets escape clear the search highlights
map <F4> :noh<CR>:<backspace>
imap <F4> <C-o>:noh<CR><C-o>:<backspace>

" Toggle showing invisible characters
noremap <F8> :set list!<CR>
inoremap <F8> <C-o>:set list!<CR>
cnoremap <F8> <C-c>:set list!<CR>

" setup spell checking
set spelllang=en
set spellsuggest=5
map <F7> :setlocal spell!<CR>
imap <F7> <C-o>:setlocal spell!<CR>

" nerdtree
map <leader>n :NERDTreeToggle<CR>

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeQuitOnOpen=1

" Automatically jump to the end of a yank or paste.
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" This command will sort ip addresses correctly.
command SORTIP %!sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4 | uniq

" rename window to current file
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))

" Toggle relative line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

nnoremap <F5> :call NumberToggle()<cr>
inoremap <F5> <C-o>:call NumberToggle()<cr>

" Toggle List windows
function! GetBufferList()
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx)
  let buflist = GetBufferList()
  for bufnum in map(filter(split(buflist, '\n'), 'v:val =~ "'.a:bufname.'"'), 'str2nr(matchstr(v:val, "\\d\\+"))')
    if bufwinnr(bufnum) != -1
      exec(a:pfx.'close')
      return
    endif
  endfor
  if a:pfx == 'l' && len(getloclist(0)) == 0
      echohl ErrorMsg
      echo "Location List is Empty."
      return
  endif
  let winnr = winnr()
  exec(a:pfx.'open')
  if winnr() != winnr
    wincmd p
  endif
endfunction

nmap <silent> <leader>wl :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>we :call ToggleList("Quickfix List", 'c')<CR>

" Install Plugins
call plug#begin('~/.config/nvim/plugged')
" cobalt2 - color theme
Plug 'herrbischoff/cobalt2.vim'
" fzf - fuzzy searching
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
" limelight - hyperfocus-writing in vim
Plug 'junegunn/limelight.vim'
" fugitive - git plugin
Plug 'tpope/vim-fugitive'
" Lightline - configurable statusline/tabline
Plug 'itchyny/lightline.vim'
" vim-surround - implements the ability to change surroundings easier
Plug 'tpope/vim-surround'
" gundo - visualize undo tree
Plug 'sjl/gundo.vim'
" UltiSnips - snippet plugin
Plug 'SirVer/ultisnips'
" targets.vim - Adds additional targets to operate on
Plug 'wellle/targets.vim'
" Git gutter - shows git information on the side
Plug 'airblade/vim-gitgutter'
" vim-easymotion - Simpler way to move around vim
Plug 'Lokaltog/vim-easymotion'
" tabular - text aligning
Plug 'godlygeek/tabular'
" vim-indent-guides - Show indents
Plug 'nathanaelkane/vim-indent-guides'
" vim-repeat - Fixes . for some plugins
Plug 'tpope/vim-repeat'
" vim-rsi - adds some readline shortcuts
Plug 'tpope/vim-rsi'
" vim - puppelabs vim syntax
Plug 'rodjek/vim-puppet'
" splitjoin - an easy way to split/join lines
Plug 'AndrewRadev/splitjoin.vim'
" neomake - linter
Plug 'benekastah/neomake'
" vim-test - used to run various test suites
Plug 'janko-m/vim-test'
" deoplete - autocompletion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" deoplete-jedi - python auto complete using jedi
Plug 'zchee/deoplete-jedi'
" zeavim - embed zeal search
Plug 'KabbAmine/zeavim.vim'
" vim-jekyll - Jekyll management plugin
Plug 'parkr/vim-jekyll'
" vim-multiple-cursors - multiple cursors
Plug 'terryma/vim-multiple-cursors/'
" vim-bufferline - lists buffers
Plug 'bling/vim-bufferline'
" nerdtree - provides a file tree for selecting files
Plug 'scrooloose/nerdtree'
" dash.vim - Call Dash from within vim
Plug 'rizzatti/dash.vim'
" supertab - Manage tab for completion
Plug 'ervandew/supertab'
" TaskList - searches code for FIXME, TODO, and XXX
"Plug 'vim-scripts/TaskList.vim'
" ropevim - python refactoring and code assist
"Plug 'python-rope/ropevim'
" pydoc - Pydoc searching plugin
"Plug 'fs111/pydoc.vim'
" vim-markdown - Better markdown syntax highlighting
"Plug 'tpope/vim-markdown'
" vim-chef - chef syntax highlighting and autocomplete snipmate
"Plug 'vadv/vim-chef'
" nerdcommenter - provides shortcuts for dealing with comments
" Bundle 'scrooloose/nerdcommenter'
call plug#end()

" Plugin Specific Configurations

" cobalt2
colorscheme cobalt2


" Neomake
autocmd! BufWritePost,BufReadPost * Neomake
nnoremap <F11> :Neomake <CR>
inoremap <F11> <C-o>:Neomake <CR>

let g:neomake_open_list = 2
let g:neomake_list_height = 5

" Override puppet lint to ignore things I don't care about
let g:neomake_puppet_puppetlint_maker = {
    \ 'exe': 'puppet-lint',
    \ 'args': ['--log-format', 
    \          '"%{path}:%{line}:%{column}:%{kind}:[%{check}] %{message}"',
    \          '--no-quoted_booleans-check',
    \          '--no-class_inherits_from_params_class-check',
    \          '--no-puppet_url_without_modules-check' ],
    \ 'errorformat': '"%f:%l:%c:%t%*[a-zA-Z]:%m"',
    \ }


" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>L :TestLast<CR>
nmap <silent> <leader>v :TestVisit<CR>

let test#strategy = "neovim"


" lightline
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive'],[ 'bufferline' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'filetype' ],
      \            [ 'neomake' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LLFugitive',
      \   'readonly': 'LLReadonly',
      \   'modified': 'LLModified',
      \   'mode': 'LLMode',
      \   'bufferline': 'MyBufferLine',
      \   'neomake': 'neomake#statusline#LoclistStatus'
      \ },
      \ 'component_type': {
      \   'neomake': 'error',
      \ }
      \ }

function! LLMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == '__Gundo__' ? 'Gundo' :
        \ fname == '__Gundo_Preview__' ? 'Gundo Preview' :
        \ fname =~ 'NERD_tree' ? 'NERDTree' :
        \ lightline#mode() == 'NORMAL' ? 'N' :
        \ lightline#mode() == 'INSERT' ? 'I' :
        \ lightline#mode() == 'VISUAL' ? 'V' :
        \ lightline#mode() == 'V-LINE' ? 'V' :
        \ lightline#mode() == 'V-BLOCK' ? 'V' :
        \ lightline#mode() == 'REPLACE' ? 'R' : lightline#mode()
endfunction

function! LLModified()
  if &filetype == "help"
    return ""
  elseif &modified
    return "+"
  elseif &modifiable
    return ""
  else
    return ""
  endif
endfunction

function! LLReadonly()
  if &filetype == "help"
    return ""
  elseif &readonly
    return "!"
  else
    return ""
  endif
endfunction

function! LLFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! MyBufferLine()
  let st=g:bufferline#refresh_status()
  return g:bufferline_status_info.before . g:bufferline_status_info.current . g:bufferline_status_info.after
endfunction

set laststatus=2
set noshowmode

" Gundo
nnoremap <F6> :GundoToggle<CR>

" UltiSnips
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Fugitive
nmap <leader>ga :Gwrite<cr>
nmap <leader>gb :Gblame<cr>
nmap <leader>gc :Gcommit<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>ge :Gedit<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gp :Gpush<cr>
nmap <leader>gs :Gstatus<cr>

" easymotion

" map s to be single character easymotion search
nmap s <Plug>(easymotion-s2)

" Setup easy motion line changes
map <Leader>l <Plug>(easymotion-lineforward)
map <Leader>h <Plug>(easymotion-linebackward)
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

" Setup easymotion to be used for the / find
map  / <Plug>(easymotion-sn)
omap / <Plug>(easymotion-tn)
map  n <Plug>(easymotion-next)
map  N <Plug>(easymotion-prev)

" Bidirectional & within line 't' motion
omap t <Plug>(easymotion-bd-tl)
" Use uppercase target labels and type as a lower case
let g:EasyMotion_use_upper = 1
 " type `l` and match `l`&`L`
let g:EasyMotion_smartcase = 1
" Smartsign (type `3` and match `3`&`#`)
let g:EasyMotion_use_smartsign_us = 1

let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
let g:EasyMotion_smartcase = 1

" vim-pad
let g:pad#dir = "~/Dropbox/nvdata"

" vim-jekyll

let g:jekyll_post_extension = '.md'

" fzf
let $FZF_DEFAULT_COMMAND = 'ag -l -g ""'
map <leader>fa :Ag<cr>
map <leader>fb :BLines<cr>
map <leader>fl :Lines<cr>
map <leader>ff :call FzfOmniFiles()<cr>

function! FzfOmniFiles()
    let is_git = system('git status')
    if v:shell_error
        :Files
    else
        :GFiles --exclude-standard
    endif
endfunction

" limelight
map <F3> :Limelight!!<cr>

" deoplete
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#sources#jedi#show_docstring = 1
