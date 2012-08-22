""""""""""
" Pathogen
""""""""""

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()


""""""""""
" Settings
""""""""""

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

" fold based on syntax
set foldmethod=indent
set nofoldenable

" use relative line numbers
"if exists("&relativenumber")
"  set relativenumber
"  au BufReadPost * set relativenumber
"endif


"""""""""""""
" Keybindings
"""""""""""""

" use , as map leader
let mapleader = ","

" because I always mess this up
command! W w

" tab movement
nnoremap <D-j> :tabp<CR>
nnoremap <D-k> :tabn<CR>

" from :h ins-completion
function! CleverTab()
  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
    return "\<Tab>"
  else
    return "\<C-N>"
  endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

" omnicomplete
"inoremap <S-Tab> <C-x><C-o>

" use ; to enter command mode
"nnoremap ; :

" scroll viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" horizontal scroll
nnoremap <C-l> 3zl
nnoremap <C-h> 3zh

" <tab> to jump to matching character
nnoremap <tab> %

" PeepOpen
nnoremap <D-t> :PeepOpen<CR>

" powerline
"let g:Powerline_symbols = 'fancy'

" custom ack
nnoremap <D-f> :Ack! ''<left>

" ack something with a prefix (used below)
function! AckPrefix(pref)
  let prefix = a:pref
  let current_word=expand("<cword>")
  let query=prefix.current_word
  let command=":Ack! '".query."'"
  exec command
endfunction

" ack current word
nnoremap <Leader>ff :Ack!<CR>

" ack def of current word
nnoremap <Leader>fd :call AckPrefix("def ")<CR>

" ack class definition of current word
nnoremap <Leader>fc :call AckPrefix("class ")<CR>

" make Y go to end of line
nnoremap Y y$

" inline do ... end
vnoremap in J V:s/\s\+do\s\+/ { <CR> V:s/\s\+end\s*/ }<CR>:noh<CR>

" shortcut to edit .vimrc/.gvimrc
nnoremap <Leader>vv :tabedit $MYVIMRC<CR>
nnoremap <Leader>vg :tabedit $MYGVIMRC<CR>
if has('gui_running')
  nnoremap <Leader>vs :source $MYVIMRC<CR>:source $MYGVIMRC<CR>
else
  nnoremap <Leader>vs :source $MYVIMRC<CR>
endif

" turn off highlighting
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>""

" paren rainbow
"let g:vimclojure#ParenRainbow = 1
noremap <Leader>tp :call vimclojure#ToggleParenRainbow()<CR>

" open git blame in new buffer
nnoremap <Leader>gb :GitBlame<CR>

map <leader>r :wa<CR>:RunTest<CR>
map <leader>R :wa<CR>:RunFocusedTest<CR>

" splits
nnoremap <Leader>sV :vsplit<CR>
nnoremap <Leader>sH :split<CR>
nnoremap <Leader>sh <C-W><left>
nnoremap <Leader>sl <C-W><right>
nnoremap <Leader>sj <C-W><down>
nnoremap <Leader>sk <C-W><up>
nnoremap <Leader>ss <C-W>w

" strip trailing whitespace
nnoremap <Leader>SS :%s/\s\+$//e<CR> :noh<CR>

" use jj to exit insert mode
"inoremap jj <ESC>


"""""""""""
" Functions
"""""""""""

" open git blame in new buffer
command! GitBlame :call GitBlame()
function! GitBlame()
  let file = expand('%:p')
  exec ":tabnew | r !git --no-pager blame ".file
endfunction

" Run a test tool with the current file and line number
" The test tool is run in the last Terminal window
function! RunTestTool(tool_cmd)
  let dir = system('pwd')
  let applescript = "osascript -e '".'tell application "Terminal"'
  let applescript .= "\n"
  let applescript .= 'activate'
  let applescript .= "\n"
  let applescript .= 'do script "'.a:tool_cmd.'" in first window'
  let applescript .= "\n"
  let applescript .= 'end tell'."'"
  let foo = system(applescript)
endfunction

" If the file ends with _spec.rb, RunTestTool with rspec
" If the file ends with .feature, RunTestTool with cuke
command! RunFocusedTest :call RunFocusedTest()
function! RunFocusedTest()
  let spec = system('if [ x != "x"$(which spec) ] ; then echo -n spec ; elif [ x != "x"$(which rspec) ] ; then echo -n rspec ; fi')
  let filename = expand("%")
  if filename =~ '_spec\.rb$'
    let spec_command = "bundle exec ".spec." ".filename.":".line(".")
    call RunTestTool(spec_command)
    call CopyToClipboard(spec_command)
  endif
  if filename =~ '\.feature$'
    let spec_command = "bundle exec cuke ".filename.":".line(".")
    call RunTestTool(spec_command)
    call CopyToClipboard(spec_command)
  endif
endfunction

command! RunTests :call RunTests()
function! RunTests()
  let spec = system('if [ x != "x"$(which spec) ] ; then echo -n spec ; elif [ x != "x"$(which rspec) ] ; then echo -n rspec ; fi')
  let filename = expand("%")
  if filename =~ '_spec\.rb$'
    let spec_command = "bundle exec ".spec." ".filename
    call RunTestTool(spec_command)
    call CopyToClipboard(spec_command)
  endif
  if filename =~ '\.feature$'
    let spec_command = "bundle exec cuke ".filename
    call RunTestTool(spec_command)
    call CopyToClipboard(spec_command)
  endif
endfunction

function! CopyToClipboard(string)
  let @* = a:string
endfunction

""""""""
" Syntax
""""""""

" RABL syntax highlighting
au! BufNewFile,BufRead *.rabl setf ruby

" html5 syntax highlighting
"
" HTML 5 tags
syn keyword htmlTagName contained article aside audio bb canvas command datagrid
syn keyword htmlTagName contained datalist details dialog embed figure footer
syn keyword htmlTagName contained header hgroup keygen mark meter nav output
syn keyword htmlTagName contained progress time ruby rt rp section time video
syn keyword htmlTagName contained source figcaption

" HTML 5 arguments
syn keyword htmlArg contained autofocus autocomplete placeholder min max step
syn keyword htmlArg contained contenteditable contextmenu draggable hidden item
syn keyword htmlArg contained itemprop list sandbox subject spellcheck
syn keyword htmlArg contained novalidate seamless pattern formtarget manifest
syn keyword htmlArg contained formaction formenctype formmethod formnovalidate
syn keyword htmlArg contained sizes scoped async reversed sandbox srcdoc
syn keyword htmlArg contained hidden role
syn match   htmlArg "\<\(aria-[\-a-zA-Z0-9_]\+\)=" contained
syn match   htmlArg contained "\s*data-[-a-zA-Z0-9_]\+"


"""""""""""""
" Colorscheme
"""""""""""""

if has('gui_running')
  "set nolist
  "colorscheme molokai

  "colorscheme madeofcode

  "colorscheme ir_black

  "set nolist
  "colorscheme desert

  set background=dark
  let g:solarized_visibility="low"
  colorscheme solarized

  "set background=dark
  "colorscheme Tomorrow-Night
else
  colorscheme desert
endif