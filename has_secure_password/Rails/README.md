# has_secure_password

## 概要

has_secure_password を使った基本的な認証の仕組みを実装しています。

## 使い方

ただ docker-compose で起動するだけです。

```
docker-compose up
```

## 対応時コマンド

ruby 2.7.1 系をベースに作成しました。

- ruby:2.7.1-buster をベースイメージとして作成。

```
docker run --name rails271 -d -v ~/src/github.com/shoutatani/rails_authentication_examples/has_secure_password/Rails:/RailsApp/ ruby:2.7.1-buster tail -f /dev/null
```

- Rails6 環境の構築

```log
$ cd RailsApp/
$ bundle init # => rails gemを有効化
$ bundle install --jobs=4
$ bundle exec rails new . -B -d mysql --skip-turbolinks --skip-javascript
$ bundle install
```

- has_secure_password を使うために、bcrypt 対応

  `gem 'bcrypt'` を Gemfile に追記

```
$ bundle install
```

- User モデル作成

```
$ bin/rails g model User first_name:string last_name:string email:string password_digest:string
$ bin/rails db:abort_if_pending_migrations
$ bin/rails db:migrate
```

- has_secure_password をモデルに追記

- 必要なアクションを備えたコントローラーを作成し実装

```
$ bin/rails g controller users new create edit update quit quit_complete
$ bin/rails g controller user_login login auth logout
$ bin/rails g migration add_unique_on_email_to_users
$ bin/rails g migration add_remember_digest_to_users remember_digest:string
$ bin/rails db:migrate
```

- RSpec 追加

  `gem 'rspec-rails', '~> 4.0.0'` を Gemfile に追記

```
$ bin/rails generate rspec:install
$ bin/rails g rspec:model user
```
