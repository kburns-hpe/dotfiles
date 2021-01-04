""" BASIC SETTINGS
set hidden " Allow switching buffers without saving first
set mouse= " Disable mouse support
set grepprg=rg\ --vimgrep " Use rg for grep
set number " Show line numbers

" Configure Terminal Title
set title
set titlestring=nvim:\ %t\ \(%{expand('%:~:h')}\)

" Backup configuration
set nobackup
set nowritebackup
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

" Set Python path
let g:python3_host_prog = "/usr/bin/python3"

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

" Language Server Support
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Color Scheme
Plug 'herrbischoff/cobalt2.vim'

" ctags
Plug 'ludovicchabant/vim-gutentags'

" Formatting
Plug 'sbdchd/neoformat'
Plug 'godlygeek/tabular'

" FZF
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

" Language-Specific
Plug 'fatih/vim-go'
Plug 'sheerun/vim-polyglot'

" Lightline
Plug 'mengelbrecht/lightline-bufferline'
Plug 'itchyny/lightline.vim'
Plug 'maximbaz/lightline-ale'
Plug 'ryanoasis/vim-devicons'

" Linter
Plug 'dense-analysis/ale'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Movement
Plug 'justinmk/vim-sneak'

" tag
Plug 'SirVer/ultisnips'

" Test
Plug 'janko/vim-test'

" Tmux-specific plugins
if exists('$TMUX')
  Plug 'christoomey/vim-tmux-navigator'
endif

" Utility
Plug 'andrewradev/splitjoin.vim'
Plug 'chaoren/vim-wordmotion'
Plug 'chiel92/vim-autoformat'
Plug 'chrisbra/vim-diff-enhanced'
Plug 'michaeljsmith/vim-indent-object'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'neomake/neomake'
Plug 'ntpeters/vim-better-whitespace'
Plug 'rizzatti/dash.vim'
Plug 'tommcdo/vim-lion'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-unimpaired'
Plug 'wellle/targets.vim'

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
  autocmd BufRead,BufNewFile *ansible*/*.yml set filetype=ansible.yaml
  autocmd BufRead,BufNewFile *.rb if expand('%:p:h:t') == "recipes" | set filetype=ruby.chef | endif
augroup END

" Misc autocmd grouping
augroup Misc
  autocmd!
  autocmd User ALELint call lightline#update()
  autocmd FileType * setlocal formatoptions-=r formatoptions-=o
augroup end

" Neomake Status integration
augroup neomake_hook
  au!
  autocmd User NeomakeJobFinished call TestFinished()
  autocmd User NeomakeJobStarted call TestStarted()
augroup END

" Autoformat on save
au BufWrite * :Autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0

""" FUNCTIONS

function! FzfTagsCurrentWord()
  let l:word = expand('<cword>')
  let l:list = taglist(l:word)
  if len(l:list) == 1
    execute ':tag ' . l:word
  else
    call fzf#vim#tags(l:word)
  endif
endfunction


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

"""" lightline functions

" Test Status
"" initially empty status
let g:testing_status = ''

"" Start test
function! TestStarted() abort
  let g:testing_status = '⌛'
endfunction

"" Show message when all tests are passing
function! TestFinished() abort
  let context = g:neomake_hook_context
  if context.jobinfo.exit_code == 0
    let g:testing_status = '✅'
  endif
  if context.jobinfo.exit_code == 1
    let g:testing_status = '❌'
  endif
endfunction

function! TestStatus() abort
  return g:testing_status
endfunction

function! CocCurrentFunction()
  return get(b:, 'coc_current_function', '')
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

function! MyFiletype() abort
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
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

function! LightlineLinterWarnings() abort
  let l:counts = ale#statusline#Count(bufnr(''))
  let l:all_errors = l:counts.error + l:counts.style_error
  let l:all_non_errors = l:counts.total - l:all_errors
  return l:counts.total == 0 ? '' : printf('%d --', all_non_errors)
endfunction

""" MAPPINGS

" Set space as leader
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

"""" Misc Mappings
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

"""" Alt Mappings
nnoremap <A-]> :vsp<CR>:exec("tag ".expand("<cword>"))<CR>q

