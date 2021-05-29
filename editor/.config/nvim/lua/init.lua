local lsp = require('lspconfig')
local util = lsp.util

-- Set defaults for all servers
util.default_config = vim.tbl_extend(
  'force',
  util.default_config, {
    -- Default on_attach function for setup, creating mappings, etc.
    on_attach = function(client, bufnr)
      require('lspfuzzy').setup{}

      local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local opts = {noremap=true, silent=true}

      map('',  '<leader>a',     '<cmd>lua vim.lsp.buf.code_action()<cr>',        opts)
      map('n', '<leader><c-f>', '<cmd>lua vim.lsp.buf.formatting()<cr>',         opts)
      map('n', '<leader>r',     '<cmd>lua vim.lsp.buf.references()<cr>',         opts)
      map('n', '<leader>/',     '<cmd>lua vim.lsp.buf.workspace_symbol("")<cr>', opts)
      map('n', '<leader>d',     '<cmd>LspDiagnosticsAll<cr>',                    opts)
      map('n', '<leader>D',     '<cmd>LspDiagnostics 0<cr>',                     opts)
      map('n', '<c-]>',         '<cmd>lua vim.lsp.buf.definition()<cr>',         opts)
      map('n', 'K',             '<cmd>lua vim.lsp.buf.hover()<cr>',              opts)
    end
  }
)

lsp.gopls.setup{}

lsp.rust_analyzer.setup{
  settings = {
    ['rust-analyzer'] = {
      cmd = { '~/.local/bin/rust-analyzer' },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      }
    }
  }
}
