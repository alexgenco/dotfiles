" Bundles {{{

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'wting/rust.vim'
Plugin 'flazz/vim-colorschemes'

call vundle#end()

" }}}

" Settings {{{

syntax enable
filetype plugin indent on
set backspace=indent,eol,start

" Necessary to show unicode glyphs
set encoding=utf-8

" Line numbers
set number

" Matchit plugin
runtime macros/matchit.vim

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Line endings
set listchars=tab:▸·,trail:·,extends:»
set list
set wrap
set linebreak
let &showbreak = '↳ '

if exists("&breakindent")
  set breakindent
endif

" Move by visual line
nnoremap k gk
nnoremap j gj

" More context while scrolling
set scrolloff=8
set sidescrolloff=8
set sidescroll=0
set scrolljump=5

" Automatically read files changed outside vim
set autoread

" Prevent automatically adding newlines to end of file
set binary

" Tab completion
set ofu=syntaxcomplete#Complete
set wildmode=longest,list
set complete=.,b,u,]
set completeopt=longest,menuone
set wildmenu

" Mode lines
set modelines=1
set modeline

" Increase command history
set history=1000

" Indentation
set autoindent
set smartindent

" Tabs
set shiftwidth=2
set softtabstop=2
set tabstop=2
set expandtab

" Turn off bells
set noerrorbells visualbell t_vb=

" Set terminal title
set title

" No swap files
set noswapfile

" Persistent undo
set undofile
set undodir=~/.vim/undo

" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" Ignore filetypes
set wildignore+=*/.git/*,*/tmp/*,*/*.orig,*/.sass-cache/*,*.o,*.hi,*.pyc,*/node_modules/*,*/target/*,vendor/*

" Prevent O delay
set timeout timeoutlen=3000 ttimeoutlen=100

" Fold based on indent, disabled by default
set foldmethod=indent
set nofoldenable

" Let buffers exist in the background
set hidden

" Open new split panes to right and bottom
set splitbelow
set splitright

" Use git for :grep
set grepprg=git\ grep\ -n\ $*

" Status line
set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-8(%4l:%c%)

" Move cursor beyond end of line in visual block mode
set virtualedit=block

" }}}

" Keybindings {{{

let mapleader = "\\"

" Make Y go to end of line
nnoremap Y y$

" Run tests
let g:rspec_command = "!clear && bundle exec rspec {spec}"
nnoremap <leader>rb :call RunCurrentSpecFile()<cr>
nnoremap <leader>rf :call RunNearestSpec()<cr>
nnoremap <leader>ra :call RunAllSpecs()<cr>
nnoremap <leader>rl :call RunLastSpec()<cr>

" }}}

" Functions {{{

" Make parent directories of new file before save
function! MkdirIfNeeded(file, buf)
  if empty(getbufvar(a:buf, "&buftype")) && a:file!~#"\v^\w+\:\/"
    let dir=fnamemodify(a:file, ":h")
    if !isdirectory(dir)
      call mkdir(dir, "p")
    endif
  endif
endfunction

" }}}

" Autocmds {{{

" Prevent tabs from becoming tabstops for some reason
au BufReadPost * set expandtab

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  " Syntax
  autocmd BufNewFile,BufRead *.coffee set filetype=coffee
  autocmd BufRead,BufNewFile *.rs,*.rc set filetype=rust

  " Path and suffix settings for gf
  autocmd Filetype ruby setlocal suffixesadd+=.rb path+=lib,spec
  autocmd Filetype javascript,coffee setlocal suffixesadd+=.js,.coffee

  " Create parent directories when saving a new file
  autocmd BufWritePre * call MkdirIfNeeded(expand("<afile>"), +expand("<abuf>"))

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END

" }}}

" Colorscheme {{{

colorscheme desert

" }}}

" Local settings {{{

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif

" }}}

" vim:foldmethod=marker:foldlevel=0:foldenable
