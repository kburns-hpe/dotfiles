set ignorecase smartcase " enable case insensitive searching
set iskeyword+=_,$,@,%,# " set additioanl keywords for navigation purposes
set linebreak " only wrap lines at a breakat
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
set termguicolors " Enable truecolor support
syntax on " enable syntax highlighting
filetype plugin indent on " Enable indent based on filetype
set grepprg=rg\ --vimgrep " Use ripgrep for grep

" Test speed up stuff
set nocursorline
let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20

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

" Map %% as %:h for ease of use
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Set w!! to write to file as root
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Change ZZ and ZQ to quit all buffers instead of just the current one
map ZZ :wqa<CR>
map ZQ :qa<CR>

" Map ctrl-s in insert mode to move to normal mode and save the document
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>

" Change leader from \ to Space
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

" Copy/Paste
map <leader>c "+y
map <leader>p "+p
map <leader>P "+P

" Reformat paragrahs
nnoremap <silent> Q gqap
xnoremap <silent> Q gq
nnoremap <silent> <leader>Q vapJgqap

" Buffer shortcuts
nnoremap <C-Left> :bprevious<CR>
nnoremap <C-Right> :bnext<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <leader>d :bd<CR>
nnoremap <Leader>wd :pclose<CR>

" Make splits easier to switch to
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>; <C-w>v
nnoremap <leader>' <C-w>s
nnoremap <leader>q <C-w>q

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
  if(&number == 1)
    set nonumber
  else
    set number
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

" Open ctag in new vertical split
map <A-]> :vsp<CR>:exec("tag ".expand("<cword>"))<CR>q

" Install Plugins
call plug#begin('~/.config/nvim/plugged')
" cobalt2 - color theme
Plug 'herrbischoff/cobalt2.vim'
" tagbar
Plug 'majutsushi/tagbar'
" vim-easymotion - Simpler way to move around vim
Plug 'Lokaltog/vim-easymotion'
" fzf - fuzzy searching
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" fugitive - git plugin
Plug 'tpope/vim-fugitive'
" Git gutter - shows git information on the side
Plug 'airblade/vim-gitgutter'
" vim-surround - implements the ability to change surroundings easier
Plug 'tpope/vim-surround'
" UltiSnips - snippet plugin
Plug 'SirVer/ultisnips'
" targets.vim - Adds additional targets to operate on
Plug 'wellle/targets.vim'
" tabular - text aligning
Plug 'godlygeek/tabular'
" vim-repeat - Fixes . for some plugins
Plug 'tpope/vim-repeat'
" vim-rsi - adds some readline shortcuts
Plug 'tpope/vim-rsi'
" ale - Asynchronous Lint Engine
Plug 'w0rp/ale'
" vim-test - used to run various test suites
Plug 'janko-m/vim-test'
" ncm2 - autocompletion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-go'
" vim-bufferline - lists buffers
Plug 'bling/vim-bufferline'
" supertab - Manage tab for completion
Plug 'ervandew/supertab'
" vim-unimpaired - adds shortcuts for managing pair mappings
Plug 'tpope/vim-unimpaired'
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
" vim-obsession - Manages vim sessions
Plug 'tpope/vim-obsession'
" vim-polyglot - Provides support for multiple languages
Plug 'sheerun/vim-polyglot'
" Lightline - configurable statusline/tabline
Plug 'itchyny/lightline.vim'
" lightline-ale provides ale info in lightline
Plug 'maximbaz/lightline-ale'
" vim-devions - provides icons for filetypes
Plug 'ryanoasis/vim-devicons'
" notational-fzf-vim - Easier way to search notes
Plug 'https://github.com/Alok/notational-fzf-vim'

if exists('$TMUX')
  " vimux - Interact with tmux from within vim
  Plug 'benmills/vimux'
  " vim-tmux-navigator -  allows seamless switching between tmux and vim panes
  Plug 'christoomey/vim-tmux-navigator'
endif

