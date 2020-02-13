# BaseApi
![](https://github.com/yamashun/base_api/workflows/Rspec/badge.svg)

BASE APIのためのクライアントを提供するRuby gemです。（非公式です。）
[BASE API doc](https://docs.thebase.in/docs/api/)

BASEは簡単にネットショップを開設できる日本のサービスです。詳しくは公式ページを確認してください。
Please check the [official page](https://thebase.in/) for details.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'base_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install base_api

## Usage
### Basic usage

```ruby
# OAuth2.0で払い出されたBearerトークンを使ってクライアントのインスタンスを生成します。
client = BaseApi::Client.new(access_token: 'bearer token')

# 商品の取得
response = client.items
response['items']
```

### リスト返却APIで取得する要素数
リストを返すBASE APIで一度に返却される要素の個数はデフォルトで20となっています。変更したい場合は以下のいずれかの方法で変更できます。

```bash
# 環境変数に設定する
export BASE_API_LIMIT=30
```

or

```ruby
# クライアントを生成時に引数に渡す
client = BaseApi::Client.new(access_token: 'bearer token', limit: 30)
```

or

```ruby
# API呼び出し時に引数を渡す
client = BaseApi::Client.new(access_token: 'bearer token')
client.items({ limit: 30 })
```

### ページネーション
ページネーション用に `fetch_next_page` を用意しています。

```ruby
client = BaseApi::Client.new(access_token: 'bearer token')
# 1番目から20番目の要素を取得
client.items

# 21番目から40番目の要素を取得
client.fetch_next_page
```

### コールバック
ブロックを渡すことでAPIの結果に応じた処理をが可能です。ブロックはレスポンス結果とエラーオブジェクトを引数にとります。

```ruby
client.items do |res, err|
  if err
    # エラーに応じた処理
  else
    # レスポンスに応じた処理
  end
end
```



## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/base_api. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/base_api/blob/master/CODE_OF_CONDUCT.md).


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the BaseApi project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/base_api/blob/master/CODE_OF_CONDUCT.md).
