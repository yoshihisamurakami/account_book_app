# ベースとなるイメージを指定
FROM ruby:3.1.4

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates curl gnupg lsb-release build-essential pkg-config

# postgresの準備用
RUN install -d /etc/apt/keyrings && \
    curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc \
      | gpg --dearmor -o /etc/apt/keyrings/postgresql.gpg && \
    echo "deb [signed-by=/etc/apt/keyrings/postgresql.gpg] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" \
      > /etc/apt/sources.list.d/pgdg.list

# postgresの準備用
RUN apt-get update && apt-get install -y --no-install-recommends postgresql-client-17 libpq-dev

# ルートディレクトリを作成
RUN mkdir /myapp

# 作業ディレクトリを設定
WORKDIR /myapp

# ホスト側のGemfileとGemfile.lockをコンテナにコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# GemfileをもとにGemをインストール
RUN bundle config set force_ruby_platform true
RUN gem install bundler
RUN bundle install

# ホスト側のアプリケーションコードをコンテナにコピー
COPY . /myapp

# ポート番号の指定
EXPOSE 3000

# Railsサーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
