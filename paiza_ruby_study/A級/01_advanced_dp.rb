# 問題1: ナップサック問題（01ナップサック）
#
# 問題文：
# N個の品物があり、i番目の品物の重さはw[i]、価値はv[i]です。
# 重さの上限がWのナップサックに入れる品物の価値の合計の最大値を求めてください。
#
# 入力例：
# 4 5
# 2 3
# 1 2
# 3 4
# 2 2
#
# 出力例：
# 7

# 解答例1
def knapsack_01(n, w_limit, items)
  # dp[i][w] = i番目までの品物を考慮して重さwまでで得られる最大価値
  dp = Array.new(n + 1) { Array.new(w_limit + 1, 0) }
  
  (1..n).each do |i|
    weight, value = items[i - 1]
    
    (0..w_limit).each do |w|
      # i番目の品物を選ばない場合
      dp[i][w] = dp[i - 1][w]
      
      # i番目の品物を選ぶ場合（重さが許す場合のみ）
      if weight <= w
        dp[i][w] = [dp[i][w], dp[i - 1][w - weight] + value].max
      end
    end
  end
  
  dp[n][w_limit]
end

n, w_limit = gets.split.map(&:to_i)
items = []
n.times do
  weight, value = gets.split.map(&:to_i)
  items << [weight, value]
end

puts knapsack_01(n, w_limit, items)

# ==================================================
# 問題2: 最長共通部分列（LCS）
#
# 問題文：
# 2つの文字列S, Tが与えられます。
# SとTの最長共通部分列の長さを求めてください。
#
# 入力例：
# ABCDGH
# AEDFHR
#
# 出力例：
# 3

# 解答例2
# def longest_common_subsequence(s, t)
#   m, n = s.length, t.length
#   # dp[i][j] = s[0...i]とt[0...j]のLCSの長さ
#   dp = Array.new(m + 1) { Array.new(n + 1, 0) }
#   
#   (1..m).each do |i|
#     (1..n).each do |j|
#       if s[i - 1] == t[j - 1]
#         dp[i][j] = dp[i - 1][j - 1] + 1
#       else
#         dp[i][j] = [dp[i - 1][j], dp[i][j - 1]].max
#       end
#     end
#   end
#   
#   dp[m][n]
# end
# 
# s = gets.chomp
# t = gets.chomp
# puts longest_common_subsequence(s, t)

# ==================================================
# 問題3: 編集距離（レーベンシュタイン距離）
#
# 問題文：
# 2つの文字列S, Tが与えられます。
# Sを以下の操作でTに変換するのに必要な最小回数を求めてください。
# - 1文字挿入
# - 1文字削除
# - 1文字置換
#
# 入力例：
# kitten
# sitting
#
# 出力例：
# 3

# 解答例3
# def edit_distance(s, t)
#   m, n = s.length, t.length
#   # dp[i][j] = s[0...i]をt[0...j]に変換する最小コスト
#   dp = Array.new(m + 1) { Array.new(n + 1, 0) }
#   
#   # 初期化
#   (0..m).each { |i| dp[i][0] = i }  # 削除のみ
#   (0..n).each { |j| dp[0][j] = j }  # 挿入のみ
#   
#   (1..m).each do |i|
#     (1..n).each do |j|
#       if s[i - 1] == t[j - 1]
#         dp[i][j] = dp[i - 1][j - 1]  # コストなし
#       else
#         dp[i][j] = [
#           dp[i - 1][j] + 1,     # 削除
#           dp[i][j - 1] + 1,     # 挿入
#           dp[i - 1][j - 1] + 1  # 置換
#         ].min
#       end
#     end
#   end
#   
#   dp[m][n]
# end
# 
# s = gets.chomp
# t = gets.chomp
# puts edit_distance(s, t)

