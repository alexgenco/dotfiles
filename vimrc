" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" misc
syntax enable
filetype plugin indent on
set backspace=indent,eol,start
set nocompatible
set laststatus=2   " Always show the statusline
set encoding=utf-8 " Necessary to show unicode glyphs
set number
set noswapfile
set ignorecase
set incsearch
set linebreak
set hlsearch
cnoreabbrev W w
set scrolloff=3
set autoread
set tabpagemax=50


if !has('gui_running')
  colorscheme desert
else
  source ~/.gvimrc
endif

" indentation
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" turn off bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" turn off swp files
set nobackup
set nowb

" persistent undo
"set undofile
"set undodir=$HOME/.vim/undo

" ctrlp
let g:ctrlp_map = '<D-t>'
let g:ctrlp_working_path_mode = 0
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_open_new_file = 't'
let g:ctrlp_by_filename = 0
let g:ctrlp_max_height = 30
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': ['<s-cr>'],
      \ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
      \ }

" powerline
"let g:Powerline_symbols = 'fancy'

" ack
nmap <D-f> :Ack! ''<left>
nmap f<C-w> :Ack!<CR>

nmap f<C-d> :call AckPrefix("def ")<CR>
nmap f<C-c> :call AckPrefix("class ")<CR>
function! AckPrefix(pref)
  let prefix = a:pref
  let current_word=expand("<cword>")
  let query=prefix.current_word
  let command=":Ack! '".query."'"
  exec command
endfunction

" vim-ruby-conque (rspec, rake)
let mapleader=','
nmap <silent> <Leader>r :call RunRspecCurrentFileConque()<CR>
nmap <silent> <Leader>R :call RunRspecCurrentLineConque()<CR>
nmap <silent> <Leader>b :call RunRubyCurrentFileConque()<CR>
nmap <silent> <Leader>c :call RunCucumberCurrentFileConque()<CR>
nmap <silent> <Leader>C :call RunCucumberCurrentLineConque()<CR>
nmap <silent> <Leader>k :call RunRakeConque()<CR>
nmap <silent> <Leader>, :call RunLastConqueCommand()<CR>

" my stuff

map Y y$

" replace double quotes with single, vice versa
nmap '' V:s:":':g<CR>:noh<CR><ESC>
nmap "" V:s:':":g<CR>:noh<CR><ESC>
vmap '' :s:":':g<CR>:noh<CR><ESC>
vmap "" :s:':":g<CR>:noh<CR><ESC>

" insert empty line without entering insert mode
nmap <C-o> o<ESC>S<ESC>

nmap D d$

" switch tabs
"nmap fj :tabp<CR>
nmap <D-j> :tabp<CR>
nmap fj :tabp<CR>
"nmap fk :tabn<CR>
nmap <D-k> :tabn<CR>
nmap fk :tabn<CR>

" inline do ... end
vmap in J V:s/\s\+do\s\+/ { <CR> V:s/\s\+end\s*/ }<CR>:noh<CR>

" source vimrc on save
"if has("autocmd")
"  autocmd bufwritepost .vimrc source $MYVIMRC
"endif

" shortcut to edit/source .vimrc
let mapleader='\'
nmap <Leader>v :tabedit $MYVIMRC<CR>
nmap <Leader>g :tabedit $MYGVIMRC<CR>
nmap <Leader>s :source $MYVIMRC<CR>

" line endings and tabs
set list

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬

" Turn off highlighting
nmap <SPACE><ESC> :noh<CR>

" VimClojure
"let g:vimclojure#ParenRainbow = 1 "pretty rainbows lolol
