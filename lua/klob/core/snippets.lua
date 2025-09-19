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
  --    Iterative
  s("segTreeIt", fmt([[
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

  --    Recursive
  s("segTree", fmt([[
    struct Mono {{
        // TODO: define monoid type
        // ll value;
        // Mono(ll v = 0) : value(v) {{}}
    }};

    Mono operator+(Mono a, Mono b) {{
        // TODO: define monoid operation
        // return {{a.value + b.value}};
    }}

    struct SegmentTree {{
      int n;
      vector<Mono> s;

      SegmentTree(int size) {{
          n = 1;
          while(n < size)n<<=1;
          s.assign(n<<1, Mono());
      }}
      SegmentTree(vector<Mono> const& a){{
          n = 1;
          while(n < (int)a.size())n<<=1;
          s.resize(n<<1);
          build(a, 0, 0, n);
      }}

      void build(vector<Mono> const &a, int x, int lx, int rx){{
          if(!(lx + 1 < rx)){{
              if(lx < (int) a.size())
                  s[x] = a[lx];
              return;
          }}
          int mx = (rx + lx)/2;
          build(a, 2*x + 1, lx, mx);
          build(a, 2*x + 2, mx, rx);
          s[x] = s[2*x + 1] + s[2*x + 2];
      }}

      void set(int idx, Mono m) {{
          set(idx, m, 0, 0, n);
      }}

      void set(int idx, Mono m, int x, int lx, int rx){{
          if(!(lx + 1 < rx)){{
              s[x] = m;
              return;
          }}
          int mx = (lx + rx)/2;
          if(idx < mx)
              set(idx, m, 2*x + 1, lx, mx);
          else 
              set(idx, m, 2*x + 2, mx, rx);

          s[x] = s[2*x + 1] + s[2*x + 2];
      }}

      Mono get(int l, int r) {{ // [l, r)
        return get(l, r, 0, 0, n);
      }}

      Mono get(int l, int r, int x, int lx, int rx){{
          if(r <= lx || l >= rx) return Mono(); 
          if(l <= lx && rx <= r) return s[x];
          int mx = (lx + rx)/2;
          Mono lm = get(l, r, 2*x +1, lx , mx);
          Mono rm = get(l, r, 2*x +2, mx , rx);
          return lm + rm;
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



