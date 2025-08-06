# 問題1: 偶数か奇数か
#
# 問題文：
# 整数 n が入力されます。
# n が偶数なら "even"、奇数なら "odd" を出力してください。
#
# 入力例：
# 4
#
# 出力例：
# even

# 解答例1
n = gets.to_i
if n % 2 == 0
  puts "even"
else
  puts "odd"
end

# 別解（三項演算子）
# n = gets.to_i
# puts n % 2 == 0 ? "even" : "odd"

# ==================================================
# 問題2: 数の大小比較
#
# 問題文：
# 2つの整数 a, b が空白区切りで入力されます。
# a > b なら "a"、a < b なら "b"、a == b なら "equal" を出力してください。
#
# 入力例：
# 3 5
#
# 出力例：
# b

# 解答例2
# a, b = gets.split.map(&:to_i)
# if a > b
#   puts "a"
# elsif a < b
#   puts "b"
# else
#   puts "equal"
# end

# ==================================================
# 問題3: 成績判定
#
# 問題文：
# 点数（0-100）が入力されます。
# 80以上なら "A"、60以上なら "B"、40以上なら "C"、それ未満なら "D" を出力してください。
#
# 入力例：
# 75
#
# 出力例：
# B

# 解答例3
# score = gets.to_i
# if score >= 80
#   puts "A"
# elsif score >= 60
#   puts "B"
# elsif score >= 40
#   puts "C"
# else
#   puts "D"
# end

# 別解（case文）
# score = gets.to_i
# grade = case score
#         when 80..100
#           "A"
#         when 60...80
#           "B"
#         when 40...60
#           "C"
#         else
#           "D"
#         end
# puts grade

# ==================================================
# 問題4: うるう年判定
#
# 問題文：
# 年が入力されます。
# うるう年なら "Yes"、そうでなければ "No" を出力してください。
# うるう年の条件：
# - 4で割り切れる
# - ただし、100で割り切れる場合は平年
# - ただし、400で割り切れる場合はうるう年
#
# 入力例：
# 2000
#
# 出力例：
# Yes

# 解答例4
# year = gets.to_i
# if year % 400 == 0
#   puts "Yes"
# elsif year % 100 == 0
#   puts "No"
# elsif year % 4 == 0
#   puts "Yes"
# else
#   puts "No"
# end

# 別解（論理演算子）
# year = gets.to_i
# is_leap = (year % 4 == 0 && year % 100 != 0) || year % 400 == 0
# puts is_leap ? "Yes" : "No"

# ==================================================
# 問題5: 温度判定
#
# 問題文：
# 気温が入力されます。
# 30度以上なら "hot"、20度以上30度未満なら "warm"、
# 10度以上20度未満なら "cool"、10度未満なら "cold" を出力してください。
#
# 入力例：
# 25
#
# 出力例：
# warm

# 解答例5
# temp = gets.to_i
# if temp >= 30
#   puts "hot"
# elsif temp >= 20
#   puts "warm"
# elsif temp >= 10
#   puts "cool"
# else
#   puts "cold"
# end

# ==================================================
# 学習ポイント
#
# 1. if-elsif-else による多分岐
# 2. % 演算子による剰余の判定
# 3. 三項演算子 condition ? true_value : false_value
# 4. case文による範囲指定（..は含む、...は含まない）
# 5. 論理演算子（&&: AND, ||: OR, !: NOT）
# 6. 比較演算子（==, !=, <, >, <=, >=）
# 7. 条件の優先順位を考慮した分岐の書き方