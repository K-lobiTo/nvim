local ls_ok, ls = pcall(require, "luasnip")
if not ls_ok then
  return
end

local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("cpp", {
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
        // TODO: define monoid type & set neutral values
        // ll value;
        // Mono(ll v = 0) : value(v) {{}}
    }};

    Mono operator+(Mono a, Mono b) {{
        // TODO: define monoid operation
        // return {{gcd(a.value, b.value)}};
    }}

    struct SegmentTree {{
      int n;
      vector<Mono> s;

      SegmentTree(int n) : n(n), s(n<<1) {{}}
      SegmentTree(vector<Mono> const& a) : n(a.size()), s(a.size()<<1) {{
        copy(ALL(a), s.begin() + n);
        for (int i = n - 1; i > 0; --i) s[i] = s[i<<1] + s[i<<1|1];
      }}

      void set(int x, Mono m) {{
        for (s[x += n] = m; x >>= 1;) s[x] = s[x<<1] + s[x<<1|1];
      }}

      Mono get(int l, int r) {{ // [l, r)
        Mono resl, resr;
        for (l += n, r += n; l < r; l >>= 1, r >>= 1) {{
          if (l&1) resl = resl + s[l++];
          if (r&1) resr = s[--r] + resr;
        }}
        return resl + resr;
      }}
    }};
  ]], {})),


  -- Sparse Table
  s("sparTable", fmt([[
    template<typename T>
    class SparseTable {{
    private:
        vector<vector<T>> st;
        vector<int> log_table;
        int n;

    T op(T a, T b) {{
        // TODO: define monoid (idempotent) operation
        // return gcd(a, b);
    }}
        
    public:
        SparseTable(const vector<T>& arr) : n(arr.size()) {{
            log_table.resize(n + 1);
            log_table[1] = 0;
            for (int i = 2; i <= n; i++) log_table[i] = log_table[i / 2] + 1;
            
            int k = log_table[n] + 1;
            st.resize(n, vector<T>(k));
            
            for (int i = 0; i < n; i++) st[i][0] = arr[i];
            
            for (int j = 1; j < k; j++)
                for (int i = 0; i + (1 << j) <= n; i++) 
                    st[i][j] = op(st[i][j - 1], st[i + (1 << (j - 1))][j - 1]);
        }}
        
        T query(int l, int r) {{ // [l, r]
            int j = log_table[r - l + 1];
            return op(st[l][j], st[r - (1 << j) + 1][j]);
        }}
    }};
  ]], {})),

}) 



