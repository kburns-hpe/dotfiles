""" BASIC SETTINGS
set hidden " Allow switching buffers without saving first
set mouse= " Disable mouse support
set grepprg=rg\ --vimgrep " Use rg for grep

" Backup configuration
set backup
set backupdir=~/.config/nvim/backup
set directory=~/.config/nvim/tmp

" Indenting
filetype plugin indent on
set autoindent

" Folding
set foldlevelstart=99
set foldmethod=syntax

" Searching
set ignorecase smartcase
set showmatch

" Speed up vim
let g:matchparen_insert_timeout = 20
let g:matchparen_timeout = 20
set nocursorline

" SpellCheck
set spelllang=en
set spellsuggest=5

" Split configs
set splitbelow
set splitright

" Tab settings
set expandtab
set shiftwidth=2
set softtabstop=2

" Text Wrapping
set linebreak
set wrap

" Undo settings
set undodir=~/.config/nvim/undo
set undofile
set undolevels=1000
set undoreload=10000

" Visual Settings
set termguicolors

""" PLUGIN SECTION

call plug#begin('~/.config/nvim/plugged')

" Autocompletion
Plug 'ncm2/ncm2'
Plug 'ncm2/ncm2-go'
Plug 'ncm2/ncm2-jedi'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'roxma/nvim-yarp'

" Color Scheme
Plug 'herrbischoff/cobalt2.vim'

" ctags
Plug 'ludovicchabant/vim-gutentags'

" Documentation
Plug 'sunaku/vim-dasht'

" Formatting
Plug 'sbdchd/neoformat'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language-Specific
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sheerun/vim-polyglot'

" Linter
Plug 'w0rp/ale'

" Lightline
Plug 'bling/vim-bufferline'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'ryanoasis/vim-devicons'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Movement
Plug 'justinmk/vim-sneak'

" Notes
Plug 'https://github.com/Alok/notational-fzf-vim'

" Snippets
Plug 'SirVer/ultisnips'

" Tmux-specific plugins
if exists('$TMUX')
  Plug 'christoomey/vim-tmux-navigator'
endif

" Utility
Plug 'chrisbra/vim-diff-enhanced'
Plug 'ervandew/supertab'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'
Plug 'michaeljsmith/vim-indent-object'
Plug 'chaoren/vim-wordmotion'

call plug#end()

""" AUTOCMD

" Rename tmux window title to current file
if exists('$TMUX')
  augroup tmux
    autocmd!
    autocmd BufEnter,BufNewFile,BufReadPost,FileReadPost * call system("tmux rename-window " . expand("%:t"))
    autocmd VimLeave * call system("tmux setw automatic-rename")
  augroup end
endif

" Show DiffGitCached when running git commit
augroup DiffGit
  autocmd!
  autocmd FileType gitcommit if ! &previewwindow && expand('%:t') !~# 'index' | :DiffGitCached | wincmd k | :res -100 | :res +4 | endif
augroup end

" Enable file specific settings
augroup FiletypeGroup
    autocmd!
    autocmd BufRead,BufNewFile *.yml set filetype=ansible.yaml
    autocmd BufRead,BufNewFile *.rb if expand('%:p:h:t') == "recipes" | set filetype=ruby.chef | endif
augroup END

" Misc autocmd grouping
augroup Misc
  autocmd!
  autocmd User ALELint call lightline#update()
  autocmd BufEnter * call ncm2#enable_for_buffer()
  autocmd FileType * setlocal formatoptions-=r formatoptions-=o
augroup end

""" FUNCTIONS

" Toggle List windows
function! GetBufferList() abort
  redir =>buflist
  silent! ls!
  redir END
  return buflist
endfunction

function! ToggleList(bufname, pfx) abort
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

" Toggle relative line numbers
function! NumberToggle() abort
  if(&number == 1)
    set nonumber
  else
    set number
  endif
endfunc

" Toggle completion
let s:ncm2Enabled = 1
function! ToggleCompletion() abort
    if s:ncm2Enabled
      call ncm2#disable_for_buffer()
      let s:ncm2Enabled = 0
    else
      call ncm2#enable_for_buffer()
      let s:ncm2Enabled = 1
    endif
endfunction

"""" lightline functions

function! LightlineLinterErrors() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d >>', all_errors)
endfunction

function! LightlineLinterOK() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '✓' : ''
endfunction

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d --', all_non_errors)
endfunction

function! LLMode() abort
  let fname = expand('%:t')
  return lightline#mode() == 'NORMAL' ? 'N' :
  \ lightline#mode() == 'INSERT' ? 'I' :
  \ lightline#mode() == 'VISUAL' ? 'V' :
  \ lightline#mode() == 'V-LINE' ? 'V' :
  \ lightline#mode() == 'V-BLOCK' ? 'V' :
  \ lightline#mode() == 'REPLACE' ? 'R' : lightline#mode()
endfunction

function! LLModified() abort
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

function! LLReadonly() abort
  if &filetype == "help"
    return ""
  elseif &readonly
    return "!"
  else
    return ""
  endif
endfunction

function! LLFugitive() abort
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

function! MyBufferLine() abort
  let st=g:bufferline#refresh_status()
  return g:bufferline_status_info.before . g:bufferline_status_info.current . g:bufferline_status_info.after
endfunction

function! MyFiletype() abort
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

""" MAPPINGS

" Set space as leader
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

"""" Misc Mappings
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

"""" Alt Mappings
nnoremap <A-]> :vsp<CR>:exec("tag ".expand("<cword>"))<CR>q