"""" Ctrl Mappings
noremap <c-]> :call FzfTagsCurrentWord()<cr>
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
nmap <Leader>1 <Plug>lightline#bufferline#go(1)
nmap <Leader>2 <Plug>lightline#bufferline#go(2)
nmap <Leader>3 <Plug>lightline#bufferline#go(3)
nmap <Leader>4 <Plug>lightline#bufferline#go(4)
nmap <Leader>5 <Plug>lightline#bufferline#go(5)
nmap <Leader>6 <Plug>lightline#bufferline#go(6)
nmap <Leader>7 <Plug>lightline#bufferline#go(7)
nmap <Leader>8 <Plug>lightline#bufferline#go(8)
nmap <Leader>9 <Plug>lightline#bufferline#go(9)
nmap <Leader>0 <Plug>lightline#bufferline#go(10)
nnoremap <leader>P "+P
nmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>af :Autoformat<CR>
nnoremap <leader>c :close<CR>
nnoremap <leader>d :bd<CR>
nnoremap <leader>fa :Ag<cr>
nnoremap <leader>fb :Buffers<cr>
nnoremap <leader>fc :BCommits<cr>
nnoremap <leader>fC :Commits<cr>
nnoremap <leader>ff :Files<cr>
nnoremap <leader>fg :GFiles<cr>
nnoremap <leader>fl :BLines<cr>
nnoremap <leader>fL :Lines<cr>
nnoremap <leader>fm :Marks<cr>
nmap <leader>fs  <Plug>(coc-format-selected)
nnoremap <leader>ft :BTags<cr>
nnoremap <leader>fT :Tags<cr>
nnoremap <silent> <leader>ga :Gwrite<cr>
nnoremap <silent> <leader>gb :Gblame<cr>
nnoremap <silent> <leader>gc :Gcommit -v<cr>
nnoremap <silent> <leader>gd :Gdiff<cr>
nnoremap <silent> <leader>ge :Gedit<cr>
nnoremap <silent> <leader>gl :Glog<cr>
nnoremap <silent> <leader>gp :Gpush origin HEAD<cr>
nnoremap <silent> <leader>gr :Gread<cr>
nnoremap <silent> <leader>gs :Gstatus<cr><c-w>
nmap <silent> <leader>h <Plug>DashSearch
nnoremap <leader>nf :Neoformat<cr>
nnoremap <leader>p "+p
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>rn <Plug>(coc-rename)
nnoremap <leader>rv :source $MYVIMRC<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>tl :TestLast<CR>
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tv :TestVisit<CR>
nnoremap <leader>wd :pclose<CR>
nnoremap <silent> <leader>we :call ToggleList("Quickfix List", 'c')<CR>
nnoremap <silent> <leader>wl :call ToggleList("Location List", 'l')<CR>
nnoremap <silent> <leader>Q vapJgqap
nmap <silent> <leader>[c <Plug>(coc-diagnostic-prev)
nmap <silent> <leader>]c <Plug>(coc-diagnostic-next)
nnoremap <leader>y "+y
xmap <leader>a  <Plug>(coc-codeaction-selected)
xmap <leader>f  <Plug>(coc-format-selected)

"""" Leader Leader Mappings
nnoremap <leader><leader>1 :diffput 1<cr>:diffupdate<cr>
nnoremap <leader><leader>2 :diffget 2<cr>:diffupdate<cr>
nnoremap <leader><leader>3 :diffget 3<cr>:diffupdate<cr>
nnoremap <silent> <leader><leader>a  :<C-u>CocList diagnostics<cr>
nnoremap <silent> <leader><leader>c  :<C-u>CocList commands<cr>
nnoremap <silent> <leader><leader>e  :<C-u>CocList extensions<cr>
autocmd FileType go nmap <leader><leader>ga :GoAlternate<CR>
autocmd FileType go nmap <leader><leader>gb <Plug>(go-build)
autocmd FileType go nmap <leader><leader>gc <Plug>(go-coverage-toggle)
autocmd FileType go nmap <leader><leader>gd :GoDef<CR>
autocmd FileType go nmap <leader><leader>gf :GoDecls<CR>
autocmd FileType go nmap <leader><leader>gg :GoDeclsDir<CR>
autocmd FileType go nmap <leader><leader>gh :GoDoc<CR>
autocmd FileType go nmap <leader><leader>gi <Plug>(go-info)
autocmd FileType go nmap <leader><leader>gt <Plug>(go-test)
nnoremap <silent> <leader><leader>j  :<C-u>CocNext<CR>
nnoremap <silent> <leader><leader>k  :<C-u>CocPrev<CR>
nnoremap <silent> <leader><leader>o  :<C-u>CocList outline<cr>
nnoremap <silent> <leader><leader>p  :<C-u>CocListResume<CR>
nnoremap <silent> <leader><leader>s  :<C-u>CocList -I symbols<cr>

"""" Regular Mappings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nnoremap <silent> K :call <SID>show_documentation()<CR>
nnoremap <silent> Q gqap
nnoremap <silent> p p`]
nnoremap ZQ :qa<CR>
nnoremap ZZ :wqa<CR>
nmap [h <Plug>GitGutterPrevHunk
nnoremap [q :cprevious<CR>
nnoremap [Q :cfirst<CR>
nmap ]h <Plug>GitGutterNextHunk
nnoremap ]q :cnext<CR>
nnoremap ]Q :clast<CR>
vnoremap <silent> p p`]
vnoremap <silent> y y`]
xnoremap <silent> Q gq

"""" COLORS
augroup MyColors
  autocmd!
  autocmd ColorScheme * highlight GitGutterAdd guifg=#3ad900 ctermfg=2
        \ | highlight GitGutterChange guifg=#ffc600 ctermfg=3
        \ | highlight GitGutterDelete guifg=#ff2600 ctermfg=1
