vim.loader.enable()

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Mapleaders
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Configurations 
vim.g.nocompatible = true
vim.g.ttimeoutlen = 0
vim.g.autoread = true
vim.g.smartcase = true
vim.g.incsearch = true
vim.g.nomodeline = true
vim.g.ruler = true
vim.g.mouse = "a"
vim.g.encoding = "utf-8"
vim.g.ttyfast = true

vim.opt.number = true
vim.opt.relativenumber = true

vim.cmd("syntax on")
vim.cmd("set clipboard+=unnamedplus")
--vim.cmd("filetype plugin indent on")

-- Colorscheme
vim.t_Co = 256
--vim.cmd.colorscheme("industry")

--- Swap, Backup, Undo Directories
vim.opt.directory = vim.env.HOME .. "/.cache/nvim/swap"
vim.opt.backupdir = vim.env.HOME .. "/.cache/nvim/backup"
vim.opt.undodir = vim.env.HOME .. "/.cache/nvim/undo"

-- Diagnostics
vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = false,
  underline = true,
})
vim.keymap.set('n', "<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", { noremap = true, silent = true, desc = "Diagnostic Float" })

-- Setup lazy.nvim
require("lazy").setup {
  spec = {
    { "dstein64/vim-startuptime", event = "VeryLazy" },

    { "echasnovski/mini.nvim", version = "*" },
    { "nvim-tree/nvim-web-devicons", opts = {} }, 

    { "nvim-lua/plenary.nvim" },
    { "BurntSushi/ripgrep" },
    {  "nvim-treesitter/nvim-treesitter" },
    { "sbdchd/neoformat" },
    { "Darazaki/indent-o-matic" },
    { "nvim-lualine/lualine.nvim" },

    { "nvim-telescope/telescope.nvim", tag = "0.1.8" },
    --{ "nvim-telescope/telescope-fzf-native.nvim", build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release" },

    { "neovim/nvim-lspconfig" },
    { "williamboman/mason.nvim" },
    { "williamboman/mason-lspconfig.nvim" },

    { "hrsh7th/nvim-cmp" },
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-vsnip" },
    { "hrsh7th/vim-vsnip" },
    { "onsails/lspkind.nvim" },

    { "mfussenegger/nvim-dap" },
    { "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} },
    { "igorlfs/nvim-dap-view" },
    { "theHamsta/nvim-dap-virtual-text" },
    {"LiadOz/nvim-dap-repl-highlights"},

    { "windwp/nvim-autopairs", event = "InsertEnter", config = true },
    { "hiphish/rainbow-delimiters.nvim" },

    { "folke/which-key.nvim",  event = "VeryLazy", opts = { preset = "helix" } },
  },
  defaults = { lazy = false, },
  install = { colorscheme = { "industry" } },
  checker = { enabled = false },
  performance = {
    rtp = {
      disabled_plugins = {
        "netrw", "netrwPlugin", "netrwSettings", "netrwFileHandlers", "gzip", "zip", "zipPlugin", "tar", "tarPlugin",
        "getscript", "getscriptPlugin", "vimball", "vimballPlugin", "2html_plugin", "logipat", "rrhelper",
        "spellfile_plugin", "matchit"
      },
    },
  },
}
require("mini.icons").setup()
require("rainbow-delimiters.setup").setup()

-- Indentation Magic
require("indent-o-matic").setup{}

-- DAP
require("nvim-dap-virtual-text").setup()
require('nvim-dap-repl-highlights').setup()
local dap = require("dap")
dap.adapters.gdb = {
  type = "executable",
  command = "gdb",
  args = { "--interpreter=dap", "--eval-command", "set print pretty on" }
}
dap.configurations.c = {
  {
    name = "Launch",
    type = "gdb",
    request = "launch",
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopAtBeginningOfMainSubprogram = false,
  }}
vim.keymap.set("n", "<leader>dt", require("dap-view").toggle, { desc = "Toggle Debug View" })
vim.keymap.set("n", "<leader>dbt", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Start/Continue Debugging" })
vim.keymap.set("n", "<leader>dsn", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dsi", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>dso", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<Leader>dr", dap.run_last, { desc = "Run last configuration" })
vim.keymap.set({'n', 'v'}, "<Leader>dh", require('dap.ui.widgets').hover, { desc = "Hover Information" })
vim.keymap.set({'n', 'v'}, "<Leader>dp", require('dap.ui.widgets').preview, { desc = "Preview Information" })

-- Lsp/Mason
require("mason").setup()
require("mason-lspconfig").setup()
--require("mason-lspconfig").setup_handlers {
--  function (server_name)
--    local capabilities = require('cmp_nvim_lsp').default_capabilities()
--    require("lspconfig")[server_name].setup { capabilities = capabilities }
--  end
--}
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
vim.api.nvim_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)

-- Telescope
require("telescope").setup()
--require("telescope").load_extension("fzf")
local pickers = require("telescope.builtin")
vim.keymap.set('n', "<leader>tf", pickers.find_files, { desc = "Telescope find files" })
vim.keymap.set('n', "<leader>ta", function() pickers.find_files({hidden=true, no_ignore=true}) end, { desc = "Telescope all files" })
vim.keymap.set('n', "<leader>tg", pickers.live_grep, { desc = "Telescope live grep" })
vim.keymap.set('n', "<leader>tga", function() pickers.live_grep({hidden=true, no_ignore=true}) end, { desc = "Telescope live grep all files" })
vim.keymap.set('n', "<leader>tb", pickers.buffers, { desc = "Telescope buffers" })
vim.keymap.set('n', "<leader>th", pickers.help_tags, { desc = "Telescope help tags" })
vim.keymap.set('n', "<leader>tc", pickers.commands, { desc = "Telescope commands" })
vim.keymap.set('n', "<leader>ts", pickers.lsp_document_symbols, { desc = "Telescope document symbols" })
vim.keymap.set('n', "<leader>td", pickers.diagnostics, { desc = "Telescope document symbols" })
vim.keymap.set('n', "<leader>tgs", pickers.git_status, { desc = "Telescope git status" })
vim.keymap.set('n', "<leader>tgc", pickers.git_commits, { desc = "Telescope git commits" })

-- Treesitter
require("nvim-treesitter.configs").setup { 
	auto_install = true, 
	highlight = { enable = true },
	indent = { enable = true }
}

-- Completion
vim.opt.completeopt = { "menu", "menuone", "noselect" }
local cmp = require("cmp")
local lspkind = require('lspkind')
cmp.setup {
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  view = { entries = "custom" },
  mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }),
    }),
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      --{ name = 'vsnip' }, -- For vsnip users.
    }),
  formatting = { format = lspkind.cmp_format() }
}

-- Status Line
require("lualine").setup {
  options = {
    theme = "16color",
    section_separators = '', component_separators = ''
  },
}

-- Neoformatter
vim.api.nvim_exec([[
	augroup fmt
  autocmd!
  autocmd BufWritePre * undojoin | Neoformat
	augroup END
]], false)

-- Sane Keybindings
vim.keymap.set('n', "<leader>bn", ":bn<CR>", { desc = "Buffer Next" })
vim.keymap.set('n', "<leader>bp", ":bp<CR>", { desc = "Buffer Prev" })
vim.keymap.set('n', "<leader>bd", ":bd<CR>", { desc = "Buffer Delete" })
vim.keymap.set('n', "<leader>s", ":w<CR>", { desc = "Buffer Write" })

