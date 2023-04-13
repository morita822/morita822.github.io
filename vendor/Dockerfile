# ベースとなるイメージを指定
FROM ruby:2.7

# 必要なパッケージのインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# 作業ディレクトリの設定
RUN mkdir /app
WORKDIR /app

# Gemfileのコピー
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock

# パッケージのインストール
RUN bundle install

# ソースコードのコピー
COPY . /app

# Railsサーバーの起動
CMD ["rails", "server", "-b", "0.0.0.0"]
