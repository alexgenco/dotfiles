" Links
"   http://stevelosh.com/blog/2010/09/coming-home-to-vim
"   http://robots.thoughtbot.com/post/27041742805/vim-you-complete-me
"   https://github.com/Casecommons/vim-config

" pathogen
runtime bundle/vim-pathogen/autoload/pathogen.vim
call pathogen#infect()
call pathogen#helptags()

" essentials
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
set numberwidth=5

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

" because I always mess this up
command W w

" more context while scrolling
set scrolloff=3
set sidescrolloff=15
set sidescroll=1

" automatically read files changed outside vim
set autoread

" tabs
nnoremap <D-j> :tabp<CR>
nnoremap <D-k> :tabn<CR>
set tabpagemax=100

" prevent automatically adding newlines to end of file
set binary

" tab completion
set ofu=syntaxcomplete#Complete
set wildmode=list:longest
set complete=.,b,u,]
set completeopt=preview

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
nnoremap ; :

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

" scroll viewport faster
nnoremap <C-e> 3<C-e>
nnoremap <C-y> 3<C-y>

" horizontal scroll
nnoremap <C-k> 3zl
nnoremap <C-j> 3zh

" <tab> to jump to matching character
nnoremap <tab> %

" turn off swp files
set nobackup
set nowb

" ignore filetypes
set wildignore+=*/.git/*,*/tmp/*,*/*.orig

" PeepOpen
nnoremap <D-t> :PeepOpen<CR>

" use , as map leader
let mapleader = ","

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

" make Y and D do their thing to the end of the line
nnoremap Y y$
nnoremap D d$

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

" RABL syntax highlighting
au! BufNewFile,BufRead *.rabl setf ruby

" open git blame in new buffer
nnoremap <Leader>gb :call GitBlame()<CR>
function! GitBlame()
  let file = expand('%:p')
  exec ":tabnew | r !git --no-pager blame ".file
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RUN TESTS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" copy relevant rspec command for current file
"nnoremap <Leader>r :call CopyRSpecCommand()<CR>
"
"" copy relevant rspec command for current line
"nnoremap <Leader>R :call CopyRSpecCommand(1)<CR>
"
"let g:rspec_helper_rspec_command = "bundle exec rspec"
"
"function! CopyRSpecCommand(...)
"  let line_or_blank = (a:0 > 0 && a:1) ? (' -l ' . line('.')) : ''
"  let command = g:rspec_helper_rspec_command . " " . expand("%:p:.") . line_or_blank
"  call CopyToClipboard(command)
"endfunction
"
"function! CopyToClipboard(string)
"  let @* = a:string
"  echo '"' . a:string . '" copied'
"endfunction

map <leader>r :wa<CR>:RunTest<CR>
map <leader>R :wa<CR>:RunFocusedTest<CR>

" Run a test tool with the current file and line number
" The test tool is run in the last Terminal window
function! RunTestTool(tool_cmd)
  let dir = system('pwd')
  let applescript = "osascript -e '".'tell application "Terminal"'
  let applescript .= "\n"
  let applescript .= 'activate'
  let applescript .= "\n"
  let applescript .= 'do script "'.a:tool_cmd.'" in last window'
  let applescript .= "\n"
  let applescript .= 'end tell'."'"
  let foo = system(applescript)
endfunction

" If the file ends with _spec.rb, RunTestTool with rspec
" If the file ends with .feature, RunTestTool with cuke
command! RunFocusedTest :call RunFocusedTest()
function! RunFocusedTest()
  let spec_command = system('if [ x != "x"$(which spec) ] ; then echo -n spec ; elif [ x != "x"$(which rspec) ] ; then echo -n rspec ; fi')
  let filename = expand("%")
  if filename =~ '_spec\.rb$'
    call RunTestTool("bundle exec ".spec_command." ".expand("%").":".line("."))
  endif
  if filename =~ '\.feature$'
    call RunTestTool("cuke ".expand("%").":".line("."))
  endif
endfunction

command! RunTests :call RunTests()
function! RunTests()
  let spec_command = system('if [ x != "x"$(which spec) ] ; then echo -n spec ; elif [ x != "x"$(which rspec) ] ; then echo -n rspec ; fi')
  let filename = expand("%")
  if filename =~ '_spec\.rb$'
    call RunTestTool("bundle exec ".spec_command." ".expand("%"))
  endif
  if filename =~ '\.feature$'
    call RunTestTool("cuke ".expand("%"))
  endif
endfunction
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set colorscheme for terminal vim
if !has('gui_running')
  colorscheme desert
endif

" splits
nnoremap <Leader>sv :vsplit<CR>
nnoremap <Leader>sh :split<CR>
nnoremap <Leader>ss <C-W>w

" use relative line numbers
"if exists("&relativenumber")
"  set relativenumber
"  au BufReadPost * set relativenumber
"endif

" ctrlp (USING PEEPOPEN INSTEAD)
"let g:ctrlp_map = '<D-t>'
"let g:ctrlp_working_path_mode = 0
"let g:ctrlp_match_window_reversed = 0
"let g:ctrlp_open_new_file = 't'
"let g:ctrlp_by_filename = 0
"let g:ctrlp_max_height = 30
"let g:ctrlp_dotfiles = 0
"let g:ctrlp_mruf_last_entered = 1
"let g:ctrlp_prompt_mappings = {
"      \ 'AcceptSelection("e")': ['<s-cr>'],
"      \ 'AcceptSelection("t")': ['<cr>', '<c-m>'],
"      \ }