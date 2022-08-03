local lsp = require('lspconfig')
local telescope = require('telescope')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

cmp.setup {
  sources = {
    {
      name = 'nvim_lsp'
    }
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-c>'] = cmp.mapping.abort(),
  }
}
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

-- Override telescope defaults
telescope.setup({
  defaults = {
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_fzy_sorter,
    mappings = {
      i = {
        ["<c-u>"] = false, -- Allow <c-u> to clear current query
        ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<c-space>"] = actions.toggle_selection,
      }
    }
  },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
})

telescope.load_extension("ui-select")

lsp.gopls.setup {
  capabilities = capabilities
}

lsp.rust_analyzer.setup {
  capabilities = capabilities,
  settings = {
    ['rust-analyzer'] = {
      cmd = { '~/.local/bin/rust-analyzer' },
      cargo = {
        loadOutDirsFromCheck = true
      },
      procMacro = {
        enable = true
      },
    }
  }
}

lsp.elixirls.setup {
  capabilities = capabilities,
  cmd = { "/usr/local/src/elixir-ls/language_server.sh" };
}
