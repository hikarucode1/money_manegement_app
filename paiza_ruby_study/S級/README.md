# S級問題集（最上級レベル）

S級は最高難易度のアルゴリズム問題です。プログラミングコンテストや研究レベルの問題が含まれ、非常に高度な知識と実装力が要求されます。

## 学習目標

- 最先端のアルゴリズム技術
- 複雑な数学的概念の応用
- 高度な最適化とヒューリスティック
- 並列・分散アルゴリズム
- 機械学習・AI関連アルゴリズム
- 暗号学・セキュリティアルゴリズム

## 主な問題パターン

1. **高度なグラフ理論**: 最大フロー、二部マッチング、強連結成分
2. **計算幾何**: 凸包、ボロノイ図、線分配置
3. **数論アルゴリズム**: 素因数分解、離散対数、楕円曲線
4. **文字列アルゴリズム**: Suffix Tree/Array、Aho-Corasick
5. **高度なデータ構造**: Treap、Splay Tree、Link-Cut Tree
6. **最適化問題**: 線形計画法、ネットワークフロー
7. **並行・並列アルゴリズム**: マルチスレッド、分散計算

## 超高度なアルゴリズムの実装

### 1. 最大フロー（Ford-Fulkerson法）
```ruby
class MaxFlow
  def initialize(n)
    @n = n
    @graph = Array.new(n) { Array.new(n, 0) }
  end
  
  def add_edge(from, to, capacity)
    @graph[from][to] += capacity
  end
  
  def max_flow(source, sink)
    flow = 0
    
    loop do
      # BFSで拡張パスを探す
      path = bfs_path(source, sink)
      break unless path
      
      # パスの最小容量を求める
      path_flow = path.each_cons(2).map { |u, v| @graph[u][v] }.min
      
      # フローを更新
      path.each_cons(2) do |u, v|
        @graph[u][v] -= path_flow
        @graph[v][u] += path_flow
      end
      
      flow += path_flow
    end
    
    flow
  end
  
  private
  
  def bfs_path(source, sink)
    parent = Array.new(@n, -1)
    visited = Array.new(@n, false)
    queue = [source]
    visited[source] = true
    
    until queue.empty?
      current = queue.shift
      return construct_path(parent, source, sink) if current == sink
      
      (0...@n).each do |next_node|
        if !visited[next_node] && @graph[current][next_node] > 0
          visited[next_node] = true
          parent[next_node] = current
          queue << next_node
        end
      end
    end
    
    nil
  end
  
  def construct_path(parent, source, sink)
    path = []
    current = sink
    
    until current == source
      path.unshift(current)
      current = parent[current]
    end
    
    path.unshift(source)
    path
  end
end
```

### 2. Suffix Array
```ruby
class SuffixArray
  def initialize(s)
    @s = s + '$'  # 番兵文字
    @n = @s.length
    @sa = build_suffix_array
    @lcp = build_lcp_array
  end
  
  attr_reader :sa, :lcp
  
  private
  
  def build_suffix_array
    # 基数ソートベースの高速実装
    order = (0...@n).sort_by { |i| @s[i] }
    classes = Array.new(@n)
    
    classes[order[0]] = 0
    (1...@n).each do |i|
      if @s[order[i]] == @s[order[i-1]]
        classes[order[i]] = classes[order[i-1]]
      else
        classes[order[i]] = classes[order[i-1]] + 1
      end
    end
    
    length = 1
    while length < @n
      order = counting_sort(order, classes, length)
      new_classes = Array.new(@n)
      new_classes[order[0]] = 0
      
      (1...@n).each do |i|
        curr = [classes[order[i]], classes[(order[i] + length) % @n]]
        prev = [classes[order[i-1]], classes[(order[i-1] + length) % @n]]
        
        if curr == prev
          new_classes[order[i]] = new_classes[order[i-1]]
        else
          new_classes[order[i]] = new_classes[order[i-1]] + 1
        end
      end
      
      classes = new_classes
      length *= 2
    end
    
    order
  end
  
  def counting_sort(order, classes, length)
    count = Array.new(@n, 0)
    order.each { |i| count[classes[(i + length) % @n]] += 1 }
    
    (1...@n).each { |i| count[i] += count[i-1] }
    
    new_order = Array.new(@n)
    (order.length - 1).downto(0) do |i|
      c = classes[(order[i] + length) % @n]
      count[c] -= 1
      new_order[count[c]] = order[i]
    end
    
    new_order
  end
  
  def build_lcp_array
    rank = Array.new(@n)
    @sa.each_with_index { |suffix, i| rank[suffix] = i }
    
    lcp = Array.new(@n - 1)
    h = 0
    
    (0...@n).each do |i|
      if rank[i] > 0
        j = @sa[rank[i] - 1]
        while i + h < @n && j + h < @n && @s[i + h] == @s[j + h]
          h += 1
        end
        lcp[rank[i] - 1] = h
        h = [h - 1, 0].max
      end
    end
    
    lcp
  end
end
```