if has('unix')
  " vim-dasht - dasht doc search
  Plug 'sunaku/vim-dasht'
  " vim-go - Adds support for go
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
endif
call plug#end()

" Plugin Specific Configurations

" cobalt2
colorscheme cobalt2

" ale
nmap <silent> <leader>j <Plug>(ale_previous_wrap)
nmap <silent> <leader>k <Plug>(ale_next_wrap)

" Enable yaml linter to run on ansible files
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.yml set filetype=ansible.yaml
augroup END

" vim-test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tv :TestVisit<CR>
let test#strategy = "vimux"

" vimux
nmap <Leader>vp :VimuxPromptCommand<CR>
nmap <Leader>vl :VimuxRunLastCommand<CR>
nmap <Leader>vi :VimuxInspectRunner<CR>
nmap <Leader>vz :VimuxZoomRunner<CR>

" lightline
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

" vim-devions + lightline
function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

" ale + lightline
autocmd User ALELint call lightline#update()

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d --', all_non_errors)
endfunction

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

" lightline-ale icons
let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

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
nmap <leader>gr :Gread<cr>
nmap <leader>gs :Gstatus<cr><c-w>

" diff merge shortcuts
nmap <leader>1 :diffput 1<cr>:diffupdate<cr>
nmap <leader>2 :diffget 2<cr>:diffupdate<cr>
nmap <leader>3 :diffget 3<cr>:diffupdate<cr>

" Show DiffGitCached when running git commit
autocmd FileType gitcommit if ! &previewwindow && expand('%:t') !~# 'index' | :DiffGitCached | wincmd k | :res -100 | :res +4 | endif


" fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --glob "!.gitkeep"'
map <leader>fa :Ag<cr>
map <leader>fb :BLines<cr>
map <leader>fl :Lines<cr>
map <leader>ff :Files<cr>
map <leader>fg :GFiles<cr>

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
let g:pymode_options_max_line_length = 80

" vim-diff-enhanced
if &diff
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

" vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

" neoformat
map <leader>nf :Neoformat<cr>

" tagbar
nmap <F3> :TagbarToggle<CR>
imap <F3> <C-o>:TagbarToggle<CR>

if has('unix')
  " vim-dasht
  nnoremap <Leader>k :Dasht<Space>
  nnoremap <Leader><Leader>k :Dasht!<Space>
  nnoremap <silent> <Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>
  nnoremap <silent> <Leader><Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')], '!')<Return>
  vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>
  vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>

  " vim-go
  nmap <silent> <leader>tg :GoTest<CR>
  nmap <silent> <leader><leader>tg :GoTestFunc<CR>
endif

" emmet-vim
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

" ncm2
map <F9> :call ToggleCompletion()<cr>
imap <F9> <C-o>:call ToggleCompletion()<cr>

let s:ncm2Enabled = 1
function! ToggleCompletion()
    if s:ncm2Enabled
      call ncm2#disable_for_buffer()
      let s:ncm2Enabled = 0
    else
      call ncm2#enable_for_buffer()
      let s:ncm2Enabled = 1
    endif
endfunction
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Chef
augroup chef
  autocmd BufRead,BufNewFile *.rb if expand('%:p:h:t') == "recipes" | set filetype=ruby.chef | endif
augroup END

" easymotion

" map s to be single character easymotion search
nmap s <Plug>(easymotion-s2)

" Setup easy motion line changes
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

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
let g:EasyMotion_enter_jump_first = 1

" notational-fzf-vim
let g:nv_search_paths = ['~/Dropbox/notes']
let g:nv_default_extension = '.md'
let g:nv_use_short_pathnames = 1
let g:nv_show_preview = 0
map <leader>nv :NV<cr>

" gitgutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
hi GitGutterAdd guifg=#3ad900 ctermfg=2
hi GitGutterChange guifg=#ffc600 ctermfg=3
hi GitGutterDelete guifg=#ff2600 ctermfg=1

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
