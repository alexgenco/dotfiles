call pathogen#infect()
syntax enable
filetype plugin indent on
set backspace=indent,eol,start
set nocompatible
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
set number
set noswapfile
colorscheme desert

nmap <C-k> :tabn<CR>
nmap <C-j> :tabp<CR>

" ctrlp
let g:ctrlp_map = '<D-t>'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_open_new_file = 't'
let g:ctrlp_by_filename = 1

let g:ctrlp_prompt_mappings = {
  \ 'AcceptSelection("e")': [],
  \ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
  \ }

" powerline
let g:Powerline_symbols = 'fancy'

set scrolloff=6

map Y y$

" replace double quotes with single, vice versa
nmap '' V:s:":':g<CR>:noh<CR><ESC>
nmap "" V:s:':":g<CR>:noh<CR><ESC>

" insert empty line without entering insert mode
nmap <C-o> o<ESC>S<ESC>

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

nmap D d$
