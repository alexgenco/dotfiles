set runtimepath+=~/.vim,~/.vim/after
set packpath+=~/.vim

source ~/.vimrc

set inccommand=nosplit

augroup vimrcEx
  autocmd TermOpen * setlocal nonumber

  autocmd FileType *
        \ map <silent> <buffer> <leader>a <cmd>echoerr "No LSP registered for this filetype (".&filetype.")."<cr>
        \ | nnoremap <silent> <buffer> <c-[> <cmd>echoerr "No LSP registered for this filetype (".&filetype.")."<cr>
        \ | nnoremap <silent> <buffer> <c-k>  <cmd>echoerr "No LSP registered for this filetype (".&filetype.")."<cr>
augroup END

" LSP Settings
"
if has('nvim-0.5') && !exists('g:loaded_lsp')
  lua << EOF
local lsp = require'lspconfig'
local on_attach = require'completion'.on_attach

lsp.gopls.setup{on_attach=on_attach}
lsp.rust_analyzer.setup({
  on_attach = on_attach,
  settings = {
    ["rust-analyzer"] = {
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      }
    }
  }
})
EOF

  augroup lsp
    autocmd! FileType rust,go
          \ map <silent> <buffer> <leader>a <cmd>lua vim.lsp.buf.code_action()<cr>
          \ | nnoremap <silent> <buffer> <leader><c-f> <cmd>lua vim.lsp.buf.formatting_sync({}, 500)<cr>
          \ | nnoremap <silent> <buffer> <c-]> <cmd>lua vim.lsp.buf.definition()<cr>
          \ | nnoremap <silent> <buffer> <c-[> <cmd>lua vim.lsp.buf.references()<cr>
          \ | nnoremap <silent> <buffer> <c-k> <cmd>lua vim.lsp.buf.hover()<cr>
  augroup END

  let g:loaded_lsp = 1
endif
