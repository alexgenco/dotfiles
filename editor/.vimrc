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
Plug 'benmills/vimux'
Plug 'vim-test/vim-test'
Plug 'vim-ruby/vim-ruby'

if has('nvim-0.7')
  Plug 'neovim/nvim-lspconfig'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.8' }
  Plug 'nvim-telescope/telescope-ui-select.nvim'
endif

if filereadable(expand("~/.local/etc/vimrc.plugins"))
  source ~/.local/etc/vimrc.plugins
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

" only enable manual folding
set foldmethod=manual
set nofoldenable

" let buffers exist in the background
set hidden

" open new split panes to right and bottom
set splitbelow splitright

" use ripgrep for :grep
set grepprg=rg\ --hidden\ --glob\ '!.git'\ --vimgrep\ --no-heading\ --smart-case

" status line
set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-10(%3p%%\ %4l:%-2c%)
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

" don't change EOL
set nofixeol

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
elseif exists("$WEZTERM_PANE")
  let test#strategy = "wezterm"
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

" compe (this is overridden for LSP languages in init.lua)
let g:compe = {
      \ 'autocomplete': v:false,
      \ 'source': {
      \   'path': v:true,
      \   'buffer': v:true,
      \   'tags': v:true,
      \   }
      \ }


" Keybindings
"
let mapleader = ","

" make Y go to end of line
nnoremap Y y$

" move by visual line
nnoremap k gk
nnoremap j gj

" navigation (these are now default in nvim 0.11)
nnoremap <silent> ]q <cmd>cnext<cr>
nnoremap <silent> [q <cmd>cprevious<cr>
nnoremap <silent> ]b <cmd>bnext<cr>
nnoremap <silent> [b <cmd>bprevious<cr>

" run tests
nnoremap <silent> <leader>t     <cmd>TestFile<cr>
nnoremap <silent> <leader>T     <cmd>TestNearest<cr>
nnoremap <silent> <leader><c-t> <cmd>TestLast<cr>
nnoremap <silent> <leader>v     <cmd>call EditDotfiles()<cr>
nnoremap <silent> <leader>s     <cmd>call NewScratch()<cr>

" make current file executable
nnoremap <silent> <leader><c-x> :silent !chmod +x %<cr>

" telescope.nvim mappings
nnoremap <silent> <leader>: <cmd>Telescope command_history<cr>
nnoremap <silent> <leader>F <cmd>Telescope git_files show_untracked=true<cr>
nnoremap <silent> <leader>G <cmd>Telescope live_grep<cr>
nnoremap <silent> <leader>b <cmd>Telescope buffers<cr>
nnoremap <silent> <leader>f <cmd>Telescope find_files find_command=rg,-i,--hidden,--files,-g,!.git<cr>
nnoremap <silent> <leader>g <cmd>Telescope grep_string<cr>
nnoremap <silent> <leader>h <cmd>Telescope help_tags<cr>
nnoremap <silent> <leader>r <cmd>Telescope lsp_references<cr>
" more lsp mappings defined in `$XDG_CONFIG_HOME/nvim/lua/init.lua`
"


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

" open a tab for editing dotfiles, and reload after close
function! EditDotfiles() abort
  tabnew ~/.vimrc
  tcd ~/dev/dotfiles
  autocmd BufWinLeave <buffer> source $MYVIMRC
endfunction

" open a scratch buffer
function! NewScratch() abort
  tabnew
  setlocal buftype=nofile bufhidden=hide noswapfile
endfunction


" Autocmds
"
augroup vimrcEx
  autocmd!

  " create parent directories when saving a new file
  autocmd BufWritePre * call MkdirIfNeeded(expand("<afile>"), +expand("<abuf>"))

  " don't show line numbers in nvim terminal buffers
  if exists("##TermOpen")
    autocmd TermOpen term://* setlocal nonumber | startinsert
  endif

  " jump to the last known cursor position
  autocmd BufReadPost *
        \ if &ft != "gitcommit" && line("'\"") > 0 && line("'\"") <= line("$") |
        \   exe "normal g`\"" |
        \ endif

  " set tab expansion for go
  au BufNewFile,BufReadPre *.go setlocal shiftwidth=4 noexpandtab

  " remove autoindent in git commits, enable spelling
  au FileType gitcommit,text setl nocin nosi spell spelllang=en_us
augroup END


" Colorscheme
"

set background=dark
colorscheme quiet

" Local Settings
"
if filereadable(expand("~/.local/etc/vimrc"))
  source ~/.local/etc/vimrc
endif
