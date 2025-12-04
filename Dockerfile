FROM ruby:3.2.2-slim

ENV CHROME_VERSION=143.0.7499.40
ENV CHROMEDRIVER_VERSION=143.0.7499.40

# 必須ライブラリ
RUN apt-get update -qq && \
    apt-get install -y \
      wget \
      gnupg \
      unzip \
      curl \
      build-essential \
      libpq-dev \
      ca-certificates \
      libnss3 \
      libgconf-2-4 \
      libxss1 \
      libasound2 \
      fonts-liberation \
      xdg-utils \
      libu2f-udev \
      libvulkan1 \
      --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Google Chrome（stable）インストール
RUN wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - && \
    echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" \
        > /etc/apt/sources.list.d/google-chrome.list && \
    apt-get update -qq && \
    apt-get install -y google-chrome-stable && \
    rm -rf /var/lib/apt/lists/*

# ChromeDriver 143（Chromeと同じバージョン）
RUN wget -q -O /tmp/chromedriver.zip \
      "https://storage.googleapis.com/chrome-for-testing-public/${CHROMEDRIVER_VERSION}/linux64/chromedriver-linux64.zip" && \
    unzip /tmp/chromedriver.zip -d /tmp/ && \
    mv /tmp/chromedriver-linux64/chromedriver /usr/local/bin/chromedriver && \
    chmod +x /usr/local/bin/chromedriver && \
    rm -rf /tmp/*

# Rails
WORKDIR /rails

RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
RUN chmod +x /rails/bin/*

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
