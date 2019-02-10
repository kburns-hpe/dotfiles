Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" Show DiffGitCached when running git commit
autocmd FileType gitcommit if ! &previewwindow && expand('%:t') !~# 'index' | :DiffGitCached | wincmd k | :res -100 | :res +4 | endif

" fugitive
nmap <leader>ga :Gwrite<cr>
nmap <leader>gb :Gblame<cr>
nmap <leader>gc :Gcommit -v<cr>
nmap <leader>gd :Gdiff<cr>
nmap <leader>ge :Gedit<cr>
nmap <leader>gl :Glog<cr>
nmap <leader>gp :Gpush origin HEAD<cr>
nmap <leader>gr :Gread<cr>
nmap <leader>gs :Gstatus<cr><c-w>

" gitgutter
nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
