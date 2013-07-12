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

" always show the statusline
set laststatus=2
" (disabled to allow vim-airline statusline)
"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

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
set listchars=tab:▸·,trail:·
set list
set nowrap
set linebreak

" more context while scrolling
set scrolloff=3
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
set wildignore+=*/.git/*,*/tmp/*,*/*.orig,*/.sass-cache/*,*.o,*.hi

" prevent tabs from becoming tabstops for some reason
au BufReadPost * set expandtab

" time out on mapping after three seconds,
" time out on key codes after a tenth of a second
set timeout timeoutlen=3000 ttimeoutlen=100

" fold based on syntax
set foldmethod=indent
set nofoldenable

" minimum width
set winwidth=100

" minimum height
set winheight=30


"""""""""""""
" Colorscheme
"""""""""""""

let g:solarized_termcolors = 256
let g:solarized_visibility = "low"
let g:solarized_contrast   = "high"
set t_Co=256
set background=dark
color solarized


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

" ctrlp
let g:ctrlp_working_path_mode = ''
let g:ctrlp_max_height = 20
let g:ctrlp_custom_ignore = '\.pyc$'

" use ack for :grep
set grepprg=ack\ -H\ --nocolor\ --nogroup\ --column\ $*
set grepformat=%f:%l:%c:%m

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
let g:rspec_command = "!clear && rspec {spec}"
map <Leader>r :call RunCurrentSpecFile()<CR>
map <Leader>R :call RunNearestSpec()<CR>
map <Leader>t :call RunAllSpecs()<CR>

" switch to last buffer
"nnoremap <leader>m <c-^>
nnoremap <leader>m :echo("don't be lazy! use \<C-^\>")<cr>

" check shell
"nnoremap <leader>z :!<cr>
nnoremap <leader>z :echo("don't be lazy! use \<C-z\> and `fg`")<cr>

" show cursorcol for lining things up, etc.
nnoremap <leader>\| :set cursorcolumn<CR>

" pretty print ruby object
vnoremap <leader>pp !ruby -e 'require "pp";pp eval(ARGF.read)'<cr>


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
augroup BWCCreateDir
  autocmd!
  autocmd BufWritePre * :call s:MkdirIfNeeded(expand('<afile>'), +expand('<abuf>'))
augroup END

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


""""""""
" Syntax
""""""""

" rspec
au BufRead,BufNewFile *_spec.rb set filetype=rspec

" sass
au BufRead,BufNewFile *.scss set filetype=scss


""""""""""""""""
" Local Settings
""""""""""""""""

" load local vimrc
if filereadable(expand("~/.vimrc.local"))
  source ~/.vimrc.local
endif
