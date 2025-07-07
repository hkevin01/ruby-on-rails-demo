# Deployment Guide

This guide covers deploying the Ruby on Rails Blog Application to various environments.

## Environments

### Development
- **Purpose**: Local development and testing
- **Database**: SQLite3 or PostgreSQL
- **URL**: http://localhost:3000
- **Setup**: Run `./scripts/setup` and `./scripts/dev`

### Staging
- **Purpose**: Pre-production testing
- **Database**: PostgreSQL
- **URL**: https://your-app-staging.herokuapp.com
- **Deploy**: `./scripts/deploy staging`

### Production
- **Purpose**: Live application
- **Database**: PostgreSQL with backups
- **URL**: https://your-app.com
- **Deploy**: `./scripts/deploy production`

## Heroku Deployment

### Prerequisites
1. Heroku CLI installed
2. Heroku account and apps created
3. PostgreSQL and Redis add-ons configured

### Initial Setup

```bash
# Login to Heroku
heroku login

# Create applications
heroku create your-app-staging
heroku create your-app-production

# Add PostgreSQL
heroku addons:create heroku-postgresql:standard-0 --app your-app-staging
heroku addons:create heroku-postgresql:standard-0 --app your-app-production

# Add Redis
heroku addons:create heroku-redis:premium-0 --app your-app-staging
heroku addons:create heroku-redis:premium-0 --app your-app-production

# Set up git remotes
git remote add heroku-staging https://git.heroku.com/your-app-staging.git
git remote add heroku https://git.heroku.com/your-app-production.git
```

### Environment Variables

```bash
# Set environment variables for staging
heroku config:set RAILS_ENV=production --app your-app-staging
heroku config:set SECRET_KEY_BASE=$(rails secret) --app your-app-staging
heroku config:set RAILS_SERVE_STATIC_FILES=true --app your-app-staging

# Set environment variables for production
heroku config:set RAILS_ENV=production --app your-app-production
heroku config:set SECRET_KEY_BASE=$(rails secret) --app your-app-production
heroku config:set RAILS_SERVE_STATIC_FILES=true --app your-app-production
```

### Deployment Process

```bash
# Deploy to staging
git push heroku-staging main
heroku run rails db:migrate --app your-app-staging
heroku restart --app your-app-staging

# Deploy to production
git push heroku main
heroku run rails db:migrate --app your-app-production
heroku restart --app your-app-production
```

## AWS Deployment

### Using AWS Elastic Beanstalk

1. **Setup Elastic Beanstalk CLI**
```bash
pip install awsebcli
eb init
```

2. **Create Environment**
```bash
eb create staging-env
eb create production-env
```

3. **Deploy**
```bash
eb deploy staging-env
eb deploy production-env
```

### Using AWS EC2 with Capistrano

1. **Add Capistrano to Gemfile**
```ruby
group :development do
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rvm'
end
```

2. **Setup Capistrano**
```bash
cap install
```

3. **Configure deployment**
Edit `config/deploy.rb` and `config/deploy/production.rb`

4. **Deploy**
```bash
cap production deploy
```

## Docker Deployment

### Dockerfile
```dockerfile
FROM ruby:3.1.0

# Install dependencies
RUN apt-get update -qq && apt-get install -y \
  build-essential \
  libpq-dev \
  nodejs \
  yarn

WORKDIR /app

# Install gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Install node packages
COPY package.json yarn.lock ./
RUN yarn install

# Copy application
COPY . .

# Precompile assets
RUN RAILS_ENV=production bundle exec rails assets:precompile

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
```

### Docker Compose
```yaml
version: '3.8'
services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - DATABASE_URL=postgresql://postgres:password@db:5432/blog_production
      - REDIS_URL=redis://redis:6379/0
    depends_on:
      - db
      - redis

  db:
    image: postgres:14
    environment:
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=blog_production
    volumes:
      - postgres_data:/var/lib/postgresql/data

  redis:
    image: redis:7

volumes:
  postgres_data:
```

## Monitoring and Maintenance

### Health Checks
Create a health check endpoint in `config/routes.rb`:
```ruby
get '/health', to: 'health#check'
```

### Logging
- Use structured logging
- Monitor error rates
- Set up log aggregation (ELK stack, Papertrail)

### Performance Monitoring
- New Relic or DataDog
- Application Performance Monitoring (APM)
- Database performance monitoring

### Backups
- Database backups (daily)
- File storage backups
- Configuration backups

### Security
- SSL certificates
- Security headers
- Regular dependency updates
- Security scanning

## Rollback Strategy

### Heroku Rollback
```bash
# Rollback to previous release
heroku rollback --app your-app-production

# Rollback to specific release
heroku rollback v123 --app your-app-production

# Database rollback (if needed)
heroku run rails db:rollback --app your-app-production
```

### Manual Rollback
1. Identify the previous working commit
2. Deploy the previous version
3. Run any necessary database rollbacks
4. Verify the application is working

## Troubleshooting

### Common Issues

1. **Database Connection Errors**
   - Check DATABASE_URL environment variable
   - Verify database is running
   - Check network connectivity

2. **Asset Compilation Errors**
   - Clear asset cache: `rails assets:clobber`
   - Check for JavaScript/CSS syntax errors
   - Verify Node.js and Yarn versions

3. **Memory Issues**
   - Monitor memory usage
   - Optimize database queries
   - Use background jobs for heavy tasks

4. **Performance Issues**
   - Check for N+1 queries
   - Add database indexes
   - Implement caching

### Debugging Production Issues
1. Check application logs
2. Monitor error tracking (Sentry, Bugsnag)
3. Use APM tools to identify bottlenecks
4. Run database performance analysis

## Best Practices

1. **Zero-downtime Deployments**
   - Use database migrations that don't lock tables
   - Deploy in blue-green fashion
   - Use feature flags for risky changes

2. **Environment Parity**
   - Keep development, staging, and production similar
   - Use same database type across environments
   - Use environment variables for configuration

3. **Security**
   - Use HTTPS everywhere
   - Keep dependencies updated
   - Regular security audits
   - Follow OWASP guidelines

4. **Monitoring**
   - Set up alerts for critical metrics
   - Monitor application performance
   - Track business metrics
   - Regular health checks
