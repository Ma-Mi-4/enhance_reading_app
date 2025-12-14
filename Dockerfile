FROM ruby:3.2.2-slim

RUN apt-get update -y && apt-get install -y \
    build-essential \
    libpq-dev \
    curl \
    wget \
    gnupg \
    ca-certificates \
    unzip \
    xvfb \
    xauth \
    fonts-ipafont-gothic \
    \
    # Chromium runtime deps
    libglib2.0-0 \
    libcups2 \
    libnss3 \
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxext6 \
    libxfixes3 \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxtst6 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libdrm2 \
    libgbm1 \
    libasound2 \
    libpangocairo-1.0-0 \
    libpango-1.0-0 \
    libcairo2 \
    libxkbcommon0 \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Chrome for Testing（120 固定）
RUN wget -q https://storage.googleapis.com/chrome-for-testing-public/120.0.6099.109/linux64/chrome-linux64.zip && \
    unzip chrome-linux64.zip && \
    mv chrome-linux64 /opt/chrome && \
    ln -sf /opt/chrome/chrome /usr/bin/chromium && \
    rm chrome-linux64.zip

ENV CHROME_PATH=/usr/bin/chromium

WORKDIR /rails

RUN gem install bundler
COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .
RUN chmod +x bin/rails bin/*

EXPOSE 3000
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3000"]
