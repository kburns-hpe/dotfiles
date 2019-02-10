Plug 'majutsushi/tagbar'

nmap <F3> :TagbarToggle<CR>
imap <F3> <C-o>:TagbarToggle<CR>

" Open ctag in new vertical split
map <A-]> :vsp<CR>:exec("tag ".expand("<cword>"))<CR>q
