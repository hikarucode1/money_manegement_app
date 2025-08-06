# 問題1: 迷路の最短経路（BFS）
#
# 問題文：
# H×Wの迷路が与えられます。
# 'S'がスタート、'G'がゴール、'#'が壁、'.'が通路です。
# スタートからゴールまでの最短距離を求めてください。
# 到達できない場合は-1を出力してください。
#
# 入力例：
# 5 5
# S...#
# .###.
# .#...
# .#.#.
# ...#G
#
# 出力例：
# 12

require 'set'

# 解答例1
def bfs_maze(maze, start, goal)
  directions = [[0, 1], [0, -1], [1, 0], [-1, 0]]
  queue = [[start[0], start[1], 0]]  # x, y, distance
  visited = Set.new
  visited.add([start[0], start[1]])
  
  until queue.empty?
    x, y, dist = queue.shift
    
    return dist if [x, y] == goal
    
    directions.each do |dx, dy|
      nx, ny = x + dx, y + dy
      
      if nx >= 0 && nx < maze.length && 
         ny >= 0 && ny < maze[0].length &&
         maze[nx][ny] != '#' && 
         !visited.include?([nx, ny])
        
        visited.add([nx, ny])
        queue << [nx, ny, dist + 1]
      end
    end
  end
  
  -1
end

h, w = gets.split.map(&:to_i)
maze = []
start = nil
goal = nil

h.times do |i|
  row = gets.chomp.chars
  maze << row
  
  row.each_with_index do |cell, j|
    start = [i, j] if cell == 'S'
    goal = [i, j] if cell == 'G'
  end
end

puts bfs_maze(maze, start, goal)

# ==================================================
# 問題2: 連結成分の数
#
# 問題文：
# N個の頂点とM個の辺を持つ無向グラフが与えられます。
# 連結成分の数を求めてください。
#
# 入力例：
# 6 4
# 1 2
# 2 3
# 4 5
# 5 6
#
# 出力例：
# 2

# 解答例2
# def count_components(n, edges)
#   # 隣接リストを作成
#   graph = Hash.new { |h, k| h[k] = [] }
#   edges.each do |a, b|
#     graph[a] << b
#     graph[b] << a
#   end
#   
#   visited = Set.new
#   components = 0
#   
#   (1..n).each do |vertex|
#     unless visited.include?(vertex)
#       # DFSで連結成分を探索
#       stack = [vertex]
#       while !stack.empty?
#         current = stack.pop
#         next if visited.include?(current)
#         
#         visited.add(current)
#         graph[current].each do |neighbor|
#           stack << neighbor unless visited.include?(neighbor)
#         end
#       end
#       components += 1
#     end
#   end
#   
#   components
# end
# 
# n, m = gets.split.map(&:to_i)
# edges = []
# m.times do
#   a, b = gets.split.map(&:to_i)
#   edges << [a, b]
# end
# 
# puts count_components(n, edges)

# ==================================================
# 問題3: 島の数（DFS）
#
# 問題文：
# H×Wのグリッドが与えられます。
# '1'が陸地、'0'が海です。
# 4方向に隣接する陸地は同じ島とみなします。
# 島の数を求めてください。
#
# 入力例：
# 4 5
# 11000
# 11000
# 00100
# 00011
#
# 出力例：
# 3

# 解答例3
# def count_islands(grid)
#   return 0 if grid.empty?
#   
#   rows, cols = grid.length, grid[0].length
#   islands = 0
#   
#   def dfs(grid, i, j, rows, cols)
#     return if i < 0 || i >= rows || j < 0 || j >= cols || grid[i][j] == '0'
#     
#     grid[i][j] = '0'  # 訪問済みにマーク
#     
#     # 4方向を探索
#     dfs(grid, i+1, j, rows, cols)
#     dfs(grid, i-1, j, rows, cols)
#     dfs(grid, i, j+1, rows, cols)
#     dfs(grid, i, j-1, rows, cols)
#   end
#   
#   (0...rows).each do |i|
#     (0...cols).each do |j|
#       if grid[i][j] == '1'
#         dfs(grid, i, j, rows, cols)
#         islands += 1
#       end
#     end
#   end
#   
#   islands
# end
# 
# h, w = gets.split.map(&:to_i)
# grid = []
# h.times do
#   grid << gets.chomp.chars
# end
# 
# puts count_islands(grid)

# ==================================================
# 問題4: 木の直径
#
# 問題文：
# N個の頂点を持つ木が与えられます。
# 木の直径（最も遠い2点間の距離）を求めてください。
#
# 入力例：
# 6
# 1 2
# 2 3
# 2 4
# 4 5
# 4 6
#
# 出力例：
# 4

# 解答例4
# def tree_diameter(n, edges)
#   # 隣接リストを作成
#   graph = Hash.new { |h, k| h[k] = [] }
#   edges.each do |a, b|
#     graph[a] << b
#     graph[b] << a
#   end
#   
#   # 任意の点から最も遠い点を見つける
#   def bfs_farthest(start, graph)
#     queue = [[start, 0]]
#     visited = Set.new([start])
#     farthest_node = start
#     max_distance = 0
#     
#     until queue.empty?
#       node, dist = queue.shift
#       
#       if dist > max_distance
#         max_distance = dist
#         farthest_node = node
#       end
#       
#       graph[node].each do |neighbor|
#         unless visited.include?(neighbor)
#           visited.add(neighbor)
#           queue << [neighbor, dist + 1]
#         end
#       end
#     end
#     
#     [farthest_node, max_distance]
#   end
#   
#   # 1. 適当な点から最も遠い点を見つける
#   farthest1, _ = bfs_farthest(1, graph)
#   
#   # 2. その点から最も遠い点までの距離が直径
#   _, diameter = bfs_farthest(farthest1, graph)
#   
#   diameter
# end
# 
# n = gets.to_i
# edges = []
# (n-1).times do
#   a, b = gets.split.map(&:to_i)
#   edges << [a, b]
# end
# 
# puts tree_diameter(n, edges)

# ==================================================
# 学習ポイント
#
# 1. BFS: 最短経路、レベル順探索
# 2. DFS: 連結成分、バックトラッキング
# 3. グラフの表現: 隣接リスト vs 隣接行列
# 4. 訪問済み管理: Set、配列の使い分け
# 5. 木の性質: 直径の求め方（2回のBFS）
# 6. 迷路問題の定石: 4方向移動
# 7. グリッド上のDFS: 再帰 vs スタック
# 8. 計算量: BFS O(V+E), DFS O(V+E)