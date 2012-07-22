" use , as map leader
let mapleader = ","

" because I always mess this up
command! W w

" tab movement
nnoremap <D-j> :tabp<CR>
nnoremap <D-k> :tabn<CR>

" from :h ins-completion
function! CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

" omnicomplete
"inoremap <S-Tab> <C-x><C-o>

" use ; to enter command mode
nnoremap ; :

" scroll viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" horizontal scroll
nnoremap <C-k> 3zl
nnoremap <C-j> 3zh

" <tab> to jump to matching character
nnoremap <tab> %

" PeepOpen
nnoremap <D-t> :PeepOpen<CR>

" powerline
"let g:Powerline_symbols = 'fancy'

" custom ack
nnoremap <D-f> :Ack! ''<left>

" ack something with a prefix (used below)
function! AckPrefix(pref)
  let prefix = a:pref
  let current_word=expand("<cword>")
  let query=prefix.current_word
  let command=":Ack! '".query."'"
  exec command
endfunction

" ack current word
nnoremap <Leader>ff :Ack!<CR>

" ack def of current word
nnoremap <Leader>fd :call AckPrefix("def ")<CR>

" ack class definition of current word
nnoremap <Leader>fc :call AckPrefix("class ")<CR>

" make Y go to end of line
nnoremap Y y$

" inline do ... end
vnoremap in J V:s/\s\+do\s\+/ { <CR> V:s/\s\+end\s*/ }<CR>:noh<CR>

" shortcut to edit .vimrc/.gvimrc
nnoremap <Leader>vv :tabedit $MYVIMRC<CR>
nnoremap <Leader>vg :tabedit $MYGVIMRC<CR>
if has('gui_running')
  nnoremap <Leader>vs :source $MYVIMRC<CR>:source $MYGVIMRC<CR>
else
  nnoremap <Leader>vs :source $MYVIMRC<CR>
endif

" turn off highlighting
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>""

" paren rainbow
"let g:vimclojure#ParenRainbow = 1
noremap <Leader>tp :call vimclojure#ToggleParenRainbow()<CR>

" open git blame in new buffer
nnoremap <Leader>gb :call GitBlame()<CR>
function! GitBlame()
  let file = expand('%:p')
  exec ":tabnew | r !git --no-pager blame ".file
endfunction

map <leader>r :wa<CR>:RunTest<CR>
map <leader>R :wa<CR>:RunFocusedTest<CR>

" splits
nnoremap <Leader>sv :vsplit<CR>
nnoremap <Leader>sh :split<CR>
nnoremap <Leader>ss <C-W>w