# ==================================================
# 問題4: 最長増加部分列（LIS）
#
# 問題文：
# N個の数列が与えられます。
# 最長増加部分列の長さを求めてください。
#
# 入力例：
# 8
# 1 3 2 4 6 5 7 8
#
# 出力例：
# 6

# 解答例4（O(N log N)解法）
# def longest_increasing_subsequence(arr)
#   return 0 if arr.empty?
#   
#   # dp[i] = 長さi+1のLISの末尾要素の最小値
#   dp = []
#   
#   arr.each do |num|
#     # 二分探索でnumが入る位置を見つける
#     left, right = 0, dp.length
#     while left < right
#       mid = (left + right) / 2
#       if dp[mid] < num
#         left = mid + 1
#       else
#         right = mid
#       end
#     end
#     
#     if left == dp.length
#       dp << num
#     else
#       dp[left] = num
#     end
#   end
#   
#   dp.length
# end
# 
# n = gets.to_i
# arr = gets.split.map(&:to_i)
# puts longest_increasing_subsequence(arr)

# ==================================================
# 問題5: 区間DP（行列の連鎖積）
#
# 問題文：
# N個の行列の連鎖積を計算する時の最小スカラー乗算回数を求めてください。
# i番目の行列のサイズは p[i-1] × p[i] です。
#
# 入力例：
# 4
# 1 2 3 4
#
# 出力例：
# 18

# 解答例5
# def matrix_chain_multiplication(p)
#   n = p.length - 1
#   # dp[i][j] = 行列i〜jの連鎖積の最小コスト
#   dp = Array.new(n) { Array.new(n, 0) }
#   
#   # lengthは連鎖の長さ
#   (2..n).each do |length|
#     (0..n-length).each do |i|
#       j = i + length - 1
#       dp[i][j] = Float::INFINITY
#       
#       (i...j).each do |k|
#         cost = dp[i][k] + dp[k+1][j] + p[i] * p[k+1] * p[j+1]
#         dp[i][j] = [dp[i][j], cost].min
#       end
#     end
#   end
#   
#   dp[0][n-1]
# end
# 
# n = gets.to_i
# p = gets.split.map(&:to_i)
# puts matrix_chain_multiplication(p)

# ==================================================
# 問題6: 確率DP（コイン問題）
#
# 問題文：
# 表が出る確率がp[i]のコインがN個あります。
# 全てのコインを投げて、表が出るコインの数がK個以上になる確率を求めてください。
#
# 入力例：
# 3 2
# 0.5 0.3 0.7
#
# 出力例：
# 0.44

# 解答例6
# def coin_probability(n, k, probs)
#   # dp[i][j] = i個目までのコインで表がj個出る確率
#   dp = Array.new(n + 1) { Array.new(n + 1, 0.0) }
#   dp[0][0] = 1.0
#   
#   (1..n).each do |i|
#     p = probs[i - 1]
#     (0..i).each do |j|
#       # i個目のコインが裏の場合
#       dp[i][j] += dp[i - 1][j] * (1 - p) if j <= i - 1
#       
#       # i個目のコインが表の場合
#       dp[i][j] += dp[i - 1][j - 1] * p if j > 0
#     end
#   end
#   
#   # K個以上の確率を計算
#   result = 0.0
#   (k..n).each do |j|
#     result += dp[n][j]
#   end
#   
#   result
# end
# 
# n, k = gets.split.map(&:to_i)
# probs = gets.split.map(&:to_f)
# puts "%.2f" % coin_probability(n, k, probs)

# ==================================================
# 学習ポイント
#
# 1. 01ナップサック: 各アイテムを0個または1個選ぶ
# 2. LCS: 2次元DPの典型問題
# 3. 編集距離: 3つの操作の最小コスト
# 4. LIS: 二分探索による高速化（O(N log N)）
# 5. 区間DP: 最適な分割点を探す
# 6. 確率DP: 期待値・確率の計算
# 7. メモ化: 再計算を避ける最適化技術
# 8. 状態設計: 問題に応じた適切な状態定義