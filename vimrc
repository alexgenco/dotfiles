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
cnoreabbrev W w

if !has('gui_running')
  colorscheme desert
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
let g:ctrlp_prompt_mappings = {
      \ 'AcceptSelection("e")': [],
      \ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
      \ }

" powerline
let g:Powerline_symbols = 'fancy'

" ack
nmap <C-f> :Ack! ''<left>
nmap f<C-w> :Ack!<CR>

nmap f<C-d> :call AckDef()<CR>
function! AckDef()
  let current_word=expand("<cword>")
  let query='def '.current_word
  let command=":Ack! '".query."'"
  exec command
endfunction

" rspec
"nmap ,R :call RunSingleSpec()<CR>
"function! RunSingleSpec()
"  let linenumber=line(".")
"  let filename=bufname("%")
"  let command=':!rspec --no-color -l '.linenumber.' '.filename
"  exec command
"endfunction
"
"nmap ,r :call RunSpecs()<CR>
"function! RunSpecs()
"  let filename=bufname("%")
"  let command=':!rspec --no-color '.filename
"  exec command
"endfunction

" vim-ruby-conque (rspec, rake)
let mapleader=','
nmap <silent> <Leader>r :call RunRubyOrRspecCurrentFileConque()<CR>
nmap <silent> <Leader>R :call RunRspecCurrentLineConque()<CR>
nmap <silent> <Leader>c :call RunCucumberCurrentFileConque()<CR>
nmap <silent> <Leader>C :call RunCucumberCurrentLineConque()<CR>
nmap <silent> <Leader>k :call RunRakeConque()<CR>
nmap <silent> <Leader>. :call RunLastConqueCommand()<CR>

function! RunRubyOrRspecCurrentFileConque()
  let filename=bufname("%")
  if match(filename, "_spec\.rb")
    call RunRspecCurrentFileConque()
  else
    call RunRubyCurrentFileConque()
  endif
endfunction

" my stuff

set scrolloff=6
map Y y$
set autoread

" replace double quotes with single, vice versa
nmap '' V:s:":':g<CR>:noh<CR><ESC>
nmap "" V:s:':":g<CR>:noh<CR><ESC>
vmap '' :s:":':g<CR>:noh<CR><ESC>
vmap "" :s:':":g<CR>:noh<CR><ESC>

" insert empty line without entering insert mode
nmap <C-o> o<ESC>S<ESC>

nmap D d$

" switch tabs
nmap fj :tabp<CR>
nmap fk :tabn<CR>

" inline do ... end
vmap in J V:s/do/{<CR> V:s/end/}<CR>

" source vimrc on save
if has("autocmd")
  autocmd bufwritepost .vimrc source $MYVIMRC
endif

" shortcut to edit .vimrc
let mapleader='\'
nmap <Leader>v :tabedit $MYVIMRC<CR>

" Shortcut to rapidly toggle `set list`
set list
nmap <leader>l :set list!<CR>

" Use the same symbols as TextMate for tabstops and EOLs
set listchars=tab:▸\ ,eol:¬
