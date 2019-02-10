Plug 'sunaku/vim-dasht'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" vim-dasht
nnoremap <Leader><Leader>k :Dasht!<Space>
nnoremap <silent> <Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')])<Return>
nnoremap <silent> <Leader><Leader>K :call Dasht([expand('<cword>'), expand('<cWORD>')], '!')<Return>
vnoremap <silent> <Leader>K y:<C-U>call Dasht(getreg(0))<Return>
vnoremap <silent> <Leader><Leader>K y:<C-U>call Dasht(getreg(0), '!')<Return>

" vim-go
nmap <silent> <leader>tg :GoTest<CR>
nmap <silent> <leader><leader>tg :GoTestFunc<CR>
