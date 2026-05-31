-- Plugins
--
-- to update, run `:lua vim.pack.update()`
vim.pack.add({
  'https://github.com/benmills/vimux',
  'https://github.com/vim-test/vim-test',
  'https://github.com/nvim-lua/plenary.nvim',
  {src = 'https://github.com/nvim-telescope/telescope.nvim', version = 'v0.2.2'},
  'https://github.com/nvim-telescope/telescope-ui-select.nvim',
})


-- Settings
--
vim.opt.encoding = 'utf-8'
vim.opt.backspace = {'indent', 'eol', 'start'}
vim.opt.number = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.shortmess:append('c')
vim.opt.listchars = {tab = '· ', trail = '·', extends = '»', nbsp = '⎵'}
vim.opt.list = true
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.showbreak = '↳ '
vim.opt.formatoptions:append('j')
vim.opt.breakindent = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.sidescroll = 0
vim.opt.scrolljump = 5
vim.opt.signcolumn = 'number'
vim.opt.autoread = true
vim.opt.omnifunc = 'syntaxcomplete#Complete'
vim.opt.wildmode = {'longest', 'list'}
vim.opt.complete = {'.', 'b', 'u', 't'}
vim.opt.completeopt = {'menuone', 'noselect'}
vim.opt.wildmenu = true
vim.opt.history = 1000
vim.opt.autoindent = true
vim.opt.cindent = true
vim.opt.shiftround = true
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.tabstop = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.title = true
vim.opt.swapfile = false
vim.opt.sessionoptions:remove('options')
vim.opt.undofile = true
vim.opt.backup = true
vim.opt.backupdir = {vim.fn.stdpath('state'), '/tmp'}
vim.opt.directory = {vim.fn.stdpath('state'), '/tmp'}
vim.opt.undodir = {vim.fn.stdpath('state'), '/tmp'}
vim.opt.foldmethod = 'manual'
vim.opt.foldenable = false
vim.opt.hidden = true
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.grepprg = "rg --hidden --glob '!.git' --vimgrep --no-heading --smart-case"
vim.opt.laststatus = 2
vim.opt.statusline = '%<%f (%{&ft}) %-4(%m%)%=%-10(%3p%% %4l:%-2c%)'
vim.opt.ruler = true
vim.opt.virtualedit = 'block'
vim.opt.startofline = false
vim.opt.cursorline = true
vim.opt.lazyredraw = true
vim.opt.report = 0
vim.opt.mouse = ''
vim.opt.updatetime = 500
vim.opt.fixeol = false
vim.opt.inccommand = 'nosplit'
vim.opt.winborder = 'single'

-- netrw
vim.cmd.packadd 'netrw'
vim.g.netrw_home = vim.fn.stdpath('data')
vim.g.netrw_banner = 0
vim.g.netrw_altv = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_list_hide = vim.fn['netrw_gitignore#Hide']()

-- vimux
vim.g.VimuxOrientation = 'h'
vim.g.VimuxHeight = '50'

-- vim-test
vim.g['test#strategy'] = vim.env.TMUX and 'vimux' or 'neovim'
vim.g['test#echo_command'] = 0
vim.g['test#preserve_screen'] = 1

-- fix incorrect sh non-POSIX highlighting
vim.g.is_posix = 1

-- telescope settings
local telescope = require('telescope')
local sorters = require('telescope.sorters')
local actions = require('telescope.actions')
telescope.setup({
  defaults = {
    file_sorter = sorters.get_fzy_sorter,
    generic_sorter = sorters.get_fzy_sorter,
    mappings = {
      i = {
        ['<esc>'] = actions.close,
        ['<c-u>'] = false,
        ['<c-q>'] = actions.smart_send_to_qflist + actions.open_qflist,
        ['<c-space>'] = actions.toggle_selection,
      }
    }
  },
  extensions = {
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {}
    }
  }
})
telescope.load_extension("ui-select")

-- lsp settings
vim.diagnostic.config({
  virtual_text = { current_line = true },
})
vim.lsp.config('*', {
  root_markers = { '.git', vim.uv.cwd() }
})

-- go lsp settings
vim.lsp.config.gopls = {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gotempl', 'gowork', 'gomod' },
  root_markers = { 'go.mod', 'go.work' },
}
vim.lsp.enable({ 'gopls' })