### 3. 高速フーリエ変換（FFT）
```ruby
require 'complex'

class FFT
  def self.fft(a, inverse = false)
    n = a.length
    return a if n <= 1
    
    # ビットリバーサル
    j = 0
    (1...n).each do |i|
      bit = n >> 1
      while (j & bit) != 0
        j ^= bit
        bit >>= 1
      end
      j ^= bit
      a[i], a[j] = a[j], a[i] if i < j
    end
    
    # FFT本体
    length = 2
    while length <= n
      angle = (inverse ? Math::PI : -Math::PI) / (length / 2)
      wlen = Complex(Math.cos(angle), Math.sin(angle))
      
      (0...n).step(length) do |i|
        w = Complex(1, 0)
        (length / 2).times do |j|
          u = a[i + j]
          v = a[i + j + length / 2] * w
          a[i + j] = u + v
          a[i + j + length / 2] = u - v
          w *= wlen
        end
      end
      
      length *= 2
    end
    
    if inverse
      a.map! { |x| x / n }
    end
    
    a
  end
  
  def self.multiply_polynomials(a, b)
    result_size = a.length + b.length - 1
    n = 1
    n *= 2 while n < result_size
    
    fa = a + Array.new(n - a.length, 0)
    fb = b + Array.new(n - b.length, 0)
    
    fa = fft(fa.map { |x| Complex(x, 0) })
    fb = fft(fb.map { |x| Complex(x, 0) })
    
    (0...n).each { |i| fa[i] *= fb[i] }
    
    result = fft(fa, true)
    result[0, result_size].map { |x| x.real.round }
  end
end
```

### 4. 強連結成分分解（Kosaraju法）
```ruby
def strongly_connected_components(graph)
  n = graph.length
  visited = Array.new(n, false)
  finish_order = []
  
  # 第1回DFS：終了時刻順を記録
  (0...n).each do |i|
    dfs1(graph, i, visited, finish_order) unless visited[i]
  end
  
  # グラフを逆向きに構築
  reverse_graph = Array.new(n) { [] }
  (0...n).each do |u|
    graph[u].each { |v| reverse_graph[v] << u }
  end
  
  # 第2回DFS：強連結成分を発見
  visited.fill(false)
  components = []
  
  finish_order.reverse.each do |start|
    next if visited[start]
    
    component = []
    dfs2(reverse_graph, start, visited, component)
    components << component
  end
  
  components
end

def dfs1(graph, node, visited, finish_order)
  visited[node] = true
  
  graph[node].each do |neighbor|
    dfs1(graph, neighbor, visited, finish_order) unless visited[neighbor]
  end
  
  finish_order << node
end

def dfs2(graph, node, visited, component)
  visited[node] = true
  component << node
  
  graph[node].each do |neighbor|
    dfs2(graph, neighbor, visited, component) unless visited[neighbor]
  end
end
```

## 数学的アルゴリズム

### Miller-Rabin素数判定
```ruby
def miller_rabin(n, k = 5)
  return false if n < 2
  return true if n == 2 || n == 3
  return false if n.even?
  
  # n-1 = d * 2^r の形に分解
  d = n - 1
  r = 0
  while d.even?
    d /= 2
    r += 1
  end
  
  k.times do
    a = rand(2...n)
    x = pow_mod(a, d, n)
    
    next if x == 1 || x == n - 1
    
    (r - 1).times do
      x = (x * x) % n
      return false if x == 1
      break if x == n - 1
    end
    
    return false if x != n - 1
  end
  
  true
end

def pow_mod(base, exp, mod)
  result = 1
  base %= mod
  
  while exp > 0
    if exp.odd?
      result = (result * base) % mod
    end
    exp >>= 1
    base = (base * base) % mod
  end
  
  result
end
```

## 学習戦略

1. **数学的基礎**: 線形代数、確率論、整数論の深い理解
2. **最新研究**: 論文や最新のアルゴリズム研究を追う
3. **実装の最適化**: 定数時間の改善、キャッシュ効率
4. **コンテスト参加**: AtCoder、Codeforces等での実戦経験
5. **専門分野**: 特定分野での深い専門知識

## 練習問題

このディレクトリには以下の問題が含まれています：

1. **高度なグラフ**: 最大フロー、最小カット、二部マッチング
2. **計算幾何**: 凸包、最近点対、線分交差
3. **文字列**: Suffix Array、Z-algorithm、回文木
4. **数論**: 高速素因数分解、離散対数問題
5. **最適化**: 線形計画法、整数計画法
6. **確率・統計**: モンテカルロ法、ベイズ推定

S級をクリアすれば、世界レベルのプログラミング能力を持っている証拠です。
研究開発や最先端技術分野で活躍できるレベルに到達します。