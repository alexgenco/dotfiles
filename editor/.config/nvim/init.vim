set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

source ~/.vimrc

set inccommand=nosplit

augroup vimrcEx
  autocmd TermOpen * setlocal nonumber
augroup END

" setup lsp
if has('nvim-0.5.0')
silent! lua << EOF
local lsp = require'nvim_lsp'

lsp.rust_analyzer.setup({})
lsp.gopls.setup({})
EOF
endif

nmap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
