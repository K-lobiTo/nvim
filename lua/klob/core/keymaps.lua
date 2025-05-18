vim.g.mapleader = " "

vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })

-- Save file (force write)
vim.keymap.set('n', '<Leader>w', ':w!<CR>', { noremap = true, silent = true })

-- Quit Neovim (force quit)
vim.keymap.set('n', '<Leader>q', ':q!<CR>', { noremap = true, silent = true })


-- C++23 Compile & Run Mappings (F7, F8)
-- Basic build + run with test input
vim.api.nvim_set_keymap('n', '<F8>', '<ESC>:w<CR>:!g++ -fsanitize=address -std=c++23 -O2 -o %< % && ./%< < test<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<F8>', '<ESC>:w<CR>:!g++ -fsanitize=address -std=c++23 -O2 -o "%<" "%" && "./%<" < test<CR>', { noremap = true, silent = true })

-- Build + run with strict warnings
vim.api.nvim_set_keymap('n', '<F7>', '<ESC>:w<CR>:!g++ -fsanitize=address -std=c++23 -Wall -Wextra -Wshadow -O2 -o %< % && ./%< < test<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<F7>', '<ESC>:w<CR>:!g++ -fsanitize=address -std=c++23 -Wall -Wextra -Wshadow -O2 -o "%<" "%" && "./%<" < test<CR>', { noremap = true, silent = true })

-- Expand or jump in insert mode
vim.keymap.set({"i", "s"}, "<Tab>", function()
  if require("luasnip").expand_or_jumpable() then
    return "<Plug>luasnip-expand-or-jump"
  else
    return "<Tab>"
  end
end, { expr = true, silent = true })

-- Jump backward
vim.keymap.set({"i", "s"}, "<S-Tab>", function()
  if require("luasnip").jumpable(-1) then
    return "<Plug>luasnip-jump-prev"
  else
    return "<S-Tab>"
  end
end, { expr = true, silent = true })
