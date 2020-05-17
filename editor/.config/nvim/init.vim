set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

source ~/.vimrc

set inccommand=nosplit

autocmd vimrcEx TermOpen * setlocal nonumber

" setup lsp
if has('nvim-0.5.0')
  silent! lua require'nvim_lsp'.rust_analyzer.setup{}
  silent! lua require'nvim_lsp'.gopls.setup{}

  function CleanFormat() abort
    mkview!
    lua vim.lsp.buf.formatting()
    silent! loadview
    write
  endfunction

  nmap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
  nmap <silent> <leader><c-f> <cmd>call CleanFormat()<cr>
endif
