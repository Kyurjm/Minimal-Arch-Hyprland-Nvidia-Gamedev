-- OPTIONS
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
vim.o.updatetime = 250
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

-- PLUGINS
vim.pack.add({
  { src = "https://github.com/rebelot/kanagawa.nvim" },
  { src = "https://github.com/nvimdev/indentmini.nvim" },
  { src = "https://github.com/sphamba/smear-cursor.nvim" },
  { src = "https://github.com/mbbill/undotree" },
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
  { src = "https://github.com/nvim-neo-tree/neo-tree.nvim" },
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/MunifTanjim/nui.nvim" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
  { src = "https://github.com/kdheepak/lazygit.nvim" },
  { src = "https://github.com/mikavilpas/yazi.nvim" },
  { src = "https://github.com/mfussenegger/nvim-dap" },
  { src = "https://github.com/nvim-neotest/nvim-nio" },
  { src = "https://github.com/rcarriga/nvim-dap-ui" },
  { src = "https://github.com/karb94/neoscroll.nvim" },
})

-- CONFIG
require('neoscroll').setup() -- Neoscroll
local neoscroll = require('neoscroll')
require('telescope').load_extension('lazygit') -- LazyGit
require('lualine').setup({}) -- lualine
require("nvim-autopairs").setup({}) -- Autopairs
vim.cmd("colorscheme kanagawa-wave") -- Kanagawa
require("smear_cursor").setup({ time_interval = 7 }) -- Smear Cursor
require("indentmini").setup({ char = "┊", }) -- Indentmini
vim.cmd.highlight('IndentLine guifg=#363646')
vim.cmd.highlight('IndentLineCurrent guifg=#7E9CD8')
local wk = require("which-key") -- Whichkey keymaps list
wk.setup({preset = "helix",})
vim.g.loaded_netrwPlugin = 1 -- Yazi
vim.api.nvim_create_autocmd("UIEnter", {callback = function()require("yazi").setup({open_for_directories = true,})end,})
require("neo-tree").setup({ -- Neotree
  clipboard = {
    sync = "universal",
  },
  default_component_configs = {
    indent = {
      indent_marker = "┊",
    },
  },
  filesystem = {
    filtered_items = {
      hide_dotfiles = false,
      hide_gitignored = false,
      hide_ignored = false,
    },
    hide_hidden = true,
  },
})
local ok, telescope = pcall(require, "telescope") -- Telescope
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
require("mason").setup() -- LSP, Treesitter & Auto Completion Support
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
local ts_ok, ts_configs = pcall(require, 'nvim-treesitter.configs') -- Treesitter
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
require("luasnip.loaders.from_vscode").lazy_load() -- Luasnip
local ls_ok, _ = pcall(require, "luasnip")
if ls_ok then
  require("luasnip.loaders.from_vscode").lazy_load()
end
require('blink.cmp').setup({ -- Blink
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
require("dapui").setup() -- DAP
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
dap.adapters.coreclr = { -- Unity Debugger
  type = "executable",
  command = vim.fn.stdpath("data") .. "/mason/bin/netcoredbg",
  args = { "--interpreter=vscode" },
}
dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch Unity / .NET",
    request = "launch",
    program = function()
      return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
    end,
  },
}
dap.adapters.python = { -- Python Debugger
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
dap.adapters.codelldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
    args = { "--port", "${port}" },
  },
}
dap.configurations.rust = { -- Rust Debugger
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

-- KEYMAPS
vim.keymap.set("n", "<leader>U", function() if vim.pack and vim.pack.update then vim.pack.update() else vim.notify("vim.pack.update() not available in this Neovim build", vim.log.levels.WARN) end end, { desc = "Update plugins (vim.pack)" })
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>t', '<cmd>botright split | terminal<CR><cmd>resize 10<CR>i', { desc = 'Open Terminal' })
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Toggle UndoTree' })
vim.keymap.set('n', '<leader>n', '<Cmd>Neotree toggle<CR>', { desc = 'Toggle Neo-tree' })
vim.api.nvim_set_keymap('n', '<leader>of', ':Telescope find_files<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>og', ':Telescope live_grep<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>l', "<cmd>LazyGit<cr>", {desc = "Open LazyGit"})
vim.keymap.set("n", "<leader>e", function() require("yazi").yazi() end, { desc = 'Open Yazi' })
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { desc = 'Rename Variable' })
vim.keymap.set("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format file" })
vim.keymap.set("v", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, { desc = "Format selection" })
vim.keymap.set('n', '<leader>dd', vim.diagnostic.setloclist, { desc = 'Open diagnostic list' })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "DAP Continue" })
vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "DAP Step Over" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "DAP Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "DAP Step Out" })
vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP Toggle Breakpoint" })
vim.keymap.set("n", "<leader>dr", dap.repl.open, { desc = "DAP REPL" })
vim.keymap.set("n", "<leader>dl", dap.run_last, { desc = "DAP Run Last" })
vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "DAP Terminate" })
vim.keymap.set("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "DAP Conditional Breakpoint" })
vim.keymap.set("n", "<leader>du", function() dapui.toggle() end, { desc = "DAP UI Toggle" })
vim.keymap.set("n", '<S-Up>', function() neoscroll.ctrl_b({ duration = 250 }) end)
vim.keymap.set("n", '<S-Down>', function() neoscroll.ctrl_f({ duration = 250 }) end)
