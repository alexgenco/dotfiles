""""""""""
" Pathogen
""""""""""

runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()


"""""""""""""
" Colorscheme
"""""""""""""

set background=dark
let g:solarized_visibility = "low"
let g:solarized_termcolors = 256
let g:solarized_underline  = 1

if !has('gui_running')
  set t_Co=256
endif
colorscheme solarized


""""""""""
" Settings
""""""""""

" use mouse in terminal vim
set mouse=a

" vertical line for insert mode, block for regular
let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

syntax enable
filetype plugin indent on
set backspace=indent,eol,start
set nocompatible

" always show the statusline
set laststatus=2
set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

" necessary to show unicode glyphs
set encoding=utf-8

" line numbers
set number

" no swap files
set noswapfile

" mouses
"set mouse=a

" persistent undo
set undofile
set undodir=~/.vim/undo

" search
set ignorecase
set smartcase
set incsearch
set hlsearch
highlight! Search cterm=underline
highlight! IncSearch cterm=underline

" line endings
set nolist
set listchars=tab:▸\ ,eol:¬,trail:·
set nowrap
set linebreak

" more context while scrolling
set scrolloff=3
set sidescrolloff=15
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
"set nobackup
"set nowb

" store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp

" ignore filetypes
set wildignore+=*/.git/*,*/tmp/*,*/*.orig

" prevent tabs from becoming tabstops for some reason
au BufReadPost * set expandtab

" fold based on syntax
set foldmethod=indent
set nofoldenable

set nocursorline

" use relative line numbers
"if exists("&relativenumber")
  "set relativenumber
  "au BufReadPost * set relativenumber
"endif

" tagbar
nnoremap <leader>` :TagbarToggle<cr>


"""""""""""""
" Keybindings
"""""""""""""

" use , as map leader
let mapleader = ","

" because I always mess this up
command! W w

" stop doing this
nnoremap K k

" save with one hand while sippin brews
" with the other
nnoremap <leader><leader> :w<cr>

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

" move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" vertical split
nnoremap <Leader>ss :vsplit<CR><c-w>l

" horizontal split
nnoremap <Leader>sh :split<CR><c-w>j

" resize splits
nnoremap <Leader>s= <c-w>=

" automatic split resizing
set winwidth=84
set winheight=10
set winminheight=10
set winheight=999

" rotate splits
nnoremap <Leader>sr <c-w>r

" omnicomplete
"inoremap <S-Tab> <C-x><C-o>

" use ; to enter command mode
"nnoremap ; :

" scroll viewport faster
"nnoremap <C-e> 3<C-e>
"nnoremap <C-y> 3<C-y>

" horizontal scroll
"nnoremap <M-h> 3zl
"nnoremap <M-l> 3zh

" <tab> to jump to matching character
"nnoremap <tab> %

" scratch buffer in new split
nnoremap <leader>sk :Sscratch<CR>

" PeepOpen
if has('gui_running')
  let g:loaded_ctrlp = 0
  nnoremap <D-t> :PeepOpen<CR>
end

" ctrlp
let g:ctrlp_working_path_mode = ''
let g:ctrlp_by_filename = 1
let g:ctrlp_max_height = 40

" powerline
"let g:Powerline_symbols = 'fancy'

" custom ack
if has("gui_running")
  nnoremap <D-f> :Ack! ''<left>
else
  nnoremap <Leader>a :Ack! ''<left>
end

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

" ack def of current word (Ruby)
nnoremap <Leader>fd :call AckPrefix("def (self\.)*")<CR>

" ack class definition of current word (Ruby)
nnoremap <Leader>fc :call AckPrefix("class ")<CR>

" make Y go to end of line
nnoremap Y y$

" inline do ... end
vnoremap in J V:s/\s\+do\s\+/ { <CR> V:s/\s\+end\s*/ }<CR>:noh<CR>

" copy to system clipboard
vnoremap <leader>c "*y
vnoremap <leader>x "*d

" comments
vnoremap <leader># :s/^/#/g<CR>:noh<CR>

" shortcut to edit .vimrc/.gvimrc
nnoremap <Leader>vv :tabedit $MYVIMRC<CR>
nnoremap <Leader>vg :tabedit $MYGVIMRC<CR>
if has('gui_running')
  nnoremap <Leader>vs :source $MYVIMRC<CR>:source $MYGVIMRC<CR>:noh<CR>
else
  nnoremap <Leader>vs :source $MYVIMRC<CR>:noh<CR>
endif

" turn off highlighting
nnoremap <silent> <Space> :nohlsearch<Bar>:echo<CR>""

" paren rainbow
"let g:vimclojure#ParenRainbow = 1
"noremap <Leader>tp :call vimclojure#ToggleParenRainbow()<CR>

" run tests
"if has('gui_running')
"  let g:vroom_map_keys = 0
"  map <leader>r :wa<CR>:RunTest<CR>
"  map <leader>R :wa<CR>:RunFocusedTest<CR>
"else
  let g:vroom_write_all = 1
  let g:vroom_detect_spec_helper = 1
  let g:vroom_clear_screen = 1

  map <leader>r :VroomRunTestFile<CR>
  map <leader>R :VroomRunNearestTest<CR>
"endif

" strip trailing whitespace
nnoremap <Leader>SS :%s/\s\+$//e<CR> :noh<CR>

" use jj to exit insert mode
"inoremap jj <ESC>

" switch to last buffer
nnoremap <leader>m <c-^>

" send to background
"nnoremap <leader>Z <c-z>

" check shell
nnoremap <leader>z :!<cr>

" visual select last put
nnoremap <leader>V `[v`]

"""""""""""
" Functions
"""""""""""

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
  tabnew
  r!git --no-pager blame #
  set buftype=nofile
  set bufhidden=hide
  g/^$/d
  exec ":".line
endfunction
nnoremap <Leader>gb :GitBlame<CR>

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

" clojure syntax highlighting
let g:clj_highlight_builtins=1
au BufRead,BufNewFile *.clj setf clojure

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