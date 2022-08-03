local lsp = require('lspconfig')
local telescope = require('telescope')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')

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
      },
    }
  }
}

lsp.elixirls.setup{
    cmd = { "/usr/local/src/elixir-ls/language_server.sh" };
}
