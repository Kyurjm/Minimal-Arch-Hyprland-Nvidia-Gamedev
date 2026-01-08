return {
  "nvimdev/indentmini.nvim",
  config = function()
    require("indentmini").setup({
      char = "┊",
    })
    vim.cmd.highlight("IndentLine guifg=#363646")
    vim.cmd.highlight("IndentLineCurrent guifg=#7E9CD8")
  end,
}
