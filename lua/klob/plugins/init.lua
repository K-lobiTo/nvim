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

  {
    "mfussenegger/nvim-lint",
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    config = function()
        local lint = require("lint")

        lint.linters_by_ft = {
            cpp = {
                --"clangtidy",
                "cppcheck"},
        }

        local lint_augroup = vim.api.nvim_create_augroup("lint", {clear = true })

        vim.api.nvim_create_autocmd({"BufEnter", "BufWritePost", "InsertLeave" }, {
            group = lint_augroup,
            callback = function()
                lint.try_lint()
            end,
        })
    end,
  },


}
