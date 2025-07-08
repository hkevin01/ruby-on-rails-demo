# Docker Configuration for Rails Blog Application

This directory contains all Docker-related configuration files for running the Rails Blog Application in containers.

## Files

- `Dockerfile` - Main application container configuration
- `Dockerfile.dev` - Development-optimized container configuration
- `docker-compose.yml` - Multi-container setup for production
- `docker-compose.dev.yml` - Development environment setup
- `docker-compose.test.yml` - Testing environment setup
- `entrypoint.sh` - Container startup script
- `wait-for-it.sh` - Service dependency waiting script
- `.dockerignore` - Files to exclude from Docker build context

## Quick Start

### Development
```bash
./run.sh dev
```

### Production
```bash
./run.sh deploy:docker
```

### Testing
```bash
./run.sh test:docker
```

## Manual Docker Commands

### Build and run development environment
```bash
docker-compose -f docker/docker-compose.dev.yml up --build
```

### Run tests
```bash
docker-compose -f docker/docker-compose.test.yml up --build --abort-on-container-exit
```

### Production deployment
```bash
docker-compose -f docker/docker-compose.yml up -d --build
```

## Services

- **web** - Rails application server
- **db** - PostgreSQL database
- **redis** - Redis cache and session store
- **sidekiq** - Background job processor
- **nginx** - Reverse proxy (production only)

## Environment Variables

Create `.env` files for different environments:
- `.env.development`
- `.env.test`
- `.env.production`

See `.env.example` for required variables.
