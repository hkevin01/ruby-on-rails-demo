#!/bin/bash
set -e

# Wait for database
if [ "$DATABASE_URL" ]; then
  echo "Waiting for database..."
  /usr/bin/wait-for-it.sh db:5432 --timeout=30 --strict -- echo "Database is ready"
fi

# Wait for Redis
if [ "$REDIS_URL" ]; then
  echo "Waiting for Redis..."
  /usr/bin/wait-for-it.sh redis:6379 --timeout=30 --strict -- echo "Redis is ready"
fi

# Remove any existing server.pid
rm -f tmp/pids/server.pid

# Setup database if needed
if [ "$RAILS_ENV" = "development" ] || [ "$RAILS_ENV" = "test" ]; then
  echo "Setting up database..."
  bundle exec rails db:prepare
fi

# Run database migrations
if [ "$RAILS_ENV" = "production" ]; then
  echo "Running database migrations..."
  bundle exec rails db:migrate
fi

# Precompile assets in production
if [ "$RAILS_ENV" = "production" ]; then
  echo "Precompiling assets..."
  bundle exec rails assets:precompile
fi

# Start the main process
exec "$@"
