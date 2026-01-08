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
  { src = "https://github.com/rebelot/kanagawa.nvim" },
  { src = "https://github.com/nvimdev/indentmini.nvim" },
  { src = "https://github.com/sphamba/smear-cursor.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/Saghen/blink.cmp", version = vim.version.range('*') },
  { src = "https://github.com/L3MON4D3/LuaSnip" },
  { src = "https://github.com/rafamadriz/friendly-snippets" },
  { src = "https://github.com/windwp/nvim-autopairs" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/folke/which-key.nvim" },
  { src = "https://github.com/nvim-telescope/telescope.nvim" },
  { src = "https://github.com/nvim-telescope/telescope-fzf-native.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/mikavilpas/yazi.nvim" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/karb94/neoscroll.nvim" },
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

-- LSP
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls", -- Lua
    "rust_analyzer", -- Rust
    "omnisharp", -- C#
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
  handlers = {
    function(server_name)
      vim.lsp.enable(server_name)
    end,
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
  },
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
local ls_ok, _ = pcall(require, "luasnip")
if ls_ok then
  require("luasnip.loaders.from_vscode").lazy_load()
end

-- Blink Auto Completion
require('blink.cmp').setup({
  snippets = { preset = 'luasnip' },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  keymap = {
    preset = 'default',
  },
})
vim.lsp.config("*", {
  capabilities = require("blink.cmp").get_lsp_capabilities(),
})
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

-- DAP
require("dapui").setup()
local dap = require("dap")
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui"] = function()
  dapui.close()
end

-- Python DAP
dap.adapters.python = {
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/python3",
  args = { "-m", "debugpy.adapter" },
}
dap.configurations.python = {
  {
    type = "python",
    request = "launch",
    name = "Launch file",
    program = "${file}",
    pythonPath = "python",
  },
}

-- Rust DAP
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}
dap.configurations.rust = {
  {
    name = "Launch",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/target/debug/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
  },
}

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

-- Debugger
vim.keymap.set("n", "<leader>d", function() dapui.toggle() end, { desc = "DAP UI Toggle" })

-- Neoscroll
vim.keymap.set("n", '<S-Up>', function() neoscroll.ctrl_b({ duration = 250 }) end)
vim.keymap.set("n", '<S-Down>', function() neoscroll.ctrl_f({ duration = 250 }) end)
vim.keymap.set("n", '<C-Up>', function() neoscroll.ctrl_u({ duration = 250 }) end)
vim.keymap.set("n", '<C-Down>', function() neoscroll.ctrl_d({ duration = 250 }) end)
