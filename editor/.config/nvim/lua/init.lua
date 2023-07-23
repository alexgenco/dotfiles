local lsp = require('lspconfig')
local telescope = require('telescope')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
local cmp = require('cmp')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'vsnip' }
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-c>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = 'replace',
      select = true,
    },
  }
}

local capabilities = cmp_nvim_lsp.default_capabilities()

-- Override telescope defaults
telescope.setup({
  defaults = {
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_fzy_sorter,
    mappings = {
      i = {
        ["<esc>"] = actions.close,
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

local on_attach = function(client, bufnr)
  local map = function(type, key, value)
    vim.api.nvim_buf_set_keymap(bufnr, type, key, value, {noremap = true, silent = true})
  end

  -- lsp mappings
  map('n', '<leader>a',     '<cmd>lua vim.lsp.buf.code_action()<cr>')
  map('n', '<leader>m',     '<cmd>lua vim.lsp.buf.rename()<cr>')
  map('v', '<leader>a',     '<cmd>lua vim.lsp.buf.range_code_action()<cr>')
  map('n', '<leader><c-f>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
  map('n', '<c-]>',         '<cmd>lua vim.lsp.buf.definition()<cr>')
  map('n', 'K',             '<cmd>lua vim.lsp.buf.hover()<cr>')

  -- telescope.nvim lsp mappings
  map('n', '<leader>r', '<cmd>Telescope lsp_references<cr>')
  map('n', '<leader>d', '<cmd>Telescope diagnostics bufnr=0<cr>')
  map('n', '<leader>D', '<cmd>Telescope diagnostics<cr>')
end

lsp.gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}

lsp.terraformls.setup{
  capabilities = capabilities,
  on_attach = on_attach,
  filetypes = { "terraform", "tf" }
}

lsp.rust_analyzer.setup {
  capabilities = capabilities,
  on_attach = on_attach,
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
  on_attach = on_attach,
  cmd = { "/usr/local/src/elixir-ls/language_server.sh" }
}
