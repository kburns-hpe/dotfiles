set diffopt+=algorithm:patience

" diff merge shortcuts
nmap <leader>1 :diffput 1<cr>:diffupdate<cr>
nmap <leader>2 :diffget 2<cr>:diffupdate<cr>
nmap <leader>3 :diffget 3<cr>:diffupdate<cr>

" vim-diff-enhanced
if &diff
  let &diffexpr='EnhancedDiff#Diff("git diff", "--diff-algorithm=patience")'
endif
