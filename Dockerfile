# ベースとなるイメージを指定
FROM ruby:3.1.3

# 必要なパッケージをインストール
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs

# ルートディレクトリを作成
RUN mkdir /myapp

# 作業ディレクトリを設定
WORKDIR /myapp

# ホスト側のGemfileとGemfile.lockをコンテナにコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# GemfileをもとにGemをインストール
RUN gem install bundler
RUN bundle install

# ホスト側のアプリケーションコードをコンテナにコピー
COPY . /myapp

# ポート番号の指定
EXPOSE 3000

# Railsサーバーを起動
CMD ["rails", "server", "-b", "0.0.0.0"]
