# 防災アプリ（Flutter）

このリポジトリは Flutter を用いて開発している防災アプリです。
複数人での開発を想定し、開発環境のセットアップ方法、ブランチ運用ルール、レビューの流れをまとめています。

⸻

## 📦 前提条件

    -	Flutter SDK （最新の安定版を推奨）
    -	Dart
    -	Node.js / npm（必要な場合のみ）
    -	Git

※ Flutter のインストール方法: 公式ドキュメント

⸻

## ⚙️ セットアップ

### リポジトリをクローン

```
git clone <リポジトリURL>
cd my_web_app
```

### 依存関係を取得

```
flutter pub get
```

⸻

## 🚀 実行方法

### Web（Chrome で確認）

```
flutter run -d chrome
```

### iOS

```
flutter run -d ios
```

### Android

```
flutter run -d android
```

⸻

## 📂 フォルダ構成

```
my_web_app/
├── android/ # Android プロジェクト関連
├── ios/ # iOS プロジェクト関連
├── lib/ # Flutter アプリのメインコード
│ ├── data/ # データ管理
│ ├── models/ # モデル定義
│ ├── pages/ # 画面（UI）
│ ├── services/ # サービス層（API 通信など）
│ ├── widgets/ # 共通ウィジェット
│ └── main.dart # エントリーポイント
├── test/ # テストコード
├── pubspec.yaml # 依存関係の管理
└── README.md
```

⸻

## 🌱 ブランチ運用ルール

- main ブランチ
- 常にリリース可能な状態を保つ
- 開発者が直接 push しない
- develop ブランチ
- 開発のベースとなるブランチ
- 機能追加・修正はここへマージする
- feature ブランチ
- 新機能開発用
- 命名規則: feature/機能名
- 例: feature/map-display
- fix ブランチ
- バグ修正用
- 命名規則: fix/修正内容
- 例: fix/login-crash
- hotfix ブランチ
- 本番環境での緊急修正
- 命名規則: hotfix/修正内容

⸻

## 🔄 開発フロー

### 1. ブランチ作成

```
git checkout develop
git pull origin develop
git checkout -b feature/〇〇
```

### 2. 作業 & コミット

```
git add .
git commit -m "Add: 〇〇機能"
```

### 3. プッシュ

```
git push origin feature/〇〇
```

### 4. Pull Request (PR) 作成

- 対象ブランチ: develop
- PR テンプレートに沿って記入

⸻

## 👀 レビューの流れ 1. PR 作成者

- feature/〇〇 → develop への PR を作成
- 必要に応じてスクリーンショットや実行方法を添付 2. レビュー担当者
- コードの可読性・再利用性・命名規則を確認
- 動作確認（flutter run -d chrome 等）を実施 3. 修正が必要な場合
- コメントを残す
- 作成者は修正し、再度プッシュ 4. 承認後
- develop にマージ
- main へのリリース時は別途 PR を作成

⸻

## ✏️ コーディング規約

- lib/pages/ 配下には画面単位の UI を配置
- lib/widgets/ 配下には再利用可能な Widget を配置
- 命名規則やフォーマットは analysis_options.yaml に準拠
- コミットメッセージは以下を推奨
- Add: 機能追加
- Fix: バグ修正
- Update: 機能改善
- Refactor: リファクタリング

⸻

## ✅ 今後のタスク

issue で確認してください。
