return {
  'ellisonleao/gruvbox.nvim',
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    vim.o.termguicolors = true
    vim.cmd([[colorscheme gruvbox]])

  end,
}
