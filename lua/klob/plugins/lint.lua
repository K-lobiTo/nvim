return {
  "mfussenegger/nvim-lint",
  event = { "BufWritePost", "BufEnter" },
  config = function()
    require("lint").linters_by_ft = {
      cpp = { "cppcheck" },  -- or "clangtidy"
    }

    -- Custom cppcheck config
    require("lint").linters.cppcheck = {
      cmd = "cppcheck",
      args = {
        "--enable=warning,style,performance,portability",
        "--quiet",
        "--template=gcc",
        "--language=c++",
        vim.fn.expand("%:p")  -- Current file path
      },
      stdin = false,
      ignore_exitcode = true,  -- Treat warnings as diagnostics
    }

    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      callback = function()
        require("lint").try_lint()
      end,
    })
  end
}
