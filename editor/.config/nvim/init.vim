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
local lsp = require'lspconfig'
local on_attach = require'completion'.on_attach

lsp.rust_analyzer.setup{on_attach=on_attach}
lsp.gopls.setup{on_attach=on_attach}
EOF

  nnoremap <silent> gd <cmd>lua vim.lsp.buf.definition()<cr>
  nnoremap <silent> gu <cmd>lua vim.lsp.buf.references()<cr>
  nnoremap <silent> K  <cmd>lua vim.lsp.buf.hover()<cr>

  let g:loaded_lsp = 1
endif
