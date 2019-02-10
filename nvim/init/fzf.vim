Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*" --glob "!.gitkeep"'
map <leader>fa :Ag<cr>
map <leader>fb :BLines<cr>
map <leader>fl :Lines<cr>
map <leader>ff :Files<cr>
map <leader>fg :GFiles<cr>
