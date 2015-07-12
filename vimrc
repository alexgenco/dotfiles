"""""""""
" Bundles
"""""""""

set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'gmarik/Vundle.vim'
Plugin 'thoughtbot/vim-rspec'
Plugin 'altercation/vim-colors-solarized'
Plugin 'wting/rust.vim'

call vundle#end()

""""""""""
" Settings
""""""""""

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

" Allow 100 tabs at once
set tabpagemax=100

" Prevent automatically adding newlines to end of file
set binary

" Tab completion
set ofu=syntaxcomplete#Complete
set wildmode=longest,list
set complete=.,b,u,]
set completeopt=longest,menuone
set wildmenu

" Mode lines
set modelines=5
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

" Use ack for :grep
set grepprg=git\ grep\ -n\ $*

" Status line
set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-8(%4l:%c%)

" Move cursor beyond end of line in visual block mode
set virtualedit=block

"""""""""""""
" Keybindings
"""""""""""""

let mapleader = "\\"

" Because I always mess these up
command! W w
command! Q q
nnoremap K k

" Make Y go to end of line
nnoremap Y y$

" Inline do ... end
vnoremap in J V:s/\s\+do\s\+/ { <cr> V:s/\s\+end\s*/ }<cr>:nohlsearch<cr>

" Copy to system clipboard
vnoremap <leader>c "*y

" Shortcut to edit .vimrc
nnoremap <leader>vv :tabedit $MYVIMRC<cr>
nnoremap <silent> <leader>vs :source $MYVIMRC<cr>:nohlsearch<cr>

" Turn off highlighting
nnoremap <silent> <space> :nohlsearch<cr>

" Ctrl p
let g:ctrlp_map = "<leader>ff"

" Run tests
let g:rspec_command = "!clear && bundle exec rspec {spec}"
nnoremap <leader>rb :call RunCurrentSpecFile()<cr>
nnoremap <leader>rf :call RunNearestSpec()<cr>
nnoremap <leader>ra :call RunAllSpecs()<cr>
nnoremap <leader>rl :call RunLastSpec()<cr>

" Custom function mappings (see Functions section)
nnoremap <leader>n :call RenameFile()<cr>
nnoremap <leader>gb :call GitBlame()<cr>


"""""""""""
" Functions
"""""""""""

" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
function! RenameFile()
  let old_name = expand("%")
  let new_name = input("New file name: ", expand("%"), "file")
  if new_name != "" && new_name != old_name
    exec ":saveas " . new_name
    exec ":silent !rm " . old_name
    redraw!
  endif
endfunction

" Open git blame in new tab
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

" Make parent directories of new file before save
function! MkdirIfNeeded(file, buf)
  if empty(getbufvar(a:buf, "&buftype")) && a:file!~#"\v^\w+\:\/"
    let dir=fnamemodify(a:file, ":h")
    if !isdirectory(dir)
      call mkdir(dir, "p")
    endif
  endif
endfunction


""""""""""
" Autocmds
""""""""""

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


"""""""""""""
" Colorscheme
"""""""""""""

set background=dark
colorscheme desert


""""""""""""""""
" Local settings
""""""""""""""""

if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
