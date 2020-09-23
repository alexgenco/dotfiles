set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

source ~/.vimrc

set inccommand=nosplit

augroup vimrcEx
  autocmd TermOpen * setlocal nonumber
augroup END


" LSP Settings
"
if has('nvim-0.5') && !exists('g:loaded_lsp')
  lua << EOF
local lsp = require('nvim_lsp')

lsp.rust_analyzer.setup{}
lsp.gopls.setup{}
EOF

  autocmd Filetype rust,go setlocal omnifunc=v:lua.vim.lsp.omnifunc
  let g:loaded_lsp = 1
endif
