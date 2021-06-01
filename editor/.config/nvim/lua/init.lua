local lsp = require('lspconfig')
local util = lsp.util
local compe = require('compe')
local telescope = require('telescope')
local sorters = require('telescope.sorters')

-- Override telescope defaults
telescope.setup({
  defaults = {
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_fzy_sorter,
  }
})

-- Set LSP defaults for all servers
util.default_config = vim.tbl_extend(
  'force',
  util.default_config, {
    -- Default on_attach function for setup, creating mappings, etc.
    on_attach = function(client, bufnr)
      local function map(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
      local opts = {noremap=true, silent=true}

      map('n', '<leader><c-f>', '<cmd>lua vim.lsp.buf.formatting()<cr>', opts)
      map('n', 'K',             '<cmd>lua vim.lsp.buf.hover()<cr>',      opts)

      -- LSP-specific completion setup
      compe.setup({
        autocomplete = true,
        documentation = true,
        source = {
          nvim_lsp = true,
        },
      }, bufnr)
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
