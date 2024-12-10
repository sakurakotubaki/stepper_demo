# デンタルクリニック予約アプリ

## アプリケーションの概要

このFlutterアプリケーションは、歯科医院の予約システムを提供する簡単なアプリです。

## 主な機能

- ホーム画面
  - クリニック名（俺ちゃんデンタルクリニック）の表示
  - 予約ページへの遷移ボタン
  - Material Design 3に基づいたモダンなUI

- 予約画面
  - ステップ形式の予約フォーム
  - 直感的な操作性

## 技術的な実装について

### 使用している主な機能
- `MaterialApp`: アプリケーションのベース設定
  - デバッグバナーの非表示化
  - カスタムテーマカラーの設定
  - Material Design 3の採用

- `Navigator`: 画面遷移の実装
  - `MaterialPageRoute`を使用したページ遷移
  - `StatefulWidget`による状態管理

## 開発環境のセットアップ

1. Flutterの開発環境をセットアップしてください
2. このリポジトリをクローン
3. `flutter pub get`で依存関係をインストール
4. `flutter run`でアプリを実行

## 参考リソース

Flutterの開発に関する詳細な情報は以下をご覧ください：

- [Flutter公式ドキュメント](https://docs.flutter.dev/)
- [初めてのFlutterアプリ作成](https://docs.flutter.dev/get-started/codelab)
- [Flutterクックブック](https://docs.flutter.dev/cookbook)
