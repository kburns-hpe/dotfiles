set colorcolumn=80 " Shows where 80 characters is
set ignorecase smartcase " enable case insensitive searching
set iskeyword+=_,$,@,%,# " set additioanl keywords for navigation purposes
set lazyredraw " Only redraw the screen when required
set linebreak " only wrap lines at a breakat
set number " Enable line number in gutter
set relativenumber " Enables relative numbers for column
set numberwidth=4 " Sets numbered column width
set ruler " show rule in bottom right (ROW, COL)
set showmatch " highlight matching brackets
set vb t_vb= "Disable visual bell
set wrap " Autowrap lines that hit end of screen
set tabstop=2 " Set a tab to be X spaces in width
set shiftwidth=2 " Sets how many spaces to move line when using <<, >>
set expandtab " Use spaces instead of a tab
set hidden " Allow switching buffers without saving first
set mouse= " Disable mouse support
syntax on " enable syntax highlighting
filetype plugin indent on " Enable indent based on filetype
set termguicolors " enable true color
set grepprg=rg\ --vimgrep " Use ripgrep for grep

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

" Use regular number in normal and relative in other modes
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" Map %% as %:h for ease of use
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Set w!! to write to file as root
cmap w!! w !sudo tee > /dev/null %

" Change ZZ and ZQ to quit all buffers instead of just the current one
map ZZ :wqa<CR>
map ZQ :qa<CR>
map <C-s> :w<CR>

" Change leader from \ to Space
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

" Copy/Paste
map <leader>c "+y
map <leader>p "+p
map <leader>P "+P

" Reformat paragrahs
vmap Q gq
nmap Q gqap

" Buffer shortcuts
nnoremap <C-Left> :bprevious<CR>
nnoremap <C-Right> :bnext<CR>
nnoremap <Tab> :bnext<CR>
nnoremap <bs> :bprevious<CR>
nnoremap <leader>d :bd<CR>
nnoremap <Leader>wd :pclose<CR>

" Make splits easier to switch to
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" Open new splits to the right and bottom
set splitbelow
set splitright

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

" reload nvim init.vim
nnoremap <Leader>r :source $MYVIMRC<CR>

" Automatically jump to the end of a yank or paste.
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

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

" Set filetype specific settings
augroup puppet
    au!
    autocmd FileType puppet set colorcolumn=140
augroup END

" Install Plugins
call plug#begin('~/.config/nvim/plugged')
" cobalt2 - color theme
Plug 'herrbischoff/cobalt2.vim'
" fzf - fuzzy searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
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
" dash.vim - Call Dash from within vim
Plug 'rizzatti/dash.vim'
" supertab - Manage tab for completion
Plug 'ervandew/supertab'
" vim-unimpaired - adds shortcuts for managing pair mappings
Plug 'tpope/vim-unimpaired'
" python-mode provides utilities to help code python
Plug 'python-mode/python-mode'
" notational-fzf-vim - Easier way to search notes
Plug 'https://github.com/Alok/notational-fzf-vim'
" vim-diff-enhanced - improve vimdiff
Plug 'chrisbra/vim-diff-enhanced'
" vim-commentary - comment stuff out
Plug 'tpope/vim-commentary'
" vim-better-whitespace - whitespace highlighe:
Plug 'ntpeters/vim-better-whitespace'
" neoformat - code formatter
Plug 'sbdchd/neoformat'
" vim-eunuch - Add some unix commands to vim
Plug 'tpope/vim-eunuch'
" vim-coffe-script - adds support for coffee script
Plug 'kchmck/vim-coffee-script'
" vimux - Interact with tmux from within vim
Plug 'benmills/vimux'
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

" Override shellcheck to force it to use -x
let g:neomake_sh_shellcheck_maker = {
  \ 'exe': 'shellcheck',
  \ 'args': ['-fgcc', '-x' ],
  \ 'errorformat':
    \ '%f:%l:%c: %trror: %m,' .
    \ '%f:%l:%c: %tarning: %m,' .
    \ '%f:%l:%c: %tote: %m'
  \ }

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>L :TestLast<CR>
nmap <silent> <leader>v :TestVisit<CR>
let test#strategy = "vimux"

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
let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" Fugitive
nmap <leader>ga :Gwrite<cr>
nmap <leader>gb :Gblame<cr>
nmap <leader>gc :Gcommit -v<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>ge :Gedit<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gp :Gpush origin HEAD<cr>
nmap <leader>gs :Gstatus<cr><c-w>K

" diff merge shortcuts
nmap <leader>1 :diffput 1<cr>:diffupdate<cr>
nmap <leader>2 :diffget 2<cr>:diffupdate<cr>
nmap <leader>3 :diffget 3<cr>:diffupdate<cr>

" Show DiffGitCached when running git commit
autocmd FileType gitcommit if ! &previewwindow && expand('%:t') !~# 'index' | :DiffGitCached | wincmd j | :res +10 | wincmd k | endif

" notational-fzf-vim
let g:nv_directories = ['~/Dropbox/notes']
let g:nv_default_extension = '.md'
let g:nv_use_short_pathnames = 1
let g:nv_show_preview = 0
map <leader>nv :NV<cr>

" vim-jekyll
let g:jekyll_post_extension = '.md'

" fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --glob "!.gitkeep"'
map <leader>fa :Ag<cr>
map <leader>fb :BLines<cr>
map <leader>fl :Lines<cr>
map <leader>ff :Files<cr>
map <leader>fg :GFiles<cr>

" limelight
map <F3> :Limelight!!<cr>

" deoplete
let g:deoplete#auto_complete_start_length = 4
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
let g:deoplete#sources#jedi#show_docstring = 1
map <F9> :call deoplete#toggle()<cr>"

" python-mode
let g:pymode_breakpoint = 1
let g:pymode_folding = 0
let g:pymode_indent = 1
let g:pymode_lint = 0
let g:pymode_lint_on_write = 0
let g:pymode_motion = 1
let g:pymode_rope = 0
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_completion = 0
let g:pymode_run = 1
let g:pymode_options_max_line_length = 99
let g:pymode_options_colorcolumn = 1

" gitgutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

" vim-diff-enhanced
if &diff
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

" vim-better-whitespace
autocmd BufEnter * EnableStripWhitespaceOnSave

" neoformat"
map <leader>nf :Neoformat<cr>

" vim-indent-guides
let g:indent_guides_start_level = 2
let g:indent_guides_guide_size = 1
let g:indent_guides_enable_on_vim_startup=1
