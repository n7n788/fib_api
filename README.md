# フィボナッチ数列API

フィボナッチ数列を計算するサービスを提供するWebアプリケーションです。Ruby on Railsで構築されており、効率的にフィボナッチ数を取得するためのエンドポイントを提供します。

## 特徴

- RESTful API: フィボナッチ数の位置を指定して数値を取得できます。
- 入力バリデーション: 無効な入力に対するエラーハンドリングを実装。
- スケーラブルな設計: 大規模な入力に対応可能。
  
## 必要要件

- Ruby 3.3.0
- Rails 7.0.4.3
- Bundler
- SQlite

## セットアップ手順

1. リポジトリをクローン

```sh
git clone https://github.com/n7n788/fib_api.git
cd fib_api
```

2. ライブラリをインストール

```sh
bundle install
```

3. データベースをセットアップ

```sh
rails db:create db:migrate
```

4. Railsサーバーを起動

```sh
rails server
```

5. アプリケーションにアクセス: http://localhost:3000

## APIドキュメント

### エンドポイントURL

https://sample-app1-rzah.onrender.com/

### エンドポイント: GET `/fib`

クエリパラメータ
- `n` (必須): フィボナッチ数列の位置 (整数、1始まりのインデックス)。
  
例:

```sh
GET https://sample-app1-rzah.onrender.com/fib?n=99
```

レスポンス

- 成功 (HTTP 200)

```json
{
    "result": 218922995834555169026
}
```

- 失敗 (HTTP 400)

```json
{
    "status": 400
    "message": "Bad resquest."
}
```

## テストの実行

以下のコマンドでテストスイートを実行できます
```sh
bundle exec rspec
```

## スケーラブルな設計

フィボナッチ数列はメモ化再帰によって計算します。これにより、各計算量はO(n: フィボナッチ数の位置)で済みます。また、一度計算された値はデータベースに保存されるため、以降はO(1)で済みます。これにより、リクエスト数に対してスケーラブルな実装になっています。