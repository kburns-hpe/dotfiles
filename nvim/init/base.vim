set ignorecase smartcase " enable case insensitive searching
set iskeyword+=_,$,@,%,# " set additioanl keywords for navigation purposes
set linebreak " only wrap lines at a breakat
set numberwidth=4 " Sets numbered column width
set showmatch " highlight matching brackets
set vb t_vb= "Disable visual bell
set wrap " Autowrap lines that hit end of screen
set tabstop=2 " Set a tab to be X spaces in width
set shiftwidth=2 " Sets how many spaces to move line when using <<, >>
set expandtab " Use spaces instead of a tab
set hidden " Allow switching buffers without saving first
set mouse= " Disable mouse support
set termguicolors " Enable truecolor support
filetype plugin indent on " Enable indent based on filetype
set grepprg=rg\ --vimgrep " Use ripgrep for grep

" Speed up
set nocursorline
let g:matchparen_timeout = 20
let g:matchparen_insert_timeout = 20

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

" Open new splits to the right and bottom
set splitbelow
set splitright

" Enable yaml linter to run on ansible files
augroup FiletypeGroup
    autocmd!
    au BufNewFile,BufRead *.yml set filetype=ansible.yaml
augroup END

" Chef
augroup chef
  autocmd BufRead,BufNewFile *.rb if expand('%:p:h:t') == "recipes" | set filetype=ruby.chef | endif
augroup END
