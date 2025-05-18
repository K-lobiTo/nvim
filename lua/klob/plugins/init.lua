return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "tpope/vim-surround" },

  -- Snippets 
  {
    "L3MON4D3/LuaSnip",
    version = "v2.4",
    build = "make install_jsregexp",
    config = function()
          require("luasnip").config.set_config({
            history = true,
            updateevents = "TextChanged,TextChangedI",
          })
          require("luasnip.loaders.from_vscode").lazy_load()
          require("klob.core.snippets")
        end,
        dependencies = { "rafamadriz/friendly-snippets" },
  },

  -- Auto-split manager
  {
    "christoomey/vim-tmux-navigator",  -- Unified window/tmux navigation
    keys = {
      { "<C-h>", "<cmd>TmuxNavigateLeft<cr>" },
      { "<C-j>", "<cmd>TmuxNavigateDown<cr>" },
      { "<C-k>", "<cmd>TmuxNavigateUp<cr>" },
      { "<C-l>", "<cmd>TmuxNavigateRight<cr>" },
    }
  },

  -- Auto-resize focused window
  {
    "beauwilliams/focus.nvim",
    opts = { excluded_filetypes = { "toggleterm" } }
  },

}
