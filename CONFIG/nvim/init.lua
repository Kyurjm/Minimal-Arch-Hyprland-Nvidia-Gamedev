--###################
--##### OPTIONS #####
--###################

vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false
vim.o.tabstop = 2
vim.o.smartindent = true
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.swapfile = false
vim.o.mouse = 'a'
vim.o.virtualedit = 'block'
vim.o.showbreak = "↳ "
vim.o.breakindent = false
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.o.incsearch = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 555
vim.o.timeoutlen = 3000
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.inccommand = 'split'
vim.o.cursorline = true
vim.o.scrolloff = 10
vim.o.sidescrolloff = 8
vim.o.confirm = true
vim.o.termguicolors = true
vim.o.list = true
vim.o.conceallevel = 0
vim.o.spell = false
vim.o.winborder = "rounded"
vim.o.listchars = "tab:» ,trail:·,nbsp:␣"
vim.schedule(function() if not vim.env.SSH_CONNECTION then vim.o.clipboard = 'unnamedplus' end end)
vim.api.nvim_set_hl(0, 'YankHighlight', { bg = '#c1a473', fg = '#1F1F28' }) vim.api.nvim_create_autocmd('TextYankPost', { group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }), callback = function() vim.hl.on_yank({ higroup = 'YankHighlight', timeout = 200 }) end })
vim.opt.guicursor = { "n-v-c:block", "i-ci-ve:ver25", "r-cr:hor20", "o:hor50", "a:blinkon150-blinkoff150-blinkwait100"}
vim.diagnostic.config({virtual_text = true,signs = true,underline = true,update_in_insert = false,})

--###################
--##### PLUGINS #####
--###################

vim.pack.add({
  { src = "https://github.com/rebelot/kanagawa.nvim" }, -- Kanagawa Theme
  { src = "https://github.com/nvimdev/indentmini.nvim" }, -- Indent Guide
  { src = "https://github.com/sphamba/smear-cursor.nvim" }, -- Cursor Style
  { src = "https://github.com/neovim/nvim-lspconfig" }, -- LSP
  { src = "https://github.com/mason-org/mason.nvim" }, -- LSP
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" }, -- LSP
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" }, -- LSP
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range('*') }, -- Auto Completion
  { src = "https://github.com/L3MON4D3/LuaSnip", version = vim.version.range('*') }, -- Code Snippets
  { src = "https://github.com/rafamadriz/friendly-snippets" }, -- Code Snippets
  { src = "https://github.com/windwp/nvim-autopairs" }, -- Autopairs
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" }, -- Treesitter
  { src = "https://github.com/folke/which-key.nvim" }, -- Keymap Guide UI
  { src = "https://github.com/nvim-telescope/telescope.nvim" }, -- Telescope
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" }, -- Telescope
  { src = "https://github.com/nvim-lua/plenary.nvim" }, -- Dependency
  { src = "https://github.com/nvim-tree/nvim-web-devicons" }, -- Dependency
  { src = "https://github.com/nvim-lualine/lualine.nvim" }, -- Bottom Status Line
  { src = "https://github.com/kdheepak/lazygit.nvim" }, -- Lazygit
  { src = "https://github.com/mikavilpas/yazi.nvim" }, -- Yazi
  { src = "https://github.com/karb94/neoscroll.nvim" }, -- Neoscroll
  { src = "https://github.com/seblyng/roslyn.nvim" }, -- C# LSP
  { src = "https://github.com/khoido2003/roslyn-filewatch.nvim" }, -- C# Auto Sync Files
  { src = "https://github.com/notjedi/nvim-rooter.lua" }, -- C# Auto Detect Files
})

--###################
--##### CONFIGS #####
--###################

-- Neoscroll
require('neoscroll').setup()
local neoscroll = require('neoscroll')

-- Lazygit
require('telescope').load_extension('lazygit')

-- Lualine
require('lualine').setup({})

-- Autopairs
require("nvim-autopairs").setup({})

-- Kanagawa
vim.cmd("colorscheme kanagawa-wave")

-- Smear Cursor
require("smear_cursor").setup({ time_interval = 7 })

-- Indentmini
require("indentmini").setup({ char = "┊", })
vim.cmd.highlight('IndentLine guifg=#363646')
vim.cmd.highlight('IndentLineCurrent guifg=#7E9CD8')

-- Whichkey Keymap Guide
local wk = require("which-key")
wk.setup({preset = "helix",})

-- Yazi
vim.g.loaded_netrwPlugin = 1
vim.api.nvim_create_autocmd("UIEnter", {callback = function()require("yazi").setup({open_for_directories = true,})end,})

-- Telescope
local ok, telescope = pcall(require, "telescope")
if not ok then
  return
end
telescope.setup({
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
  },
})
vim.api.nvim_create_autocmd("VimEnter", {
  once = true,
  callback = function()
    local data = vim.fn.stdpath("data")
    local lib = vim.fn.glob(data .. "/site/pack/*/start/telescope-fzf-native.nvim/build/libfzf.*")

    if lib == "" then
      local plugin = vim.fn.glob(data .. "/site/pack/*/start/telescope-fzf-native.nvim")
      if plugin ~= "" then
        vim.notify("Building telescope-fzf-native...", vim.log.levels.INFO)
        vim.system({ "make" }, { cwd = plugin }):wait()
        vim.notify("Finished building telescope-fzf-native", vim.log.levels.INFO)
      end
    end
    pcall(telescope.load_extension, "fzf")
  end,
})
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "nvim-treesitter" then
      vim.cmd("TSUpdate")
    end
  end,
})

