set autochdir "Auto change windows CWD to the file's directory
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
set mouse= " Disable mouse support
syntax on " enable syntax highlighting
filetype plugin indent on " Enable indent based on filetype

" Disable autocomplete of comments on new lines
autocmd FileType * setlocal formatoptions-=r formatoptions-=o

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

" <leader>h hides left split. <leader>s adds 25 chars to left split
set winminwidth=0
map <leader>h <C-W>l<C-W>\|
map <leader>s <C-W>h25<C-W>>

" Copy to X CLIPBOARD
map <leader>cb "+y
map <leader>cp "*y
map <leader>cs :w !xsel -i -s<CR>
" Delete to X CLIPBOARD
vmap <leader>dc "+d
vmap <leader>dp "*d
" Paste from X CLIPBOARD
map <leader>pp "*p
map <leader>ps :r!xsel -s<CR>
map <leader>pb "+p
map <leader>Pp "*P
map <leader>Pb "+P

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

nmap <silent> <leader>l :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>e :call ToggleList("Quickfix List", 'c')<CR>

" Install Plugins
call plug#begin('~/.config/nvim/plugged')
" cobalt2 - color theme
Plug 'herrbischoff/cobalt2.vim'
" ctrlp - fuzzy file searching
Plug 'ctrlpvim/ctrlp.vim'
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
" youcompleteme - autocompletion
Plug 'Valloric/YouCompleteMe', { 'do': 'python2 ./install.py' }
" zeavim - embed zeal search
Plug 'KabbAmine/zeavim.vim'
" vim-pad - note organizing plugin
Plug 'fmoralesc/vim-pad'
" ag.vim - Adds ag support to vim
Plug 'rking/ag.vim'
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
autocmd! BufWritePost * Neomake
nnoremap <F11> :Neomake <CR>
inoremap <F11> <C-o>:Neomake <CR>

" vim-test
nmap <silent> <leader>t :TestNearest<CR>
nmap <silent> <leader>T :TestFile<CR>
nmap <silent> <leader>a :TestSuite<CR>
nmap <silent> <leader>L :TestLast<CR>
nmap <silent> <leader>v :TestVisit<CR>

let test#strategy = "neovim"

" ctrlp
let g:ctrlp_user_command = ['.git/', 'cd %s && git ls-files -oc --exclude-standard']
let g:ctrlp_working_path_mode = 'ra'

" lightline
let g:lightline = {
      \ 'colorscheme': 'jellybeans',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive'],[ 'filename' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'LLFugitive',
      \   'readonly': 'LLReadonly',
      \   'modified': 'LLModified',
      \   'filename': 'LLFilename',
      \   'mode': 'LLMode'
      \ }
      \ }

function! LLMode()
  let fname = expand('%:t')
  return fname == '__Tagbar__' ? 'Tagbar' :
        \ fname == 'ControlP' ? 'CtrlP' :
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

function! LLFilename()
  return ('' != LLReadonly() ? LLReadonly() . ' ' : '') .
       \ ('' != expand('%:t') ? expand('%:t') : '[No Name]') .
       \ ('' != LLModified() ? ' ' . LLModified() : '')
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
nmap <leader>gc :Gcommit -S<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>ge :Gedit<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gp :Gpush<cr>
nmap <leader>gs :Gstatus<cr>

" easymotion

" map s to be single character easymotion search
nmap s <Plug>(easymotion-s2)

" Setup easy motion line changes
"map <Leader>l <Plug>(easymotion-lineforward)
"map <Leader>h <Plug>(easymotion-linebackward)
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

" YouCompleteMe
let g:ycm_register_as_syntastic_checker = 0
let g:Show_diagnostics_ui = 0

"will put icons in Vim's gutter on lines that have a diagnostic set.
"Turning this off will also turn off the YcmErrorLine and YcmWarningLine
"highlighting
let g:ycm_enable_diagnostic_signs = 0
let g:ycm_enable_diagnostic_highlighting = 0
let g:ycm_always_populate_location_list = 1
let g:ycm_open_loclist_on_ycm_diags = 1
let g:ycm_complete_in_strings = 1
let g:ycm_collect_identifiers_from_tags_files = 0
let g:ycm_path_to_python_interpreter = ''
let g:ycm_server_use_vim_stdout = 0
let g:ycm_server_log_level = 'info'
let g:ycm_confirm_extra_conf = 1
let g:ycm_goto_buffer_command = 'same-buffer' "[ 'same-buffer', 'horizontal-split', 'vertical-split', 'new-tab' ]
let g:ycm_filetype_whitelist = { '*': 1 }
let g:ycm_key_invoke_completion = '<C-l>'
let g:ycm_min_num_of_chars_for_completion = 5
let g:ycm_autoclose_preview_window_after_completion = 1

function! ToggleYCM()
    if g:ycm_auto_trigger == 1
        let g:ycm_auto_trigger = 0
    else
        let g:ycm_auto_trigger = 1
    endif
endfunction
nnoremap <F10> :call ToggleYCM()<cr>
inoremap <F10> <C-o>:call ToggleYCM()<cr>

" vim-pad
let g:pad#dir = "~/Dropbox/nvdata"
