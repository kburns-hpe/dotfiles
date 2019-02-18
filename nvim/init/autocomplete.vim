Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-path'
Plug 'ncm2/ncm2-ultisnips'
Plug 'ncm2/ncm2-go'
Plug 'ncm2/ncm2-jedi'

map <F9> :call ToggleCompletion()<cr>
imap <F9> <C-o>:call ToggleCompletion()<cr>

let s:ncm2Enabled = 1
function! ToggleCompletion()
    if s:ncm2Enabled
      call ncm2#disable_for_buffer()
      let s:ncm2Enabled = 0
    else
      call ncm2#enable_for_buffer()
      let s:ncm2Enabled = 1
    endif
endfunction
" suppress the annoying 'match x of y', 'The only match' and 'Pattern not
" found' messages
set shortmess+=c
" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANTE: :help Ncm2PopupOpen for more information
set completeopt=noinsert,menuone,noselect

" When the <Enter> key is pressed while the popup menu is visible, it only
" hides the menu. Use this mapping to close the menu and also start a new
" line.
inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

