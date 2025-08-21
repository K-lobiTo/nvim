local ls_ok, ls = pcall(require, "luasnip")
if not ls_ok then
  return
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("all", {
  s("cnl", {
      t("cout<<"),
      i(1),
      t("<<endl;"),
  }),
  s("fora",{
      t("for(auto &"),
      i(1, "e"),
      t(":"),
      i(2, "ans"),
      t(")"),
  }),

  -- Algorithms
  s("tpsort", fmt([[
    std::vector<int> topologicalSort(int n, const std::vector<std::vector<int>>& adj) {{
        std::vector<int> inDegree(n, 0);
        for (int i = 0; i < n; ++i) 
            for (int v : adj[i]) inDegree[v]++;
        
        std::queue<int> q;
        for (int i = 0; i < n; ++i) 
            if (inDegree[i] == 0) q.push(i);
        
        std::vector<int> order;
        while (!q.empty()) {{
            int u = q.front(); q.pop();
            order.push_back(u);
            for (int v : adj[u]) 
                if (--inDegree[v] == 0) q.push(v);
        }}
        return order;
    }}
  ]], {})),
}) 

