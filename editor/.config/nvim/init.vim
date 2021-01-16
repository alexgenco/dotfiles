set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

source ~/.vimrc

set inccommand=nosplit

augroup vimrcEx
  autocmd TermOpen * setlocal nonumber
augroup END

" lsp settings (see ~/.config/nvim/lua/lsp.lua)
if has('nvim-0.5') && !exists('g:loaded_lsp')
  lua require('lsp')
endif
