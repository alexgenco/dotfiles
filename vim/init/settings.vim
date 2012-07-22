syntax enable
filetype plugin indent on
set backspace=indent,eol,start
set nocompatible

" always show the statusline
set laststatus=2

" necessary to show unicode glyphs
set encoding=utf-8

" line numbers
set number

" no swap files
set noswapfile

" search
set ignorecase
set smartcase
set incsearch
set hlsearch

" line endings
set nolist
set listchars=tab:▸\ ,eol:¬,trail:·
set nowrap

" more context while scrolling
set scrolloff=3
set sidescrolloff=15
set sidescroll=1

" automatically read files changed outside vim
set autoread

set tabpagemax=100

" prevent automatically adding newlines to end of file
set binary

" tab completion
set ofu=syntaxcomplete#Complete
set wildmode=list:longest
set complete=.,b,u,]
set completeopt=preview

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

" turn off swp files
set nobackup
set nowb

" ignore filetypes
set wildignore+=*/.git/*,*/tmp/*,*/*.orig

" prevent tabs from becoming tabstops for some reason
au BufReadPost * set expandtab

" use relative line numbers
"if exists("&relativenumber")
"  set relativenumber
"  au BufReadPost * set relativenumber
"endif
