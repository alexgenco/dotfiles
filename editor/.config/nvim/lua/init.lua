local telescope = require('telescope')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')

-- Override telescope defaults
telescope.setup({
  defaults = {
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_fzy_sorter,
    border = false, -- prefer `winborder`
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

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end

    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    vim.api.nvim_buf_set_option(bufnr, 'formatexpr', 'v:lua.vim.lsp.formatexpr')

    local map = function(type, key, value)
      vim.api.nvim_buf_set_keymap(bufnr, type, key, value, {noremap = true, silent = true})
    end

    -- lsp mappings
    map('n', '<leader><c-f>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    map('n', '<c-]>',         '<cmd>lua vim.lsp.buf.definition()<cr>')
    map('n', '<c-k>',         '<cmd>lua vim.diagnostic.open_float()<cr>')

    -- telescope.nvim lsp mappings
    map('n', '<leader>r', '<cmd>Telescope lsp_references<cr>')
    map('n', '<leader>i', '<cmd>Telescope lsp_implementations<cr>')
    map('n', '<leader>d', '<cmd>Telescope diagnostics bufnr=0<cr>')
    map('n', '<leader>D', '<cmd>Telescope diagnostics<cr>')
  end
})

vim.diagnostic.config({
  virtual_text = { current_line = true },
})

vim.lsp.config('*', {
  root_markers = { '.git', vim.uv.cwd() },
  on_attach = on_attach,
})

vim.lsp.config.gopls = {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gotempl', 'gowork', 'gomod' },
  root_markers = { 'go.mod', 'go.work' },
}

vim.lsp.enable({ 'gopls' })

vim.lsp.config.rust_analyzer = {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'Cargo.lock' },
  settings = {
    ['rust-analyzer'] = {
      checkOnSave = { command = 'clippy' },
      cargo = { loadOutDirsFromCheck = true },
      procMacro = { enable = true },
      diagnostics = { enable = true, enableExperimental = true },
    }
  }
}

vim.lsp.enable({ 'rust_analyzer' })

vim.lsp.config.erlangls = {
  cmd = { 'erlang_ls' },
  filetypes = { 'erlang' },
  single_file_support = true,
  root_markers = { 'rebar.config', 'erlang.mk', 'Emakefile' },
}

vim.lsp.enable({ 'erlangls' })

--lsp.gleam.setup {
--  capabilities = capabilities,
--  on_attach = on_attach
--}

