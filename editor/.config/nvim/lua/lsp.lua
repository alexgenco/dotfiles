local lsp = require'lspconfig'

local on_attach = function(client, bufnr)
  require'completion'.on_attach(client, bufnr)

  require'lspfuzzy'.setup {
    methods = {'textDocument/codeAction', 'textDocument/references', 'textDocument/documentSymbol'}
  }

  local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local opts = { noremap=true, silent=true }

  map("",  '<leader>a',     '<cmd>lua vim.lsp.buf.code_action()<cr>',     opts)
  map("n", '<leader><c-f>', '<cmd>lua vim.lsp.buf.formatting()<cr>',      opts)
  map("n", '<leader>r',     '<cmd>lua vim.lsp.buf.references()<cr>',      opts)
  map("n", '<leader>/',     '<cmd>lua vim.lsp.buf.document_symbol()<cr>', opts)
  map("n", '<c-]>',         '<cmd>lua vim.lsp.buf.definition()<cr>',      opts)
  map("n", '<c-k>',         '<cmd>lua vim.lsp.buf.hover()<cr>',           opts)
end

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

vim.g.loaded_lsp = 1
