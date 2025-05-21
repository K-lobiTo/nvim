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

  -- cpp linting
  {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    -- Custom cppcheck definition with better args
    lint.linters.cppcheck = {
      cmd = "cppcheck",
      args = {
        "--enable=warning,style,performance,portability",
        "--inline-suppr",       -- Respect suppression comments
        "--quiet",
        "--template=gcc",       -- Output format Neovim understands
        "--language=c++",
        "--std=c++17",         -- Match your compilation standard
        vim.fn.expand("%:p")   -- Current file path
      },
      stdin = false,           -- Required for cppcheck
      ignore_exitcode = true,  -- Critical: don't fail on warnings
    }

    lint.linters_by_ft = {
      cpp = { "cppcheck" },    -- Single linter (cleaner output)
    }

    -- Only lint on save (reduces noise)
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = lint_augroup,
      callback = function()
        -- Delay slightly to avoid race conditions
        vim.defer_fn(lint.try_lint, 100)
      end,
    })
  end,
  },

  -- C++ Extensions
  {
    "p00f/clangd_extensions.nvim",
    ft = "cpp",
    config = function()
      require("clangd_extensions").setup()
    end
  },

}
