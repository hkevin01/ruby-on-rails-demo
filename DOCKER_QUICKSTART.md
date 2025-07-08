# Quick Start with Docker

This guide will get you up and running with the Rails Blog Application using Docker in just a few minutes.

## Prerequisites

- Docker (20.10+)
- Docker Compose (1.29+)

## Quick Setup

1. **Clone and navigate to the project:**
   ```bash
   cd /home/kevin/Projects/ruby-on-rails
   ```

2. **Setup the application:**
   ```bash
   ./run.sh setup
   ```

3. **Start the development environment:**
   ```bash
   ./run.sh dev
   ```

4. **Visit the application:**
   - Main app: http://localhost:3000
   - Mailcatcher: http://localhost:1080 (for email testing)

## Common Commands

```bash
# Setup (first time only)
./run.sh setup

# Start development server
./run.sh dev

# Run tests
./run.sh test

# Open Rails console
./run.sh console

# Setup/reset database
./run.sh db:setup
./run.sh db:reset

# View logs
./run.sh logs

# Stop containers
./run.sh docker:stop

# Clean everything
./run.sh docker:clean
```

## What's Included

- **Rails 7** application server
- **PostgreSQL 14** database
- **Redis 7** for caching and background jobs
- **Sidekiq** for background job processing
- **Mailcatcher** for email testing
- **Hot reloading** for development

## Production Deployment

```bash
# Set required environment variables
export SECRET_KEY_BASE=$(openssl rand -hex 64)
export POSTGRES_PASSWORD=your_secure_password

# Deploy with Docker
./run.sh deploy:docker
```

That's it! Your Rails application is now running in Docker with all services configured and ready to go.