-- Treesitter
local ts_ok, ts_configs = pcall(require, 'nvim-treesitter.configs')
if ts_ok then
  ts_configs.setup({
    ensure_installed = {
      "lua",
      "rust",
      "c_sharp",
      "python",
      "markdown"
    },
    highlight = { enable = true },
    indent = { enable = true },
  })
end

-- Luasnip
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/lua/snippets" })

-- LSP
require("mason").setup({
    registries = {
        "github:mason-org/mason-registry",
        "github:Crashdummyy/mason-registry",
    },
})
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls", -- Lua
    "rust_analyzer", -- Rust
    "pyright", -- Python
    "marksman", -- Markdown
    "taplo", -- Toml
    "html", -- HTML
    "cssls", -- CSS
    "yamlls", -- Yaml
    "jsonls", -- Json
    "bashls", -- Bash
    "fish_lsp", -- Fish
  },
})
require("mason-tool-installer").setup({
  ensure_installed = {
    "stylua", -- Lua Formatter
    "prettier", -- HTML CSS Markdown Json Yaml Formatter
    "csharpier", -- C# Formatter
    "black", -- Python Formatter
    "isort", -- Python Formatter
    "shfmt", -- Bash Formatter
    "netcoredbg", -- Unity Debugger
    "codelldb", -- Rust Debugger
    "debugpy", -- Python Debugger
    "ruff", -- Python linter
    "shellcheck", -- Bash linter
    "roslyn", -- C# LSP Custom
  },
})
-- C# Roslyn Config
require'nvim-rooter'.setup()
require("roslyn_filewatch").setup()
vim.lsp.config("roslyn", {
    on_attach = function()
        print("Ropslyn server attaches!")
    end,
    settings = {
        ["csharp|inlay_hints"] = {
            csharp_enable_inlay_hints_for_implicit_object_creation = true,
            csharp_enable_inlay_hints_for_implicit_variable_types = true,
            csharp_enable_inlay_hints_for_lambda_parameter_types = true,
            csharp_enable_inlay_hints_for_types = true,
            dotnet_enable_inlay_hints_for_indexer_parameters = true,
            dotnet_enable_inlay_hints_for_literal_parameters = true,
            dotnet_enable_inlay_hints_for_object_creation_parameters = true,
            dotnet_enable_inlay_hints_for_other_parameters = true,
            dotnet_enable_inlay_hints_for_parameters = true,
            dotnet_suppress_inlay_hints_for_parameters_that_differ_only_by_suffix = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_argument_name = true,
            dotnet_suppress_inlay_hints_for_parameters_that_match_method_intent = true,
        },
        ["csharp|code_lens"] = {
            dotnet_enable_references_code_lens = true,
        },
    },
})
-- LUA LSP Setup
vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      diagnostics = {
        globals = { 'vim', 'require'}
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
        },
      },
      completion = {
        callSnippet = "Replace"
      }
    },
  },
})

-- Blink Auto Completion
require('blink.cmp').setup({
  snippets = { preset = 'luasnip' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  keymap = {
    preset = 'default',
  },
  completion = {
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
    },
  },
  signature = {
    enabled = true,
  },
})
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.spec.name == "blink.cmp" then
      vim.notify("Building blink.cmp native module...", vim.log.levels.INFO)
      vim.system({ "cargo", "build", "--release" }, {
        cwd = ev.data.path,
      }):wait()
      vim.notify("blink.cmp build finished", vim.log.levels.INFO)
    end
  end,
})

--###################
--##### KEYMAPS #####
--###################

-- Update Packages
vim.keymap.set("n", "<leader>u", function() if vim.pack and vim.pack.update then vim.pack.update() else vim.notify("vim.pack.update() not available in this Neovim build", vim.log.levels.WARN) end end, { desc = "Update plugins (vim.pack)" })

-- Clear highlight search
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Terminal
vim.keymap.set('n', '<leader>th', '<cmd>botright split | terminal<CR><cmd>resize 15<CR>i', { desc = 'Bottom' })
vim.keymap.set('n', '<leader>tv', '<cmd>vsp | terminal<CR><cmd>vertical resize 40<CR>i', { desc = 'Right' })
require("which-key").add({ { "<leader>t", group = "Terminal" } })

-- Move cursor between windows
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Telescope
vim.api.nvim_set_keymap('n', '<leader>s', ':Telescope live_grep<CR>', { noremap = true, silent = true })

-- Lazygit
vim.keymap.set('n', '<leader>l', "<cmd>LazyGit<cr>", {desc = "LazyGit"})

-- Yazi
vim.keymap.set("n", "<leader>e", function() require("yazi").yazi() end, { desc = 'Yazi' })

-- Refractor
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = 'Rename Variable' })

-- Formatter
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format file" })

-- Neoscroll
vim.keymap.set("n", '<S-Up>', function() neoscroll.ctrl_b({ duration = 250 }) end)
vim.keymap.set("n", '<S-Down>', function() neoscroll.ctrl_f({ duration = 250 }) end)
vim.keymap.set("n", '<C-Up>', function() neoscroll.ctrl_u({ duration = 250 }) end)
vim.keymap.set("n", '<C-Down>', function() neoscroll.ctrl_d({ duration = 250 }) end)
