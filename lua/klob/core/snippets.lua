local ls_ok, ls = pcall(require, "luasnip")
if not ls_ok then
  return
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("all", {
  s("cnl", {
      t("cout<<"),
      i(1),
      t("<<endl;"),
  }),
})

