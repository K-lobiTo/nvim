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

  -- Topological Sort
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


  -- Segment Tree
  s("segTree", fmt([[
    struct Mono {{
        // TODO: define monoid type
        // ll value;
        // Mono(ll v = 0) : value(v) {{}} // set neutral values
    }};

    Mono operator+(Mono a, Mono b) {{
        // TODO: define monoid operation
        // return {{gcd(a.value, b.value)}};
    }}

    struct Tree {{
      int n;
      vector<Mono> s;

      Tree(int n) : n(n), s(n<<1) {{}}
      Tree(vector<Mono> const& a) : n(a.size()), s(a.size()<<1) {{
        copy(ALL(a), s.begin() + n);
        for (int i = n - 1; i > 0; --i) s[i] = s[i<<1] + s[i<<1|1];
      }}

      void set(int x, Mono m) {{
        for (s[x += n] = m; x >>= 1;) s[x] = s[x<<1] + s[x<<1|1];
      }}

      Mono get(int l, int r) {{
        Mono resl, resr;
        for (l += n, r += n; l < r; l >>= 1, r >>= 1) {{
          if (l&1) resl = resl + s[l++];
          if (r&1) resr = s[--r] + resr;
        }}
        return resl + resr;
      }}
    }};
  ]], {})),

}) 