"""" Ctrl Mappings
nnoremap <C-H> <C-W><C-H>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
inoremap <C-s> <Esc>:w<CR>
nnoremap <C-s> :w<CR>

"""" Function Key Mappings
set pastetoggle=<F2>
inoremap <F3> <C-o>:TagbarToggle<CR>
nnoremap <F3> :TagbarToggle<CR>
inoremap <F4> <C-o>:noh<CR><C-o>:<backspace>
nnoremap <F4> :noh<CR>:<backspace>
inoremap <F5> <C-o>:call NumberToggle()<cr>
nnoremap <F5> :call NumberToggle()<cr>
inoremap <F7> <C-o>:setlocal spell!<CR>
nnoremap <F7> :setlocal spell!<CR>
cnoremap <F8> <C-c>:set list!<CR>
inoremap <F8> <C-o>:set list!<CR>
nnoremap <F8> :set list!<CR>
inoremap <F9> <C-o>:call ToggleCompletion()<cr>
nnoremap <F9> :call ToggleCompletion()<cr>

"""" Leader Mappings
nnoremap <leader>' <C-w>s
nnoremap <leader>; <C-w>v
nnoremap <leader>1 :diffput 1<cr>:diffupdate<cr>
nnoremap <leader>2 :diffget 2<cr>:diffupdate<cr>
nnoremap <leader>3 :diffget 3<cr>:diffupdate<cr>
nnoremap <leader>P "+P
nnoremap <leader>c "+y
nnoremap <leader>d :bd<CR>
nnoremap <leader>fa :Ag<cr>
nnoremap <leader>fb :BLines<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fg :GFiles<cr>
nnoremap <leader>fl :Lines<cr>
nnoremap <leader>fs :Snippets<cr>
nnoremap <leader>ft :BTags<cr>
nnoremap <leader>fT :Tags<cr>
nnoremap <leader>ga :Gwrite<cr>
nnoremap <leader>gb :Gblame<cr>
nnoremap <leader>gc :Gcommit -v<cr>
nnoremap <leader>gd :Gdiff<cr>
nnoremap <leader>ge :Gedit<cr>
nnoremap <leader>gl :Glog<cr>
nnoremap <leader>gp :Gpush origin HEAD<cr>
nnoremap <leader>gr :Gread<cr>
nnoremap <leader>gs :Gstatus<cr><c-w>
nnoremap <leader>nf :Neoformat<cr>
nnoremap <leader>nv :NV<cr>
nnoremap <leader>p "+p
nnoremap <leader>q <C-w>q
nnoremap <leader>r :source $MYVIMRC<CR>
nnoremap <leader>wd :pclose<CR>
nnoremap <silent> <leader>we :call ToggleList("Quickfix List", 'c')<CR>
nnoremap <silent> <leader>wl :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>
vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>
nnoremap <silent> <leader>Q vapJgqap

"""" Leader Leader Mappings
nnoremap <leader><Leader>k :Dasht!<Space>
nnoremap <silent> <leader><leader>tg :GoTestFunc<CR>
nnoremap <silent> <Leader><Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')], '!')<Return>
vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>

"""" Regular Mappings
nnoremap <silent> Q gqap
nnoremap <silent> p p`]
vnoremap <silent> p p`]
vnoremap <silent> y y`]
xnoremap <silent> Q gq
nnoremap ZQ :qa<CR>
nnoremap ZZ :wqa<CR>
nnoremap [h <Plug>GitGutterPrevHunk
nnoremap ]h <Plug>GitGutterNextHunk

""" COLORS
augroup MyColors
    autocmd!
autocmd ColorScheme * highlight GitGutterAdd guifg=#3ad900 ctermfg=2
                  \ | highlight GitGutterChange guifg=#ffc600 ctermfg=3
                  \ | highlight GitGutterDelete guifg=#ff2600 ctermfg=1
augroup end
colorscheme cobalt2

""" PLUGIN SPECIFIC SETTINGS

"""" ctags
let g:gutentags_cache_dir = "~/.config/nvim/tags"
"""" fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --glob "!.gitkeep"'

"""" lightline
let g:lightline = {
  \ 'colorscheme': 'cobalt2',
  \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'fugitive'],[ 'bufferline' ] ],
    \ 'right': [ [ 'lineinfo' ],
    \            [ 'percent' ],
    \            [ 'linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok' ],
    \            [ 'filetype' ] ]
  \ },
  \ 'component_function': {
    \   'fugitive': 'LLFugitive',
    \   'readonly': 'LLReadonly',
    \   'modified': 'LLModified',
    \   'mode': 'LLMode',
    \   'bufferline': 'MyBufferLine',
    \   'filetype': 'MyFiletype',
  \ },
  \ 'component_expand': {
  \  'linter_checking': 'lightline#ale#checking',
  \  'linter_warnings': 'lightline#ale#warnings',
  \  'linter_errors': 'lightline#ale#errors',
  \  'linter_ok': 'lightline#ale#ok',
  \ },
  \ 'component_type': {
  \     'linter_checking': 'left',
  \     'linter_warnings': 'warning',
  \     'linter_errors': 'error',
  \     'linter_ok': 'left',
  \ }
\ }

set laststatus=2
set noshowmode
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"


"""" lion
let b:lion_squeeze_spaces = 1

"""" ncm2
set shortmess+=c
set completeopt=noinsert,menuone,noselect

"""" notational-fzf-vim
let g:nv_search_paths = ['~/Dropbox/notes']
let g:nv_default_extension = '.md'
let g:nv_use_short_pathnames = 1
let g:nv_show_preview = 0

"""" ultisnips
let g:UltiSnipsSnippetsDir="~/.config/nvim/UltiSnips"
let g:UltiSnipsEditSplit="horizontal"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

"""" vim-diff-enhanced
if &diff
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

"""" vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

""" END

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

" vim:fdm=expr:fdl=0
" vim:fde=getline(v\:lnum)=~'^""'?'>'.(matchend(getline(v\:lnum),'""*')-2)\:'='
