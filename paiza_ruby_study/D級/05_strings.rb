# 問題1: 文字列の長さ
#
# 問題文：
# 文字列が入力されます。
# その文字列の長さを出力してください。
#
# 入力例：
# paiza
#
# 出力例：
# 5

# 解答例1
str = gets.chomp
puts str.length

# 別解（size使用）
# str = gets.chomp
# puts str.size

# ==================================================
# 問題2: 文字列の連結
#
# 問題文：
# 2つの文字列が空白区切りで入力されます。
# それらを連結して出力してください。
#
# 入力例：
# Hello World
#
# 出力例：
# HelloWorld

# 解答例2
# str1, str2 = gets.chomp.split
# puts str1 + str2

# 別解（文字列補間）
# str1, str2 = gets.chomp.split
# puts "#{str1}#{str2}"

# ==================================================
# 問題3: 文字列の反転
#
# 問題文：
# 文字列が入力されます。
# その文字列を逆順にして出力してください。
#
# 入力例：
# paiza
#
# 出力例：
# aziap

# 解答例3
# str = gets.chomp
# puts str.reverse

# ==================================================
# 問題4: 特定文字の個数
#
# 問題文：
# 文字列と文字が空白区切りで入力されます。
# 文字列中に指定された文字が何個あるかを出力してください。
#
# 入力例：
# paiza a
#
# 出力例：
# 3

# 解答例4
# str, char = gets.chomp.split
# puts str.count(char)

# 別解（select使用）
# str, char = gets.chomp.split
# puts str.chars.select { |c| c == char }.length

# ==================================================
# 問題5: 大文字小文字変換
#
# 問題文：
# アルファベットの文字列が入力されます。
# 小文字は大文字に、大文字は小文字に変換して出力してください。
#
# 入力例：
# Hello
#
# 出力例：
# hELLO

# 解答例5
# str = gets.chomp
# result = ""
# str.chars.each do |char|
#   if char >= 'a' && char <= 'z'
#     result += char.upcase
#   elsif char >= 'A' && char <= 'Z'
#     result += char.downcase
#   else
#     result += char
#   end
# end
# puts result

# 別解（swapcase使用）
# str = gets.chomp
# puts str.swapcase

# ==================================================
# 問題6: 部分文字列の検索
#
# 問題文：
# 2つの文字列が入力されます。
# 1つ目の文字列に2つ目の文字列が含まれているかを判定し、
# 含まれていれば "Yes"、含まれていなければ "No" を出力してください。
#
# 入力例：
# paiza programming
# iza
#
# 出力例：
# Yes

# 解答例6
# str = gets.chomp
# substr = gets.chomp
# if str.include?(substr)
#   puts "Yes"
# else
#   puts "No"
# end

# 別解（三項演算子）
# str = gets.chomp
# substr = gets.chomp
# puts str.include?(substr) ? "Yes" : "No"

# ==================================================
# 問題7: 文字列の置換
#
# 問題文：
# 文字列と2つの文字が入力されます。
# 文字列中の1つ目の文字をすべて2つ目の文字に置換して出力してください。
#
# 入力例：
# programming
# m
# n
#
# 出力例：
# progrannning

# 解答例7
# str = gets.chomp
# old_char = gets.chomp
# new_char = gets.chomp
# puts str.gsub(old_char, new_char)

# 別解（tr使用）
# str = gets.chomp
# old_char = gets.chomp
# new_char = gets.chomp
# puts str.tr(old_char, new_char)

# ==================================================
# 問題8: 回文判定
#
# 問題文：
# 文字列が入力されます。
# その文字列が回文（前から読んでも後ろから読んでも同じ）かどうかを判定し、
# 回文なら "Yes"、そうでなければ "No" を出力してください。
#
# 入力例：
# racecar
#
# 出力例：
# Yes

# 解答例8
# str = gets.chomp
# if str == str.reverse
#   puts "Yes"
# else
#   puts "No"
# end

# ==================================================
# 学習ポイント
#
# 1. length/size: 文字列の長さ
# 2. + や #{}: 文字列の連結
# 3. reverse: 文字列の逆順
# 4. count: 特定文字の個数
# 5. chars: 文字列を文字の配列に変換
# 6. upcase/downcase/swapcase: 大文字小文字変換
# 7. include?: 部分文字列の検索
# 8. gsub/tr: 文字列の置換
# 9. 文字列比較による回文判定
# 10. 文字列操作メソッドの連鎖