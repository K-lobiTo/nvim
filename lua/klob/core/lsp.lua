local lsp = require("lspconfig")

-- Mason ensures servers are installed
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "clangd", "cpptools" }
})

-- Basic LSP setup
local on_attach = function(client, bufnr)
  -- Keymaps here (e.g., goto definition)
end

-- C++ setup
require("lspconfig").clangd.setup({
  on_attach = on_attach,
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