-- rust lsp settings
vim.lsp.config.rust_analyzer = {
  cmd = { 'rust-analyzer' },
  filetypes = { 'rust' },
  root_markers = { 'Cargo.toml', 'Cargo.lock' },
  settings = {
    ['rust-analyzer'] = {
      check = { command = 'clippy' },
      cargo = { buildScripts = { enable = true } },
      procMacro = { enable = true },
      diagnostics = { enable = true },
    }
  }
}
vim.lsp.enable({ 'rust_analyzer' })

-- erlang lsp settings
vim.lsp.config.erlangls = {
  cmd = { 'erlang_ls' },
  filetypes = { 'erlang' },
  single_file_support = true,
  root_markers = { 'rebar.config', 'erlang.mk', 'Emakefile' },
}
vim.lsp.enable({ 'erlangls' })

-- gleam lsp settings
vim.lsp.config.gleam = {
  cmd = { 'gleam', 'lsp' },
  filetypes = { 'gleam' },
  single_file_support = true,
  root_markers = { 'gleam.toml' },
}
vim.lsp.enable({ 'gleam' })


-- Keybindings
--
vim.g.mapleader = ','

-- move up/down by display lines
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', 'j', 'gj')

-- run tests using vim-test
vim.keymap.set('n', '<leader>t',     '<cmd>TestFile<cr>',    {silent = true})
vim.keymap.set('n', '<leader>T',     '<cmd>TestNearest<cr>', {silent = true})
vim.keymap.set('n', '<leader><c-t>', '<cmd>TestLast<cr>',    {silent = true})

-- make current buffer executable
vim.keymap.set('n', '<leader><c-x>', ':silent !chmod +x %<cr>', {silent = true})

-- telescope mappings
vim.keymap.set('n', '<leader>:',     '<cmd>Telescope command_history<cr>',                                         {silent = true})
vim.keymap.set('n', '<leader>F',     '<cmd>Telescope git_files show_untracked=true<cr>',                           {silent = true})
vim.keymap.set('n', '<leader>G',     '<cmd>Telescope live_grep<cr>',                                               {silent = true})
vim.keymap.set('n', '<leader>b',     '<cmd>Telescope buffers<cr>',                                                 {silent = true})
vim.keymap.set('n', '<leader>f',     '<cmd>Telescope find_files find_command=rg,-i,--hidden,--files,-g,!.git<cr>', {silent = true})
vim.keymap.set('n', '<leader>g',     '<cmd>Telescope grep_string<cr>',                                             {silent = true})
vim.keymap.set('n', '<leader>h',     '<cmd>Telescope help_tags<cr>',                                               {silent = true})


-- Autocmds
--
local augroup = vim.api.nvim_create_augroup('vimrcEx', {clear = true})

-- jump to last cursor position (ignoring git commit buffers)
vim.api.nvim_create_autocmd('BufReadPost', {
  group = augroup,
  pattern = '*',
  callback = function()
    if vim.bo.filetype ~= 'gitcommit' then
      local mark = vim.api.nvim_buf_get_mark(0, '"')
      if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
        vim.api.nvim_win_set_cursor(0, mark)
      end
    end
  end
})

-- check spelling for buffer types containing prose
vim.api.nvim_create_autocmd('FileType', {
  group = augroup,
  pattern = {'gitcommit', 'text'},
  callback = function()
    vim.opt_local.cindent = false
    vim.opt_local.smartindent = false
    vim.opt_local.spell = true
    vim.opt_local.spelllang = 'en_us'
  end
})

-- configure lsp on attach
vim.api.nvim_create_autocmd('LspAttach', {
  group = augroup,
  pattern = '*',
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    local bufnr = ev.buf

    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, {autotrigger = true})
    end

    vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'
    vim.bo[bufnr].formatexpr = 'v:lua.vim.lsp.formatexpr'

    local map = function(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, {noremap = true, silent = true, buffer = bufnr})
    end

    map('n', '<leader><c-f>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>')
    map('n', '<c-]>',         '<cmd>lua vim.lsp.buf.definition()<cr>')

    map('n', '<leader>i', '<cmd>Telescope lsp_implementations<cr>')
    map('n', '<leader>d', '<cmd>Telescope diagnostics bufnr=0<cr>')
    map('n', '<leader>D', '<cmd>Telescope diagnostics<cr>')
  end
})


-- Colorscheme
--
vim.opt.background = 'dark'
vim.cmd.colorscheme('quiet')
