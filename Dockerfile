# Base image
FROM ruby:3.2.2-slim

# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev curl && \
    rm -rf /var/lib/apt/lists/*

# Create app directory
WORKDIR /rails

# Install bundler
RUN gem install bundler

# Copy Gemfiles
COPY Gemfile Gemfile.lock ./

# Install gems
RUN bundle install

# Copy Rails app
COPY . .

# Precompile assets (optional for dev)
# RUN bundle exec rails assets:precompile

# Expose port
EXPOSE 3001

# Start server
CMD ["bin/rails", "server", "-b", "0.0.0.0", "-p", "3001"]
