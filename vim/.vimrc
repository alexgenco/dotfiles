if &compatible
  set nocompatible
endif

syntax enable
filetype plugin indent on


" Plugins
"

" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'janko-m/vim-test'
Plug 'fatih/vim-go', { 'for': 'go', 'do': ':GoInstallBinaries' }
Plug 'jparise/vim-graphql'
Plug 'rust-lang/rust.vim'
Plug 'benmills/vimux'
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
set timeout timeoutlen=1000 ttimeoutlen=0

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

" search in subfolders with :find
set path+=**

" netrw settings
let g:netrw_banner=0    " disable banner
let g:netrw_altv=1      " open splits to the right
let g:netrw_liststyle=3 " tree view

" vim-test settings
if has("nvim")
  let test#strategy = "neovim"
else
  function! s:PersistentTerminal(cmd) abort
    if !exists("g:test#vimterminal_buffer") || !bufexists(g:test#vimterminal_buffer)
      let g:test#vimterminal_buffer = term_start(
            \ ["/bin/bash", "--login"],
            \ {"term_finish": "close", "term_rows": 25})
      wincmd p
    endif

    call term_sendkeys(g:test#vimterminal_buffer, a:cmd . "\<cr>")
  endfunction

  let test#custom_strategies = {"pt": function("s:PersistentTerminal")}
  let test#strategy = "pt"
endif

if exists("*netrw_gitignore#Hide")
  let g:netrw_list_hide=netrw_gitignore#Hide()
endif

" ruby settings
let g:ruby_indent_block_style = "do"


" Keybindings
"
let mapleader = "\\"

" make Y go to end of line
nnoremap Y y$

" run tests
nmap <silent> <leader>rf :TestNearest<cr>
nmap <silent> <leader>rb :TestFile<cr>
nmap <silent> <leader>ra :TestSuite<cr>
nmap <silent> <leader>rl :TestLast<cr>

" grep for the word under the cursor
nmap <leader>gw :silent grep <cword> \| cwin \| redraw!<cr>

" fzf
nmap <leader>ff :call FuzzyFind()<cr>
nmap <leader>be :Buffers<cr>


" Functions
"
" make parent directories of new file before save
function! MkdirIfNeeded(file, buf) abort
  if empty(getbufvar(a:buf, "&buftype")) && a:file!~#"\v^\w+\:\/"
    let dir=fnamemodify(a:file, ":h")
    if !isdirectory(dir)
      call mkdir(dir, "p")
    endif
  endif
endfunction

function! FuzzyFind() abort
  silent! call system("git rev-parse --is-work-tree")

  if v:shell_error
    Files
  else
    GFiles -o -c --exclude-standard
  endif
endfunction


" Autocmds
"
augroup vimrcEx
  autocmd!

  autocmd BufNewFile,BufRead *.rs,*.rc set filetype=rust
  autocmd BufNewFile,BufRead *.go setlocal noet nolist ts=4 sw=4 sts=4

  autocmd Filetype ruby setlocal suffixesadd+=.rb path+=lib,spec
  autocmd Filetype go setlocal suffixesadd+=.go
  autocmd Filetype rust setlocal suffixesadd+=.rs

  " create parent directories when saving a new file
  autocmd BufWritePre * call MkdirIfNeeded(expand("<afile>"), +expand("<abuf>"))

  if exists("##TerminalOpen")
    " don't show line numbers in terminal buffers
    autocmd TerminalOpen * setlocal nonumber
  endif

  " jump to the last known cursor position
  autocmd BufReadPost *
        \ if &ft != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif
augroup END


" Colorscheme
"
colorscheme default

" Local Settings
"
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