augroup end
colorscheme cobalt2

"""" Color Columns
hi ColorColumn guifg=NONE guibg=#204563 gui=NONE
hi clear SignColumn

""" PLUGIN SPECIFIC SETTINGS

"""" ale
let g:ale_fixers = {
      \   'ruby': ['rubocop'],
      \}

" Disable linters that we're using coc for
let g:ale_linters = {
      \   'go': [''],
      \   'python': [''],
      \   'yaml': [''],
      \}

" Only lint on saving
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_enter = 0

"""" ctags
let g:gutentags_cache_dir = "~/.config/nvim/tags"


"""" coc

" Install plugins
let g:coc_global_extensions = [ 'coc-go', 'coc-python', 'coc-json', 'coc-snippets', 'coc-yaml' ]

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Show documentation in preview window
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_snippet_next = '<tab>'
let g:coc_snippet_prev = '<S-TAB>'
let g:UltiSnipsExpandTrigger='<Nop>'

"""" fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --glob "!.gitkeep"'
let $FZF_DEFAULT_OPTS=' --color=dark --color=bg:#253F52,bg+:#253F52 --layout=reverse  --margin=1,4'


let g:fzf_layout = { 'window': 'call FloatingFZF()' }

function! FloatingFZF()
  let buf = nvim_create_buf(v:false, v:true)
  call setbufvar(buf, '&signcolumn', 'no')

  let height = float2nr(20)
  let width = float2nr(120)
  let horizontal = float2nr((&columns - width) / 2)
  let vertical = 1

  let opts = {
        \ 'relative': 'editor',
        \ 'row': vertical,
        \ 'col': horizontal,
        \ 'width': width,
        \ 'height': height,
        \ 'style': 'minimal'
        \ }

  call nvim_open_win(buf, v:true, opts)
endfunction

"""" lightline
let g:lightline = {
      \ 'colorscheme': 'cobalt2',
      \ 'active': {
      \ 'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive'], [ 'buffers' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'filetype' ],
      \            [ 'linter_checking', 'linter_warnings', 'linter_errors', 'linter_ok' ],
      \            [ 'cocstatus', 'teststatus', 'currentfunction' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'FugitiveHead',
      \   'readonly': 'LLReadonly',
      \   'modified': 'LLModified',
      \   'mode': 'LLMode',
      \   'filetype': 'MyFiletype',
      \   'cocstatus': 'coc#status',
      \   'teststatus': 'TestStatus',
      \   'currentfunction': 'CocCurrentFunction',
      \ },
      \ 'component_expand': {
      \  'linter_checking': 'lightline#ale#checking',
      \  'linter_warnings': 'lightline#ale#warnings',
      \  'linter_errors': 'lightline#ale#errors',
      \  'linter_ok': 'lightline#ale#ok',
      \  'buffers': 'lightline#bufferline#buffers',
      \ },
      \ 'component_type': {
      \     'linter_checking': 'right',
      \     'linter_warnings': 'warning',
      \     'linter_errors': 'error',
      \     'linter_ok': 'green',
      \     'buffers': 'tabsel',
      \ }
      \ }

autocmd BufWritePost,TextChanged,TextChangedI * call lightline#update()

let g:lightline#bufferline#show_number = 2
let g:lightline#bufferline#number_separator = ':'
let g:lightline#bufferline#unnamed = '[No Name]'

set laststatus=2
set noshowmode

let g:lightline#ale#indicator_checking = "\uf110"
let g:lightline#ale#indicator_warnings = "\uf071"
let g:lightline#ale#indicator_errors = "\uf05e"
let g:lightline#ale#indicator_ok = "\uf00c"

"""" lion
let b:lion_squeeze_spaces = 1

"""" polyglot
" This holds settings for plugins brought in via vim-polygot
let g:vim_markdown_new_list_item_indent = 0

"""" vim-autoformat
let g:formatters_python = ['black']

"""" vim-bufferline
let g:bufferline_echo = 0

"""" vim-diff-enhanced
if &diff
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif

"""" vim-better-whitespace
let g:better_whitespace_enabled=1
let g:strip_whitespace_on_save=1
let g:strip_whitespace_confirm=0

"""" vim-go
" disable vim-go :GoDef short cut (gd)
" this is handled by LanguageClient [LC]
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_fmt_command = "goimports"
let g:go_metalinter_autosave = 0
let g:go_auto_sameids = 1

let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_functions = 1
let g:go_highlight_operators = 1
let g:go_highlight_types = 1

autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')


"""" vim-sneak
let g:sneak#label = 1

"""" vim-test
let test#strategy = "neomake"
let g:neomake_open_list = 0
let test#python#runner = 'pytest'

""" END

" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL
