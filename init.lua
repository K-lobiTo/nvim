require("klob.core")
require("klob.lazy")
require("klob.plugins")

vim.opt.termguicolors = true;

vim.api.nvim_create_augroup("cpp_template", { clear = true })
vim.api.nvim_create_autocmd("BufNewFile", {
  pattern = "*.cpp",
  command = "0r ~/Documents/templates/cpptemplate.cpp",
  group = "cpp_template",
  })
