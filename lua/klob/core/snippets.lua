local ls_ok, ls = pcall(require, "luasnip")
if not ls_ok then
  return
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.add_snippets("all", {
  s("ternary", {
    -- Simple ternary snippet
    t("{"),
    i(1, "condition"),
    t(" ? "),
    i(2, "true"),
    t(" : "),
    i(3, "false"),
    t("};"),
  }),
  s("forloop", {
    -- For loop snippet
    t("for (int "),
    i(1, "i"),
    t(" = 0; "),
    i(1),
    t(" < "),
    i(2, "n"),
    t("; "),
    i(1),
    t("++) {"),
    t({"", "  "}),
    i(0),
    t({"", "}"}),
  }),
})
