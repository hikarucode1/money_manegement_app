# C級問題集（中級初期レベル）

C級は基本的なアルゴリズムとデータ構造を学ぶレベルです。D級で学んだ基礎を活用して、より複雑な問題に挑戦します。

## 学習目標

- 配列とハッシュの活用
- 基本的なソートと探索
- 文字列の高度な操作
- 2次元配列の操作
- 基本的なアルゴリズムの理解
- 効率的なデータ処理

## 主な問題パターン

1. **配列操作**: 要素の検索、フィルタリング、変換
2. **ソート**: 単純ソート、条件付きソート
3. **探索**: 線形探索、値の存在判定
4. **文字列処理**: パターンマッチング、変換
5. **ハッシュ**: 頻度計算、グループ化
6. **2次元配列**: 行列操作、座標計算
7. **数値処理**: 進数変換、数学的計算

## Rubyの中級構文とメソッド

### 配列の高度な操作
```ruby
# 配列の変換とフィルタリング
arr = [1, 2, 3, 4, 5]
even_nums = arr.select { |n| n.even? }  # 偶数のみ
squares = arr.map { |n| n * n }         # 二乗
sum = arr.reduce(0) { |acc, n| acc + n } # 合計

# 配列の検索
arr.find { |n| n > 3 }      # 条件に合う最初の要素
arr.index(3)                # 要素のインデックス
arr.include?(3)             # 要素の存在確認
```

### ハッシュの活用
```ruby
# 頻度計算
chars = "hello".chars
freq = chars.each_with_object(Hash.new(0)) { |char, hash|
  hash[char] += 1
}

# グループ化
words = ["cat", "dog", "car", "door"]
grouped = words.group_by { |word| word.length }
```

### 文字列の高度な操作
```ruby
# 正規表現
str = "abc123def"
numbers = str.scan(/\d+/)          # 数字部分を抽出
str.gsub(/\d/, '*')                # 数字を*に置換

# 文字列の分割と結合
str.split(/\s+/)                   # 空白で分割
arr.join(', ')                     # カンマ区切りで結合
```

### 2次元配列
```ruby
# 2次元配列の初期化
matrix = Array.new(3) { Array.new(3, 0) }

# 行列の走査
matrix.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    puts "matrix[#{i}][#{j}] = #{cell}"
  end
end
```

## 練習問題

このディレクトリには以下の問題が含まれています：

1. **配列操作**: 要素の検索、変換、集計
2. **ソート問題**: 数値ソート、文字列ソート、カスタムソート
3. **探索問題**: 線形探索、二分探索の基礎
4. **文字列アルゴリズム**: パターンマッチング、変換
5. **ハッシュ活用**: 頻度計算、マッピング
6. **2次元配列**: 行列計算、座標処理
7. **数値計算**: 進数変換、数学的処理

## アルゴリズムの基礎知識

### 計算量の概念
- **O(1)**: 定数時間（配列のインデックスアクセス）
- **O(n)**: 線形時間（配列の全探索）
- **O(n²)**: 二次時間（二重ループ）
- **O(log n)**: 対数時間（二分探索）

### よく使うアルゴリズム
```ruby
# 線形探索
def linear_search(arr, target)
  arr.each_with_index do |value, index|
    return index if value == target
  end
  -1
end

# バブルソート（学習用）
def bubble_sort(arr)
  n = arr.length
  (n-1).times do |i|
    (n-1-i).times do |j|
      if arr[j] > arr[j+1]
        arr[j], arr[j+1] = arr[j+1], arr[j]
      end
    end
  end
  arr
end
```

## 学習のコツ

1. **データ構造を理解する**: 配列とハッシュの特性を把握
2. **メソッドチェーンを活用**: select, map, reduce等を組み合わせる
3. **パフォーマンスを意識**: 計算量を考えながらコードを書く
4. **エッジケースを考える**: 空配列、重複要素等の特殊ケース
5. **デバッグスキルを向上**: p やputsでデータの中身を確認

C級をクリアすれば、基本的なアルゴリズムとデータ構造が身についた証拠です。
次のレベル（B級）では、より高度なアルゴリズムに挑戦します。