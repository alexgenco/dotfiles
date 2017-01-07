set nocompatible
syntax enable
filetype plugin indent on


" Plugins
"
call plug#begin('~/.vim/plugged')
Plug 'jlanzarotta/bufexplorer'
Plug 'janko-m/vim-test'
call plug#end()


" Settings
"
set encoding=utf-8
set backspace=indent,eol,start

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

" don't redraw during macros, etc.
set lazyredraw

" always report changes
set report=0

" turn off mouse support
set mouse=


" Keybindings
"
let mapleader = "\\"

" make Y go to end of line
nnoremap Y y$

" run tests
nmap <silent> <leader>rf :TestNearest<CR>
nmap <silent> <leader>rb :TestFile<CR>
nmap <silent> <leader>ra :TestSuite<CR>
nmap <silent> <leader>rl :TestLast<CR>

" grep for the word under the cursor
nnoremap <leader>gw :silent grep <cword> \| cwin \| redraw!<cr>


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
  autocmd BufNewFile,BufRead *.go setlocal noet nolist ts=4 sw=4 sts=4
  autocmd BufNewFile,BufRead *.txt setlocal tw=80

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
