if &compatible
  set nocompatible
endif

if has('autocmd')
  filetype plugin indent on
endif

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif


" Plugins
"

" Install vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'fxn/vim-monochrome'
Plug 'benmills/vimux'
Plug 'vim-test/vim-test'
Plug 'junegunn/fzf', {'do': ':call fzf#install()'}
Plug 'junegunn/fzf.vim'

if has('nvim-0.5')
  Plug 'hrsh7th/nvim-compe'
  Plug 'neovim/nvim-lspconfig'
  Plug 'ojroques/nvim-lspfuzzy'
endif
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

" prevent completion messages
set shortmess+=c

" line endings
set listchars=tab:·\ ,trail:·,extends:»,nbsp:⎵
set list
set wrap
set linebreak

if exists("&showbreak")
  let &showbreak = '↳ '
endif

" delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

if exists("&breakindent")
  set breakindent
endif

if has("path_extra")
  setglobal tags-=./tags tags-=./tags; tags^=./tags;
endif

" move by visual line
nnoremap k gk
nnoremap j gj

" more context while scrolling
set scrolloff=8
set sidescrolloff=8
set sidescroll=0
set scrolljump=5

" show signs in number column
if exists('&signcolumn')
  set signcolumn=number
endif

" automatically read files changed outside vim
set autoread

" completion
set ofu=syntaxcomplete#Complete
set wildmode=longest,list
set complete=.,b,u,t
set completeopt=menuone,noselect
set wildmenu

" increase command history
set history=1000

" indentation
set autoindent
set cindent

" tabs
set shiftround
set shiftwidth=2
set softtabstop=2
set tabstop=4
set expandtab
set smarttab

" turn off bells
set noerrorbells visualbell t_vb=

" set terminal title
set title

" no swap files
set noswapfile

" don't include options in session
set sessionoptions-=options

" persistent undo
set undofile
set undodir=~/.vim/undo

" store temporary files in a central spot
set backup
set backupdir=~/.cache/vim,/var/cache,/tmp
set directory=~/.cache/vim,/var/cache,/tmp

" set key mapping timeouts
if !has('nvim') && &ttimeoutlen == -1
  set ttimeout
  set ttimeoutlen=10
endif

" fold based on indent, disabled by default
set foldmethod=indent
set nofoldenable

" let buffers exist in the background
set hidden

" open new split panes to right and bottom
set splitbelow splitright

" use ripgrep for :grep
set grepprg=rg\ --vimgrep\ --no-heading\ --smart-case

" status line
set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-8(%4l:%c%)
set ruler

" display as much of last line as possible
set display+=lastline

" move cursor beyond end of line in visual block mode
set virtualedit=block

" don't move cursor to start of line on jumps
set nostartofline

" highlight cursor line
set cursorline

" don't redraw during macros, etc.
set lazyredraw

" always report changes
set report=0

" turn off mouse support
set mouse=

" search in subfolders with :find
set path+=**

" faster update time (default is 4s)
set updatetime=500

if exists("+termguicolors")
  set termguicolors
endif

if exists('+inccommand')
  set inccommand=nosplit
endif

" load matchit.vim, but only if the user hasn't installed a newer version.
if !exists("g:loaded_matchit") && findfile("plugin/matchit.vim", &rtp) ==# ""
  runtime! macros/matchit.vim
endif

" netrw settings
let g:netrw_banner=0    " disable banner
let g:netrw_altv=1      " open splits to the right
let g:netrw_liststyle=3 " tree view

if exists("*netrw_gitignore#Hide")
  let g:netrw_list_hide=netrw_gitignore#Hide()
endif

" vimux settings
let g:VimuxOrientation = "h"
let g:VimuxHeight = "50"

" vim-test settings
if exists("$TMUX")
  let test#strategy = "vimux"
elseif has("nvim")
  let test#strategy = "neovim"
elseif exists("*term_start")
  let test#strategy = "vimterminal"
else
  let test#strategy = "make"
endif

" https://github.com/vim-test/vim-test/pull/555
let g:test#echo_command = 0
let g:test#preserve_screen = 1

" ruby settings
let g:ruby_indent_block_style = "do"
let g:ruby_no_expensive=1

" fix incorrect sh non-POSIX highlighting
let g:is_posix=1

" fzf
let g:fzf_layout = {'down': '~38%'}

" compe
let g:compe = {
      \ 'autocomplete': v:false,
      \ 'preselect': 'enable',
      \ 'documentation': v:true,
      \ 'source': {
      \   'path': v:true,
      \   'buffer': v:true,
      \   'tags': v:true,
      \   }
      \ }

if has('nvim-0.5')
  let g:compe.source.nvim_lsp = v:true
endif


" Keybindings
"
let mapleader = ","

" make Y go to end of line
nnoremap Y y$

" run tests
nmap <silent> <leader>t :TestFile<cr>
nmap <silent> <leader>T :TestNearest<cr>
nmap <silent> <leader><c-t> :TestLast<cr>

" grep for the word under the cursor
nnoremap <leader>g <cmd>silent grep! <cword> \| cwin \| redraw!<cr>

" fuzzy find
nnoremap <leader>f <cmd>call FuzzyFind(getcwd())<cr>
nnoremap <leader>F <cmd>call FuzzyFind()<cr>
nnoremap <leader>b <cmd>Buffers<cr>
nnoremap <leader>h <cmd>Helptags<cr>


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

function! FuzzyFind(...) abort
  silent! call system("git rev-parse --is-inside-work-tree >/dev/null 2>&1")

  if v:shell_error
    execute "Files " . join(a:000)
  else
    execute "GFiles -o -c --exclude-standard -- " . join(a:000)
  endif
endfunction


" Autocmds
"
augroup vimrcEx
  autocmd!

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

  " set tab expansion for go
  au BufNewFile,BufReadPre *.go setlocal shiftwidth=4 noexpandtab
augroup END


" Colorscheme
"
color monochrome

" Local Settings
"
if filereadable(expand("~/.local/etc/vimrc"))
  source ~/.local/etc/vimrc
endif
