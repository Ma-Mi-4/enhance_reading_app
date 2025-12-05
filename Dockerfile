FROM ruby:3.2.2-slim

# 必要パッケージ & Chromium & ChromeDriver
RUN apt-get update -y && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    wget \
    gnupg \
    chromium \
    chromium-driver \
    xvfb \
    fonts-ipafont-gothic \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /rails

# bundler
RUN gem install bundler

# Gemfile をコピー
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Rails アプリコピー
COPY . .

EXPOSE 3000

CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
