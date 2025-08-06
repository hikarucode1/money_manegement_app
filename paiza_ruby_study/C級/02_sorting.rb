# 問題1: 基本ソート
#
# 問題文：
# n個の整数が入力されます。
# 昇順でソートして出力してください。
#
# 入力例：
# 5
# 3 1 4 1 5
#
# 出力例：
# 1 1 3 4 5

# 解答例1
n = gets.to_i
arr = gets.split.map(&:to_i)
puts arr.sort.join(' ')

# ==================================================
# 問題2: 文字列の長さでソート
#
# 問題文：
# n個の文字列が入力されます。
# 文字列の長さの昇順でソートして出力してください。
# 長さが同じ場合は辞書順で並べてください。
#
# 入力例：
# 4
# banana
# cat
# dog
# elephant
#
# 出力例：
# cat
# dog
# banana
# elephant

# 解答例2
# n = gets.to_i
# strings = []
# n.times do
#   strings << gets.chomp
# end
# 
# sorted = strings.sort_by { |s| [s.length, s] }
# puts sorted

# ==================================================
# 問題3: 偶数奇数分類ソート
#
# 問題文：
# n個の整数が入力されます。
# 偶数を昇順、奇数を昇順で並べ、偶数を先に出力してください。
#
# 入力例：
# 6
# 3 8 1 6 5 2
#
# 出力例：
# 2 6 8 1 3 5

# 解答例3
# n = gets.to_i
# arr = gets.split.map(&:to_i)
# 
# evens = arr.select(&:even?).sort
# odds = arr.select(&:odd?).sort
# 
# puts (evens + odds).join(' ')

# 別解（partition使用）
# n = gets.to_i
# arr = gets.split.map(&:to_i)
# 
# evens, odds = arr.partition(&:even?)
# puts (evens.sort + odds.sort).join(' ')

# ==================================================
# 問題4: 成績表ソート
#
# 問題文：
# n人の学生の名前と点数が入力されます。
# 点数の降順でソートし、点数が同じ場合は名前の昇順で出力してください。
#
# 入力例：
# 4
# Alice 85
# Bob 90
# Charlie 85
# David 95
#
# 出力例：
# David 95
# Bob 90
# Alice 85
# Charlie 85

# 解答例4
# n = gets.to_i
# students = []
# 
# n.times do
#   line = gets.chomp.split
#   name = line[0]
#   score = line[1].to_i
#   students << [name, score]
# end
# 
# sorted = students.sort_by { |name, score| [-score, name] }
# 
# sorted.each do |name, score|
#   puts "#{name} #{score}"
# end

# ==================================================
# 問題5: 安定ソートの確認
#
# 問題文：
# n個の数値とその元のインデックスが入力されます。
# 数値でソートした時の元のインデックスの順序を出力してください。
#
# 入力例：
# 5
# 3 1 4 1 5
#
# 出力例：
# 1 3 0 2 4

# 解答例5
# n = gets.to_i
# arr = gets.split.map(&:to_i)
# 
# # 値とインデックスのペアを作成
# indexed_arr = arr.each_with_index.map { |val, idx| [val, idx] }
# 
# # 値でソートし、元のインデックスを取得
# sorted_indices = indexed_arr.sort_by(&:first).map(&:last)
# 
# puts sorted_indices.join(' ')

# ==================================================
# 問題6: カスタムソート（距離）
#
# 問題文：
# n個の座標(x, y)が入力されます。
# 原点(0, 0)からの距離が近い順にソートして出力してください。
# 距離が同じ場合はx座標の昇順で並べてください。
#
# 入力例：
# 4
# 1 1
# 2 0
# 0 2
# 3 4
#
# 出力例：
# 1 1
# 0 2
# 2 0
# 3 4

# 解答例6
# n = gets.to_i
# points = []
# 
# n.times do
#   x, y = gets.split.map(&:to_i)
#   points << [x, y]
# end
# 
# sorted = points.sort_by { |x, y| [x*x + y*y, x] }
# 
# sorted.each do |x, y|
#   puts "#{x} #{y}"
# end

# ==================================================
# 問題7: バブルソート実装
#
# 問題文：
# n個の整数が入力されます。
# バブルソートのアルゴリズムで何回swapが発生するかを出力してください。
#
# 入力例：
# 5
# 3 1 4 1 5
#
# 出力例：
# 4

# 解答例7
# n = gets.to_i
# arr = gets.split.map(&:to_i)
# 
# swap_count = 0
# 
# (n-1).times do |i|
#   (n-1-i).times do |j|
#     if arr[j] > arr[j+1]
#       arr[j], arr[j+1] = arr[j+1], arr[j]
#       swap_count += 1
#     end
#   end
# end
# 
# puts swap_count

# ==================================================
# 問題8: 順位付け
#
# 問題文：
# n個の点数が入力されます。
# 各点数の順位を出力してください。（同点は同順位）
#
# 入力例：
# 5
# 85 90 85 95 80
#
# 出力例：
# 3 2 3 1 5

# 解答例8
# n = gets.to_i
# scores = gets.split.map(&:to_i)
# 
# # ユニークな点数を降順でソート
# unique_scores = scores.uniq.sort.reverse
# 
# # 各点数のランクを計算
# rank_map = {}
# unique_scores.each_with_index do |score, index|
#   rank_map[score] = index + 1
# end
# 
# ranks = scores.map { |score| rank_map[score] }
# puts ranks.join(' ')

# ==================================================
# 学習ポイント
#
# 1. sort: 基本ソート
# 2. sort_by: キーを指定したソート
# 3. partition: 条件で配列を分割
# 4. 複数キーでのソート: [key1, key2]
# 5. マイナス符号で降順ソート: -score
# 6. each_with_index: インデックス付き反復
# 7. バブルソートの実装と計算量理解
# 8. ハッシュを使った効率的なランキング
# 9. 安定ソートの概念