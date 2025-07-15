このプロジェクトは Cursor AI コーディングアシスタントを活用して作成されています。

# 家計管理アプリ

このアプリは Flutter で作成したシンプルな家計管理アプリです。収入・支出の記録、月別サマリー、カテゴリ別管理、取引履歴の表示・削除など、日々の家計簿管理をサポートします。

## 主な機能

- 収入・支出の記録（カテゴリ・日付・メモ付き）
- 月別サマリー表示（収入・支出・残高）
- カテゴリ別管理
- 取引履歴の一覧表示・スワイプ削除
- 直感的な UI（Material Design）
- ローカル DB（SQLite）によるデータ保存

## セットアップ方法

1. Flutter のインストール（[公式ガイド](https://docs.flutter.dev/get-started/install)）
2. このリポジトリをクローン
   ```sh
   git clone https://github.com/hikarucode1/money_manegement_app.git
   cd money_manegement_app
   ```
3. 依存パッケージの取得
   ```sh
   flutter pub get
   ```
4. 実行
   - macOS アプリとして実行
     ```sh
     flutter run -d macos
     ```
   - iOS シミュレーター/実機で実行
     ```sh
     flutter run -d <デバイスID>
     ```
   - Web で実行
     ```sh
     flutter run -d chrome
     ```

## ディレクトリ構成

- `lib/`
  - `models/` ... データモデル
  - `providers/` ... 状態管理
  - `services/` ... DB 操作
  - `screens/` ... 画面 UI
- `ios/`, `macos/`, `android/`, `web/` ... 各プラットフォーム用設定

## ライセンス

このプロジェクトは MIT ライセンスのもとで公開されています。

---

ご質問・ご要望は Issue または Pull Request でお気軽にどうぞ！
