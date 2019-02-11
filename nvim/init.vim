" Change leader from \ to Space
nnoremap <SPACE> <Nop>
let mapleader = "\<Space>"

call plug#begin('~/.config/nvim/plugged')

Plug 'herrbischoff/cobalt2.vim'

runtime! init/*.vim

if exists('$TMUX')
  runtime tmux.vim
endif

if has('unix')
  runtime unix.vim
endif

runtime init_local.vim

call plug#end()

" Color Scheme breaks in weird ways if sourced via runtime in plug block
colorscheme cobalt2
hi GitGutterAdd guifg=#3ad900 ctermfg=2
hi GitGutterChange guifg=#ffc600 ctermfg=3
hi GitGutterDelete guifg=#ff2600 ctermfg=1


" Load all plugins now.
" Plugins need to be added to runtimepath before helptags can be generated.
packloadall
" Load all of the helptags now, after plugins have been loaded.
" All messages and errors will be ignored.
silent! helptags ALL

