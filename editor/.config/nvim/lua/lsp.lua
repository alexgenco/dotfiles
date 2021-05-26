local lsp = require'lspconfig'
local util = lsp.util
local function m(...) vim.api.nvim_set_keymap(...) end

-- Set defaults for all servers
util.default_config = vim.tbl_extend(
  "force",
  util.default_config, {
    -- Default on_attach function for setup, creating mappings, etc.
    on_attach = function(client, bufnr)
      require'completion'.on_attach(client, bufnr)
      require'lspfuzzy'.setup{}

      local opts = {noremap=true, silent=true}

      m('',  '<leader>a',     '<cmd>lua vim.lsp.buf.code_action()<cr>',        opts)
      m('n', '<leader><c-f>', '<cmd>lua vim.lsp.buf.formatting()<cr>',         opts)
      m('n', '<leader>r',     '<cmd>lua vim.lsp.buf.references()<cr>',         opts)
      m('n', '<leader>/',     '<cmd>lua vim.lsp.buf.workspace_symbol("")<cr>', opts)
      m('n', '<leader>d',     '<cmd>LspDiagnostics 0<cr>',                     opts)
      m('n', '<c-]>',         '<cmd>lua vim.lsp.buf.definition()<cr>',         opts)
      m('n', '<c-k>',         '<cmd>lua vim.lsp.buf.hover()<cr>',              opts)
    end
  }
)

lsp.gopls.setup{}

lsp.rust_analyzer.setup{
  settings = {
    ["rust-analyzer"] = {
      cmd = { "~/.local/bin/rust-analyzer" },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      }
    }
  }
}

local opts = {noremap=true, silent=true}

m('n', '<leader>f', '<cmd>lua require("telescope.builtin").find_files({hidden=true})<cr>', opts)
m('n', '<leader>b', '<cmd>lua require("telescope.builtin").buffers()<cr>', opts)
m('n', '<leader>g', '<cmd>lua require("telescope.builtin").grep_string()<cr>', opts)
m('n', '<leader>G', '<cmd>lua require("telescope.builtin").live_grep()<cr>', opts)
m('n', '<leader>h', '<cmd>lua require("telescope.builtin").help_tags()<cr>', opts)

vim.g.loaded_lsp = 1
