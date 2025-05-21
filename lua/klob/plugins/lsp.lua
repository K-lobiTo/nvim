return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd" }
      })

      local lspconfig = require("lspconfig")
      lspconfig.clangd.setup({
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed",
          "--query-driver=/usr/bin/g++"
        }
      })
    end
  }
}
