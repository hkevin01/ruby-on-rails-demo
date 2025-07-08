# Production Dockerfile for Rails Blog Application
FROM ruby:3.1.0-alpine AS base

# Install system dependencies
RUN apk add --no-cache \
  build-base \
  postgresql-dev \
  tzdata \
  nodejs \
  yarn \
  git \
  curl \
  bash \
  imagemagick \
  && rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /app

# Create app user
RUN addgroup -g 1000 -S app && \
  adduser -u 1000 -S app -G app

# Copy Gemfile and package.json first for better caching
COPY Gemfile Gemfile.lock package.json yarn.lock ./

# Install Ruby gems
RUN bundle config --global frozen 1 && \
  bundle config set --local deployment 'true' && \
  bundle config set --local without 'development test' && \
  bundle install --jobs $(nproc) --retry 3

# Install Node.js packages
RUN yarn install --frozen-lockfile --production && \
  yarn cache clean

# Copy application code
COPY . .

# Set ownership
RUN chown -R app:app /app

# Switch to app user
USER app

# Precompile assets
ENV RAILS_ENV=production
ENV NODE_ENV=production
RUN bundle exec rails assets:precompile

# Expose port
EXPOSE 3000

# Add entrypoint script
COPY --chown=app:app docker/entrypoint.sh /usr/bin/entrypoint.sh
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["/usr/bin/entrypoint.sh"]
CMD ["rails", "server", "-b", "0.0.0.0"]
