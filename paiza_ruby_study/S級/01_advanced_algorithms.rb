# 問題1: 最大フロー問題
#
# 問題文：
# N個の頂点とM本の辺を持つ有向グラフが与えられます。
# 各辺には容量が設定されています。
# 頂点0から頂点N-1への最大フローを求めてください。
#
# 入力例：
# 4 5
# 0 1 16
# 0 2 13
# 1 2 10
# 1 3 12
# 2 3 9
#
# 出力例：
# 19

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

n, m = gets.split.map(&:to_i)
max_flow = MaxFlow.new(n)

m.times do
  from, to, capacity = gets.split.map(&:to_i)
  max_flow.add_edge(from, to, capacity)
end

puts max_flow.max_flow(0, n - 1)

# ==================================================
# 問題2: 凸包（Graham Scan）
#
# 問題文：
# 2次元平面上にN個の点が与えられます。
# これらの点の凸包を構成する点の数を求めてください。
#
# 入力例：
# 6
# 0 0
# 1 1
# 2 0
# 2 2
# 1 3
# 0 2
#
# 出力例：
# 4

# class Point
#   attr_accessor :x, :y
#   
#   def initialize(x, y)
#     @x, @y = x, y
#   end
#   
#   def ==(other)
#     @x == other.x && @y == other.y
#   end
# end
# 
# def convex_hull(points)
#   return points if points.length <= 1
#   
#   # 最下点（同じy座標なら最左点）を見つける
#   start = points.min_by { |p| [p.y, p.x] }
#   
#   # 極角でソート
#   def polar_angle(p1, p2)
#     Math.atan2(p2.y - p1.y, p2.x - p1.x)
#   end
#   
#   def distance_squared(p1, p2)
#     (p2.x - p1.x) ** 2 + (p2.y - p1.y) ** 2
#   end
#   
#   def cross_product(o, a, b)
#     (a.x - o.x) * (b.y - o.y) - (a.y - o.y) * (b.x - o.x)
#   end
#   
#   sorted_points = points.reject { |p| p == start }.sort do |a, b|
#     angle_a = polar_angle(start, a)
#     angle_b = polar_angle(start, b)
#     
#     if (angle_a - angle_b).abs < 1e-9
#       distance_squared(start, a) <=> distance_squared(start, b)
#     else
#       angle_a <=> angle_b
#     end
#   end
#   
#   hull = [start]
#   
#   sorted_points.each do |point|
#     # 右折する点を除去
#     while hull.length > 1 && 
#           cross_product(hull[-2], hull[-1], point) <= 0
#       hull.pop
#     end
#     hull << point
#   end
#   
#   hull
# end
# 
# n = gets.to_i
# points = []
# n.times do
#   x, y = gets.split.map(&:to_i)
#   points << Point.new(x, y)
# end
# 
# hull = convex_hull(points)
# puts hull.length

# ==================================================
# 問題3: Z-Algorithm（文字列マッチング）
#
# 問題文：
# 文字列Sが与えられます。
# 各位置iについて、S[i..]とSの最長共通接頭辞の長さを求めてください。
#
# 入力例：
# ababcababa
#
# 出力例：
# 10 0 2 0 0 3 0 2 0 1

# def z_algorithm(s)
#   n = s.length
#   z = Array.new(n, 0)
#   z[0] = n
#   
#   l = r = 0
#   (1...n).each do |i|
#     if i <= r
#       z[i] = [r - i + 1, z[i - l]].min
#     end
#     
#     while i + z[i] < n && s[z[i]] == s[i + z[i]]
#       z[i] += 1
#     end
#     
#     if i + z[i] - 1 > r
#       l = i
#       r = i + z[i] - 1
#     end
#   end
#   
#   z
# end
# 
# s = gets.chomp
# result = z_algorithm(s)
# puts result.join(' ')

# ==================================================
# 問題4: Miller-Rabin素数判定
#
# 問題文：
# 非常に大きな整数Nが与えられます。
# Nが素数かどうかを確率的に判定してください。
#
# 入力例：
# 982451653
#
# 出力例：
# Yes

# def miller_rabin(n, k = 10)
#   return false if n < 2
#   return true if n == 2 || n == 3
#   return false if n.even?
#   
#   # n-1 = d * 2^r の形に分解
#   d = n - 1
#   r = 0
#   while d.even?
#     d /= 2
#     r += 1
#   end
#   
#   k.times do
#     a = rand(2...n)
#     x = pow_mod(a, d, n)
#     
#     next if x == 1 || x == n - 1
#     
#     (r - 1).times do
#       x = (x * x) % n
#       return false if x == 1
#       break if x == n - 1
#     end
#     
#     return false if x != n - 1
#   end
#   
#   true
# end
# 
# def pow_mod(base, exp, mod)
#   result = 1
#   base %= mod
#   
#   while exp > 0
#     if exp.odd?
#       result = (result * base) % mod
#     end
#     exp >>= 1
#     base = (base * base) % mod
#   end
#   
#   result
# end
# 
# n = gets.to_i
# puts miller_rabin(n) ? "Yes" : "No"

# ==================================================
# 問題5: 強連結成分分解
#
# 問題文：
# N個の頂点とM本の辺を持つ有向グラフが与えられます。
# 強連結成分の数を求めてください。
#
# 入力例：
# 5 6
# 0 1
# 1 2
# 2 0
# 2 3
# 3 4
# 4 3
#
# 出力例：
# 2

# def strongly_connected_components(graph)
#   n = graph.length
#   visited = Array.new(n, false)
#   finish_order = []
#   
#   # 第1回DFS：終了時刻順を記録
#   (0...n).each do |i|
#     dfs1(graph, i, visited, finish_order) unless visited[i]
#   end
#   
#   # グラフを逆向きに構築
#   reverse_graph = Array.new(n) { [] }
#   (0...n).each do |u|
#     graph[u].each { |v| reverse_graph[v] << u }
#   end
#   
#   # 第2回DFS：強連結成分を発見
#   visited.fill(false)
#   components = []
#   
#   finish_order.reverse.each do |start|
#     next if visited[start]
#     
#     component = []
#     dfs2(reverse_graph, start, visited, component)
#     components << component
#   end
#   
#   components
# end
# 
# def dfs1(graph, node, visited, finish_order)
#   visited[node] = true
#   
#   graph[node].each do |neighbor|
#     dfs1(graph, neighbor, visited, finish_order) unless visited[neighbor]
#   end
#   
#   finish_order << node
# end
# 
# def dfs2(graph, node, visited, component)
#   visited[node] = true
#   component << node
#   
#   graph[node].each do |neighbor|
#     dfs2(graph, neighbor, visited, component) unless visited[neighbor]
#   end
# end
# 
# n, m = gets.split.map(&:to_i)
# graph = Array.new(n) { [] }
# 
# m.times do
#   u, v = gets.split.map(&:to_i)
#   graph[u] << v
# end
# 
# components = strongly_connected_components(graph)
# puts components.length

# ==================================================
# 学習ポイント
#
# 1. 最大フロー: ネットワークフローの基礎、Ford-Fulkerson法
# 2. 凸包: 計算幾何の代表的問題、Graham Scan
# 3. Z-Algorithm: 線形時間文字列マッチング
# 4. Miller-Rabin: 確率的素数判定、暗号学での応用
# 5. 強連結成分: グラフの構造解析、Kosaraju法
# 6. 計算量: 効率的なアルゴリズムの設計と実装
# 7. 数学的理論: アルゴリズムの背景にある数学
# 8. 実装技術: 複雑なアルゴリズムの正確な実装