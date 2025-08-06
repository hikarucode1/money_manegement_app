# A級問題集（上級レベル）

A級は高度なアルゴリズムと最適化技術を学ぶレベルです。多くの企業の技術面接やプログラミングコンテストで出題される難しい問題に挑戦します。

## 学習目標

- 高度な動的プログラミング
- グラフアルゴリズムの応用
- 効率的な数値計算アルゴリズム
- 複雑なデータ構造の実装
- 最適化問題の解法
- 計算幾何の基礎

## 主な問題パターン

1. **高度なDP**: 区間DP、状態圧縮DP、確率DP
2. **グラフアルゴリズム**: 最短経路、最小全域木、フロー
3. **文字列アルゴリズム**: KMP、Z-algorithm、Suffix Array
4. **数学的アルゴリズム**: 高速指数計算、数論、組み合わせ
5. **ゲーム理論**: Minimax、Alpha-Beta枝刈り
6. **計算幾何**: 凸包、線分交差、最近点対
7. **高度なデータ構造**: セグメント木、Binary Indexed Tree

## 高度なアルゴリズムの実装

### 1. ダイクストラ法（最短経路）
```ruby
require 'set'

def dijkstra(graph, start)
  distances = Hash.new(Float::INFINITY)
  distances[start] = 0
  unvisited = Set.new(graph.keys)
  
  until unvisited.empty?
    # 最小距離の未訪問ノードを選択
    current = unvisited.min_by { |node| distances[node] }
    unvisited.delete(current)
    
    graph[current].each do |neighbor, weight|
      new_distance = distances[current] + weight
      if new_distance < distances[neighbor]
        distances[neighbor] = new_distance
      end
    end
  end
  
  distances
end
```

### 2. セグメント木
```ruby
class SegmentTree
  def initialize(arr)
    @n = arr.length
    @tree = Array.new(4 * @n, 0)
    build(arr, 0, 0, @n - 1)
  end
  
  private
  
  def build(arr, node, start, end_pos)
    if start == end_pos
      @tree[node] = arr[start]
    else
      mid = (start + end_pos) / 2
      build(arr, 2 * node + 1, start, mid)
      build(arr, 2 * node + 2, mid + 1, end_pos)
      @tree[node] = @tree[2 * node + 1] + @tree[2 * node + 2]
    end
  end
  
  public
  
  def update(idx, val, node = 0, start = 0, end_pos = @n - 1)
    if start == end_pos
      @tree[node] = val
    else
      mid = (start + end_pos) / 2
      if idx <= mid
        update(idx, val, 2 * node + 1, start, mid)
      else
        update(idx, val, 2 * node + 2, mid + 1, end_pos)
      end
      @tree[node] = @tree[2 * node + 1] + @tree[2 * node + 2]
    end
  end
  
  def query(l, r, node = 0, start = 0, end_pos = @n - 1)
    return 0 if r < start || end_pos < l
    return @tree[node] if l <= start && end_pos <= r
    
    mid = (start + end_pos) / 2
    left_sum = query(l, r, 2 * node + 1, start, mid)
    right_sum = query(l, r, 2 * node + 2, mid + 1, end_pos)
    left_sum + right_sum
  end
end
```

### 3. 最長増加部分列（LIS）
```ruby
def longest_increasing_subsequence(arr)
  return 0 if arr.empty?
  
  # dp[i] = 長さi+1のLISの末尾要素の最小値
  dp = []
  
  arr.each do |num|
    # 二分探索でnumが入る位置を見つける
    left, right = 0, dp.length
    while left < right
      mid = (left + right) / 2
      if dp[mid] < num
        left = mid + 1
      else
        right = mid
      end
    end
    
    if left == dp.length
      dp << num
    else
      dp[left] = num
    end
  end
  
  dp.length
end
```

### 4. トポロジカルソート
```ruby
def topological_sort(graph, in_degree)
  queue = []
  result = []
  
  # 入次数が0のノードをキューに追加
  in_degree.each do |node, degree|
    queue << node if degree == 0
  end
  
  until queue.empty?
    current = queue.shift
    result << current
    
    graph[current].each do |neighbor|
      in_degree[neighbor] -= 1
      queue << neighbor if in_degree[neighbor] == 0
    end
  end
  
  result
end
```

## 動的プログラミングの高度なパターン

### 1. 区間DP
```ruby
# 行列の連鎖積
def matrix_chain_multiplication(dimensions)
  n = dimensions.length - 1
  dp = Array.new(n) { Array.new(n, 0) }
  
  (2..n).each do |length|
    (0..n-length).each do |i|
      j = i + length - 1
      dp[i][j] = Float::INFINITY
      
      (i...j).each do |k|
        cost = dp[i][k] + dp[k+1][j] + 
               dimensions[i] * dimensions[k+1] * dimensions[j+1]
        dp[i][j] = [dp[i][j], cost].min
      end
    end
  end
  
  dp[0][n-1]
end
```

### 2. 状態圧縮DP
```ruby
# 巡回セールスマン問題
def traveling_salesman(dist)
  n = dist.length
  dp = Array.new(1 << n) { Array.new(n, Float::INFINITY) }
  dp[1][0] = 0  # スタート地点
  
  (0...(1 << n)).each do |mask|
    (0...n).each do |u|
      next if dp[mask][u] == Float::INFINITY
      
      (0...n).each do |v|
        next if mask & (1 << v) != 0  # 既に訪問済み
        
        new_mask = mask | (1 << v)
        dp[new_mask][v] = [dp[new_mask][v], 
                          dp[mask][u] + dist[u][v]].min
      end
    end
  end
  
  # 全都市を訪問してスタート地点に戻る
  min_cost = Float::INFINITY
  (1...n).each do |i|
    min_cost = [min_cost, 
               dp[(1 << n) - 1][i] + dist[i][0]].min
  end
  
  min_cost
end
```

## 文字列アルゴリズム

### KMP法
```ruby
def kmp_search(text, pattern)
  def build_failure_function(pattern)
    failure = Array.new(pattern.length, 0)
    j = 0
    
    (1...pattern.length).each do |i|
      while j > 0 && pattern[i] != pattern[j]
        j = failure[j - 1]
      end
      
      if pattern[i] == pattern[j]
        j += 1
      end
      
      failure[i] = j
    end
    
    failure
  end
  
  failure = build_failure_function(pattern)
  matches = []
  j = 0
  
  text.each_char.with_index do |char, i|
    while j > 0 && char != pattern[j]
      j = failure[j - 1]
    end
    
    if char == pattern[j]
      j += 1
    end
    
    if j == pattern.length
      matches << i - j + 1
      j = failure[j - 1]
    end
  end
  
  matches
end
```

## 学習戦略

1. **理論の理解**: アルゴリズムの動作原理を完全に理解
2. **実装練習**: 擬似コードから実際のコードへの変換
3. **最適化技術**: 定数倍の高速化、メモリ効率
4. **問題パターンの習得**: 似た問題への応用力
5. **デバッグスキル**: 複雑なアルゴリズムのバグ発見

## 練習問題

1. **高度なDP**: ナップサック変形、LCS、編集距離
2. **グラフアルゴリズム**: 最短経路、最小全域木
3. **文字列処理**: パターンマッチング、回文判定
4. **数学問題**: 高速指数計算、素因数分解
5. **ゲーム問題**: Nim、戦略ゲーム
6. **幾何問題**: 凸包、最近点対

A級をクリアすれば、上級プログラマーとしての実力が証明されます。
多くの難しいプログラミング問題に対応できるレベルに到達します。