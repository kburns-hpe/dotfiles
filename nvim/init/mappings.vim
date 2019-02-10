" Map %% as %:h for ease of use
cnoremap <expr> %%  getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" Set w!! to write to file as root
cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Change ZZ and ZQ to quit all buffers instead of just the current one
map ZZ :wqa<CR>
map ZQ :qa<CR>

" Map ctrl-s in insert mode to move to normal mode and save the document
map <C-s> :w<CR>
imap <C-s> <Esc>:w<CR>

" Copy/Paste
map <leader>c "+y
map <leader>p "+p
map <leader>P "+P

" Reformat paragrahs
nnoremap <silent> Q gqap
xnoremap <silent> Q gq
nnoremap <silent> <leader>Q vapJgqap

" Buffer shortcuts
nnoremap <C-Left> :bprevious<CR>
nnoremap <C-Right> :bnext<CR>
nnoremap <C-n> :bnext<CR>
nnoremap <C-p> :bprevious<CR>
nnoremap <leader>d :bd<CR>
nnoremap <Leader>wd :pclose<CR>

" Make splits easier to switch to
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <leader>; <C-w>v
nnoremap <leader>' <C-w>s
nnoremap <leader>q <C-w>q

" Bind F2 to enable/disable paste mode
set pastetoggle=<F2>

" This lets escape clear the search highlights
map <F4> :noh<CR>:<backspace>
imap <F4> <C-o>:noh<CR><C-o>:<backspace>

" setup spell checking
set spelllang=en
set spellsuggest=5
map <F7> :setlocal spell!<CR>
imap <F7> <C-o>:setlocal spell!<CR>

" Toggle showing invisible characters
noremap <F8> :set list!<CR>
inoremap <F8> <C-o>:set list!<CR>
cnoremap <F8> <C-c>:set list!<CR>

" reload nvim init.vim
nnoremap <Leader>r :source $MYVIMRC<CR>

" Automatically jump to the end of a yank or paste.
vnoremap <silent> y y`]
vnoremap <silent> p p`]
nnoremap <silent> p p`]

" Toggle relative line numbers
function! NumberToggle()
  if(&number == 1)
    set nonumber
  else
    set number
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

nmap <silent> <leader>wl :call ToggleList("Location List", 'l')<CR>
nmap <silent> <leader>we :call ToggleList("Quickfix List", 'c')<CR>
