""""""""""
" Pathogen
""""""""""

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()


""""""""""
" Settings
""""""""""

set nocompatible
syntax enable
filetype plugin indent on
set backspace=indent,eol,start

" Always show the statusline
set laststatus=2

" Necessary to show unicode glyphs
set encoding=utf-8

" Line numbers
set number

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch

" Line endings
set listchars=tab:▸·,trail:·
set list
set nowrap
set linebreak

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
autocmd GUIEnter * set visualbell t_vb=

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
set wildignore+=*/.git/*,*/tmp/*,*/*.orig,*/.sass-cache/*,*.o,*.hi,*.pyc

" Prevent tabs from becoming tabstops for some reason
au BufReadPost * set expandtab

" Prevent O delay
set timeout timeoutlen=3000 ttimeoutlen=100

" Fold based on indent, disabled by default
set foldmethod=indent
set nofoldenable

" Minimum width
set winwidth=100

" Minimum height
set winheight=30

" Let buffers exist in the background
set hidden


"""""""""""""
" Colorscheme
"""""""""""""

" Move this into ~/.vimrc.local
"
"set t_Co=256
"set background=dark
"
"let g:solarized_termcolors = 256
"let g:solarized_visibility = "low"
"
"color solarized


""""""""""
" Autocmds
""""""""""

augroup vimrcEx
  " Clear all autocmds in the group
  autocmd!

  " When editing a file, always jump to the last known cursor position.
  " Don't do it for commit messages, when the position is invalid, or when
  " inside an event handler (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if &ft != 'gitcommit' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
augroup END


"""""""""""""
" Keybindings
"""""""""""""

let mapleader = ","

" Because I always mess these up
command! W w
command! Q q
nnoremap K k

" Open new split panes to right and bottom
set splitbelow
set splitright

" Use ack for :grep
set grepprg=ack\ -H\ --nocolor\ --nogroup\ --column\ $*

" Make Y go to end of line
nnoremap Y y$

" Inline do ... end
vnoremap in J V:s/\s\+do\s\+/ { <cr> V:s/\s\+end\s*/ }<cr>:noh<cr>

" Copy to system clipboard
vnoremap <leader>c "*y

" Shortcut to edit .vimrc
nnoremap <leader>vv :tabedit $MYVIMRC<cr>
nnoremap <silent> <leader>vs :source $MYVIMRC<cr>:nohlsearch<bar>:echo<cr>""

" Turn off highlighting
nnoremap <silent> <space> :nohlsearch<cr>

" Run tests
let g:rspec_command = "!clear && rspec {spec}"
map <leader>r :call RunCurrentSpecFile()<cr>
map <leader>R :call RunNearestSpec()<cr>
map <leader>t :call RunAllSpecs()<cr>


"""""""""""
" Functions
"""""""""""

" Make parent directories of new file before save
function! s:MkdirIfNeeded(file, buf)
  if empty(getbufvar(a:buf, '&buftype')) && a:file!~#'\v^\w+\:\/'
    let dir=fnamemodify(a:file, ':h')
    if !isdirectory(dir)
      call mkdir(dir, 'p')
    endif
  endif
endfunction
augroup BWCcreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkdirIfNeeded(expand('<afile>'), +expand('<abuf>'))
augroup END

" From :h ins-completion
function! CleverTab()
  if strpart(getline('.'), 0, col('.')-1) =~ '^\s*$'
    return "\<tab>"
  else
    return "\<C-N>"
  endif
endfunction
inoremap <tab> <C-R>=CleverTab()<cr>

" https://github.com/garybernhardt/dotfiles/blob/master/.vimrc
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

" Open git blame in new buffer
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
nnoremap <leader>gb :call GitBlame()<cr>


""""""""
" Syntax
""""""""

" Rspec
au BufRead,BufNewFile *_spec.rb set filetype=rspec


""""""""""""""""
" Local Settings
""""""""""""""""

" Load local vimrc
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
