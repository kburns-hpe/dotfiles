" Rename tmux window title to current file
autocmd BufEnter * call system("tmux rename-window '" . expand("%:t") . "'")
autocmd VimLeave * call system("tmux setw automatic-rename")
" rename window to current file
autocmd BufReadPost,FileReadPost,BufNewFile * call system("tmux rename-window " . expand("%"))
Plug 'benmills/vimux'
Plug 'christoomey/vim-tmux-navigator'

" vimux
nmap <Leader>vi :VimuxInspectRunner<CR>
nmap <Leader>vl :VimuxRunLastCommand<CR>
nmap <Leader>vp :VimuxPromptCommand<CR>
nmap <Leader>vz :VimuxZoomRunner<CR>
