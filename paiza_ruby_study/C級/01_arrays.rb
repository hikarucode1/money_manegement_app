# 問題1: 配列の最大値・最小値のインデックス
#
# 問題文：
# n個の整数が入力されます。
# 最大値のインデックスと最小値のインデックスを出力してください。
# （インデックスは0から始まる）
#
# 入力例：
# 5
# 3 1 4 1 5
#
# 出力例：
# 4
# 1

# 解答例1
n = gets.to_i
arr = gets.split.map(&:to_i)

max_index = arr.index(arr.max)
min_index = arr.index(arr.min)

puts max_index
puts min_index

# ==================================================
# 問題2: 配列の重複削除
#
# 問題文：
# n個の整数が入力されます。
# 重複を削除して、出現順にユニークな要素を出力してください。
#
# 入力例：
# 7
# 1 2 3 2 1 4 3
#
# 出力例：
# 1 2 3 4

# 解答例2
# n = gets.to_i
# arr = gets.split.map(&:to_i)
# puts arr.uniq.join(' ')

# ==================================================
# 問題3: 要素の頻度計算
#
# 問題文：
# n個の整数が入力されます。
# 各数値の出現回数を、数値の昇順で出力してください。
#
# 入力例：
# 6
# 1 2 1 3 2 1
#
# 出力例：
# 1: 3
# 2: 2
# 3: 1

# 解答例3
# n = gets.to_i
# arr = gets.split.map(&:to_i)
# 
# freq = Hash.new(0)
# arr.each { |num| freq[num] += 1 }
# 
# freq.sort.each do |num, count|
#   puts "#{num}: #{count}"
# end

# 別解（group_by使用）
# n = gets.to_i
# arr = gets.split.map(&:to_i)
# 
# freq = arr.group_by(&:itself).transform_values(&:length)
# freq.sort.each do |num, count|
#   puts "#{num}: #{count}"
# end

# ==================================================
# 問題4: 配列の部分和
#
# 問題文：
# n個の整数が入力されます。
# 連続する部分配列の中で、合計が最大となる値を出力してください。
#
# 入力例：
# 6
# -2 1 -3 4 -1 2
#
# 出力例：
# 5

# 解答例4（Kadane's Algorithm）
# n = gets.to_i
# arr = gets.split.map(&:to_i)
# 
# max_ending_here = arr[0]
# max_so_far = arr[0]
# 
# (1...n).each do |i|
#   max_ending_here = [arr[i], max_ending_here + arr[i]].max
#   max_so_far = [max_so_far, max_ending_here].max
# end
# 
# puts max_so_far

# ==================================================
# 問題5: 配列のローテーション
#
# 問題文：
# n個の整数とローテーション回数kが入力されます。
# 配列を右にk回ローテーションした結果を出力してください。
#
# 入力例：
# 5 2
# 1 2 3 4 5
#
# 出力例：
# 4 5 1 2 3

# 解答例5
# n, k = gets.split.map(&:to_i)
# arr = gets.split.map(&:to_i)
# 
# k = k % n  # 配列の長さより大きい場合の対応
# rotated = arr[-k..-1] + arr[0...-k]
# 
# puts rotated.join(' ')

# 別解（rotate使用）
# n, k = gets.split.map(&:to_i)
# arr = gets.split.map(&:to_i)
# 
# puts arr.rotate(-k).join(' ')

# ==================================================
# 問題6: 2つの配列の共通要素
#
# 問題文：
# 2つの配列が入力されます。
# 両方の配列に含まれる要素を昇順で出力してください。
#
# 入力例：
# 4
# 1 3 5 7
# 5
# 2 3 5 8 9
#
# 出力例：
# 3 5

# 解答例6
# n1 = gets.to_i
# arr1 = gets.split.map(&:to_i)
# n2 = gets.to_i
# arr2 = gets.split.map(&:to_i)
# 
# common = (arr1 & arr2).sort
# puts common.join(' ')

# ==================================================
# 問題7: 配列の中央値
#
# 問題文：
# n個の整数が入力されます。
# 中央値を出力してください。
# （nが偶数の場合は、中央2つの値の平均を小数点以下1桁で出力）
#
# 入力例：
# 5
# 3 1 4 1 5
#
# 出力例：
# 3

# 解答例7
# n = gets.to_i
# arr = gets.split.map(&:to_i).sort
# 
# if n.odd?
#   puts arr[n / 2]
# else
#   median = (arr[n / 2 - 1] + arr[n / 2]) / 2.0
#   puts "%.1f" % median
# end

# ==================================================
# 学習ポイント
#
# 1. index, rindex: 要素のインデックス検索
# 2. uniq: 重複削除
# 3. Hash.new(0): デフォルト値付きハッシュ
# 4. group_by: グループ化による集計
# 5. Kadane's Algorithm: 最大部分和
# 6. 配列のスライス: arr[start..end], arr[start...end]
# 7. &（積集合）演算子
# 8. 中央値の計算方法
# 9. 計算量を意識したアルゴリズム選択