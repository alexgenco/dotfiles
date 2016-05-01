set nocompatible

" Bundles
"
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'wting/rust.vim'
call vundle#end()


" Settings
"
syntax enable
filetype plugin indent on
set backspace=indent,eol,start
set encoding=utf-8

" line numbers
set number

" search
set ignorecase
set smartcase
set incsearch
set hlsearch

" line endings
set listchars=tab:▸·,trail:·,extends:»
set list
set wrap
set linebreak
let &showbreak = '↳ '

if exists("&breakindent")
  set breakindent
endif

" move by visual line
nnoremap k gk
nnoremap j gj

" more context while scrolling
set scrolloff=8
set sidescrolloff=8
set sidescroll=0
set scrolljump=5

" automatically read files changed outside vim
set autoread

" prevent automatically adding newlines to end of file
set binary

" tab completion
set ofu=syntaxcomplete#Complete
set wildmode=longest,list
set complete=.,b,u,]
set completeopt=longest,menuone
set wildmenu

" increase command history
set history=1000

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
set wildignore+=*/.git/*,*/tmp/*,*/*.orig,*/.sass-cache/*,*.o,*.hi,*.pyc,*/node_modules/*,*/target/*,vendor/*

" prevent O delay
set timeout timeoutlen=3000 ttimeoutlen=100

" fold based on indent, disabled by default
set foldmethod=indent
set nofoldenable

" let buffers exist in the background
set hidden

" open new split panes to right and bottom
set splitbelow
set splitright

" use git for :grep
set grepprg=git\ grep\ -n\ $*

" status line
set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-8(%4l:%c%)

" move cursor beyond end of line in visual block mode
set virtualedit=block

" don't move cursor to start of line on jumps
set nostartofline


" Keybindings
"
let mapleader = "\\"

" make Y go to end of line
nnoremap Y y$

" run tests
let g:rspec_command = "!clear && bundle exec rspec {spec}"
nnoremap <leader>rb :call RunCurrentSpecFile()<cr>
nnoremap <leader>rf :call RunNearestSpec()<cr>
nnoremap <leader>ra :call RunAllSpecs()<cr>
nnoremap <leader>rl :call RunLastSpec()<cr>


" Functions
"
" make parent directories of new file before save
function! MkdirIfNeeded(file, buf)
  if empty(getbufvar(a:buf, "&buftype")) && a:file!~#"\v^\w+\:\/"
    let dir=fnamemodify(a:file, ":h")
    if !isdirectory(dir)
      call mkdir(dir, "p")
    endif
  endif
endfunction


" Autocmds
"
" prevent tabs from becoming tabstops for some reason
au BufReadPost * set expandtab

augroup vimrcEx
  " clear all autocmds in the group
  autocmd!

  " syntax
  autocmd BufRead,BufNewFile *.rs,*.rc set filetype=rust

  " path and suffix settings for gf
  autocmd Filetype ruby setlocal suffixesadd+=.rb path+=lib,spec

  " create parent directories when saving a new file
  autocmd BufWritePre * call MkdirIfNeeded(expand("<afile>"), +expand("<abuf>"))

  " jump to the last known cursor position
  autocmd BufReadPost *
    \ if &ft != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END


" Colorscheme
"
colorscheme desert


" Local Settings
"
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
