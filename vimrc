""""""""""
" Pathogen
""""""""""

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()


"""""""""""""
" Colorscheme
"""""""""""""

set background=dark
let g:solarized_visibility = "low"
let g:solarized_termcolors = 256
let g:solarized_underline  = 1

if !has('gui_running')
  set t_Co=256
endif
colorscheme solarized


""""""""""
" Autocmds
""""""""""

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END


""""""""""
" Settings
""""""""""

set nocompatible
syntax enable
filetype plugin indent on
set backspace=indent,eol,start

" always show the statusline
set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" necessary to show unicode glyphs
set encoding=utf-8

" line numbers
set number

" search
set ignorecase
set smartcase
set incsearch
set hlsearch
highlight! Search cterm=underline
highlight! IncSearch cterm=underline

" line endings
set list
set listchars=tab:▸\ ,eol:¬,trail:·
set nowrap
set linebreak

" more context while scrolling
set scrolloff=3
set sidescrolloff=15
set sidescroll=1

" automatically read files changed outside vim
set autoread

set tabpagemax=100

" prevent automatically adding newlines to end of file
set binary

" fast scrolling
set ttyfast
set scrolljump=5

" tab completion
set ofu=syntaxcomplete#Complete
set wildmode=longest,list
set complete=.,b,u,]
set completeopt=preview
set wildmenu

" mode lines
set modelines=5

" indentation
set autoindent
set smartindent

" tabs
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" turn off bells
set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=

" set terminal title
set title

" no swap files
set noswapfile

" persistent undo
set undofile
set undodir=~/.vim/undo

" store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" ignore filetypes
set wildignore+=*/.git/*,*/tmp/*,*/*.orig

" prevent tabs from becoming tabstops for some reason
au BufReadPost * set expandtab

" time out on mapping after three seconds,
" time out on key codes after a tenth of a second
set timeout timeoutlen=3000 ttimeoutlen=100

" fold based on syntax
set foldmethod=indent
set nofoldenable

" minimum width
set winwidth=90

" try cursor line again. it's slow, but it should
" force me to use other methods to jump around
set nocursorline


"""""""""""""
" Keybindings
"""""""""""""

let mapleader = ","

" because I always mess these up
command! W w
command! Q q

" stop doing this
nnoremap K k

" Open new split panes to right and bottom
set splitbelow
set splitright

" move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" vertical split
"nnoremap <Leader>ss :vsplit<CR><c-w>l
nnoremap <Leader>ss :echo "don't be lazy! use :vs"<CR>

" horizontal split
"nnoremap <Leader>sh :split<CR><c-w>j
nnoremap <Leader>sh :echo "don't be lazy! use :sp"<CR>

" ctrlp
let g:ctrlp_working_path_mode = ''
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = '\.pyc$'

" ack current word
nnoremap <Leader>ff :Ack!<CR>

" custom ack
nnoremap <Leader>a :Ack! ''<left>

" make Y go to end of line
nnoremap Y y$

" inline do ... end
vnoremap in J V:s/\s\+do\s\+/ { <CR> V:s/\s\+end\s*/ }<CR>:noh<CR>

" copy to system clipboard
vnoremap <leader>c "*y

" shortcut to edit .vimrc/.gvimrc
nnoremap <Leader>vv :tabedit $MYVIMRC<CR>
nnoremap <silent> <Leader>vs :source $MYVIMRC<CR>:nohlsearch<Bar>:echo<CR>""

" turn off highlighting
nnoremap <silent> <Space> :nohlsearch \| set nocursorcolumn<Bar>:echo<CR>""

" run tests
"let g:vroom_write_all = 1
"let g:vroom_detect_spec_helper = 1
"let g:vroom_clear_screen = 1
"
"map <leader>r :VroomRunTestFile<CR>
"map <leader>R :VroomRunNearestTest<CR>
map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>R :call RunNearestSpec()<CR>

" switch to last buffer
nnoremap <leader>m <c-^>

" check shell
nnoremap <leader>z :!<cr>

" show cursorcol for lining things up, etc.
nnoremap <leader>\| :set cursorcolumn<CR>

" run haskell file
autocmd FileType haskell nnoremap <buffer> <leader>r :!clear && runhaskell -i./src %<cr>

" run python file
autocmd FileType python set sw=4 sts=4 et
autocmd FileType python nnoremap <buffer> <leader>r :call RunPythonFile()<cr>

" gitgutter off by default
let g:gitgutter_enabled = 0

" toggle gitgutter
nnoremap <leader>gg :ToggleGitGutter<cr>

" navigate gitgutter hunks
nnoremap <leader>gj :GitGutterNextHunk<cr>
nnoremap <leader>gk :GitGutterPrevHunk<cr>

" pretty print ruby object
vnoremap <leader>pp !ruby -e 'require "pp";pp eval(ARGF.read)'<cr>

" mkdir for the current buffer
nnoremap <leader>dm :!mkdir -p `dirname %`<cr>


"""""""""""
" Functions
"""""""""""


" from :h ins-completion
function! CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

function! RenameFile()
  let old_name = expand('%')
  let new_name = input('New file name: ', expand('%'), 'file')
  if new_name != '' && new_name != old_name
    exec ':saveas ' . new_name
    exec ':silent !rm ' . old_name
    redraw!
  endif
endfunction
map <leader>n :call RenameFile()<cr>

" open git blame in new buffer
command! GitBlame :call GitBlame()
function! GitBlame()
  let line = line(".")
  let ftype = &ft
  tabnew
  r!git --no-pager blame #
  set buftype=nofile
  set bufhidden=hide
  g/^$/d
  exec ":set filetype=".ftype
  exec ":".line
endfunction
nnoremap <Leader>gb :GitBlame<CR>

function! RunPythonFile()
  let fname = expand("%:t")
  if match(fname, "_test.py$")
    exec "!clear && python -m unittest tests.".expand("%:t:r")
  elseif match(fname, ".py$")
    exec "!clear && python %"
  endif
endfunction


""""""""
" Syntax
""""""""

" RABL syntax highlighting
au! BufNewFile,BufRead *.rabl setf ruby

" clojure syntax highlighting
let g:clj_highlight_builtins=1
au BufRead,BufNewFile *.clj setf clojure

" rspec syntax
au BufRead,BufNewFile *_spec.rb set filetype=rspec

au BufRead,BufNewFile *.txt setlocal wrap nolist linebreak
au BufRead,BufNewFile *.txt call SetLineWrapMovements()

au BufRead,BufNewFile *.rb call SetPipeObjects()

function! SetLineWrapMovements()
  noremap  <buffer> <silent> k gk
  noremap  <buffer> <silent> j gj
  noremap  <buffer> <silent> 0 g0
  noremap  <buffer> <silent> $ g$
endfunction

function! SetPipeObjects()
  nnoremap di\| T\|d,
  nnoremap da\| F\|d,
  nnoremap ci\| T\|c,
  nnoremap ca\| F\|c,
  nnoremap yi\| T\|y,
  nnoremap ya\| F\|y,
  nnoremap vi\| T\|v,
  nnoremap va\| F\|v,
endfunction
