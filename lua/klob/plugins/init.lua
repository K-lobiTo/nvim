return {
  { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  { "tpope/vim-surround" },
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

}
