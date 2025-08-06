# B級問題集（中級レベル）

B級は実用的なアルゴリズムとデータ構造を学ぶレベルです。ここから企業の技術面接で出題されるような問題に近づきます。

## 学習目標

- 効率的なアルゴリズムの実装
- グラフと木構造の基本
- 動的プログラミングの入門
- 探索アルゴリズムの理解
- 文字列アルゴリズムの応用
- データ構造の適切な選択

## 主な問題パターン

1. **グラフ理論**: BFS、DFS、最短経路
2. **木構造**: 二分木、木の走査
3. **動的プログラミング**: メモ化、最適化問題
4. **高度な文字列処理**: 文字列マッチング、変換
5. **数学的アルゴリズム**: 素数、組み合わせ、数論
6. **ゲーム理論**: 勝敗判定、最適戦略
7. **最適化問題**: 貪欲法、分割統治法

## 高度なRubyテクニック

### グラフの表現と探索
```ruby
# 隣接リスト表現
graph = Hash.new { |h, k| h[k] = [] }
graph[1] << 2
graph[1] << 3

# BFS（幅優先探索）
def bfs(graph, start, goal)
  queue = [start]
  visited = Set.new([start])
  
  until queue.empty?
    current = queue.shift
    return true if current == goal
    
    graph[current].each do |neighbor|
      unless visited.include?(neighbor)
        visited.add(neighbor)
        queue << neighbor
      end
    end
  end
  false
end

# DFS（深さ優先探索）
def dfs(graph, current, goal, visited = Set.new)
  return true if current == goal
  visited.add(current)
  
  graph[current].each do |neighbor|
    unless visited.include?(neighbor)
      return true if dfs(graph, neighbor, goal, visited)
    end
  end
  false
end
```

### 動的プログラミング
```ruby
# メモ化を使ったフィボナッチ
def fibonacci(n, memo = {})
  return memo[n] if memo[n]
  
  if n <= 1
    memo[n] = n
  else
    memo[n] = fibonacci(n-1, memo) + fibonacci(n-2, memo)
  end
end

# ナップサック問題
def knapsack(weights, values, capacity)
  n = weights.length
  dp = Array.new(n+1) { Array.new(capacity+1, 0) }
  
  (1..n).each do |i|
    (1..capacity).each do |w|
      if weights[i-1] <= w
        dp[i][w] = [dp[i-1][w], 
                   dp[i-1][w-weights[i-1]] + values[i-1]].max
      else
        dp[i][w] = dp[i-1][w]
      end
    end
  end
  
  dp[n][capacity]
end
```

### 高度なデータ構造
```ruby
# Union-Find（素集合データ構造）
class UnionFind
  def initialize(n)
    @parent = (0...n).to_a
    @rank = Array.new(n, 0)
  end
  
  def find(x)
    if @parent[x] != x
      @parent[x] = find(@parent[x])  # 経路圧縮
    end
    @parent[x]
  end
  
  def union(x, y)
    px, py = find(x), find(y)
    return if px == py
    
    # ランクによる結合
    if @rank[px] < @rank[py]
      @parent[px] = py
    elsif @rank[px] > @rank[py]
      @parent[py] = px
    else
      @parent[py] = px
      @rank[px] += 1
    end
  end
  
  def connected?(x, y)
    find(x) == find(y)
  end
end
```

## アルゴリズムの計算量

### 時間計算量
- **O(log n)**: 二分探索、ヒープ操作
- **O(n log n)**: マージソート、ヒープソート
- **O(n²)**: バブルソート、選択ソート
- **O(2^n)**: 全探索、組み合わせ生成

### 空間計算量
- メモ化による空間とのトレードオフ
- 再帰の深さとスタックサイズ
- 動的配列の拡張コスト

## 問題解法のパターン

### 1. 貪欲法
```ruby
# 最小コインの枚数
def min_coins(coins, amount)
  coins.sort!.reverse!
  count = 0
  
  coins.each do |coin|
    count += amount / coin
    amount %= coin
  end
  
  amount == 0 ? count : -1
end
```

### 2. 分割統治法
```ruby
# マージソート
def merge_sort(arr)
  return arr if arr.length <= 1
  
  mid = arr.length / 2
  left = merge_sort(arr[0...mid])
  right = merge_sort(arr[mid..-1])
  
  merge(left, right)
end

def merge(left, right)
  result = []
  i = j = 0
  
  while i < left.length && j < right.length
    if left[i] <= right[j]
      result << left[i]
      i += 1
    else
      result << right[j]
      j += 1
    end
  end
  
  result + left[i..-1] + right[j..-1]
end
```

## 練習問題

このディレクトリには以下の問題が含まれています：

1. **グラフ探索**: BFS、DFS、連結成分
2. **動的プログラミング**: ナップサック、最長共通部分列
3. **文字列アルゴリズム**: 文字列マッチング、編集距離
4. **数学的問題**: 素数判定、組み合わせ計算
5. **ゲーム問題**: 勝敗判定、最適戦略
6. **最適化問題**: 最短経路、最小コスト

## 学習戦略

1. **アルゴリズムを理解してから実装**: まず理論を学習
2. **計算量を意識**: 効率的な解法を選択
3. **デバッグ技術**: 複雑な問題でのデバッグ方法
4. **パターン認識**: 似た問題の解法を応用
5. **実装力の向上**: コードを書く速度と正確性

B級をクリアすれば、実用的なプログラミングスキルが身についている証拠です。
多くのIT企業の技術面接レベルに到達します。