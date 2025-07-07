# Development Guide

This guide helps you get started with developing the Ruby on Rails Blog Application.

## Getting Started

### Prerequisites
- Ruby 3.1.0 or higher
- Rails 7.0 or higher
- PostgreSQL 12 or higher
- Redis 6 or higher
- Node.js 16 or higher
- Yarn package manager

### Quick Setup
1. Clone the repository and navigate to the project directory
2. Run the setup script: `./scripts/setup`
3. Start the development server: `./scripts/dev`
4. Visit http://localhost:3000

## Development Workflow

### Daily Development
1. Pull latest changes: `git pull origin main`
2. Install any new dependencies: `bundle install && yarn install`
3. Run migrations: `rails db:migrate`
4. Start development server: `./scripts/dev`

### Making Changes
1. Create a feature branch: `git checkout -b feature/my-feature`
2. Make your changes
3. Run tests: `./scripts/test`
4. Run linting: `./scripts/lint`
5. Commit changes: `git commit -m "Add my feature"`
6. Push and create PR: `git push origin feature/my-feature`

## Project Structure

```
├── app/                    # Application code
│   ├── controllers/        # Controllers
│   ├── models/            # Models
│   ├── views/             # Views
│   ├── helpers/           # View helpers
│   ├── mailers/           # Email templates
│   ├── jobs/              # Background jobs
│   └── assets/            # Stylesheets, images
├── config/                # Configuration files
├── db/                    # Database files
│   ├── migrate/           # Database migrations
│   └── seeds.rb           # Sample data
├── spec/                  # Test files
├── scripts/               # Development scripts
├── docs/                  # Documentation
└── src/                   # Source layouts and components
```

## Testing

### Running Tests
- All tests: `./scripts/test`
- Specific file: `bundle exec rspec spec/models/user_spec.rb`
- Specific test: `bundle exec rspec spec/models/user_spec.rb:10`

### Test Types
- **Model specs**: Test model logic and validations
- **Controller specs**: Test controller actions and responses
- **Feature specs**: Test user interactions end-to-end
- **Request specs**: Test API endpoints

### Writing Tests
- Follow TDD/BDD practices
- Use FactoryBot for test data
- Mock external dependencies
- Aim for high test coverage (>90%)

## Code Quality

### Linting and Formatting
- Ruby: RuboCop (`bundle exec rubocop`)
- Security: Brakeman (`bundle exec brakeman`)
- Run all checks: `./scripts/lint`

### Code Style
- Follow Ruby Style Guide
- Use 2 spaces for indentation
- Maximum line length: 80 characters
- Use descriptive variable and method names

## Database

### Migrations
- Create migration: `rails generate migration AddFieldToModel field:type`
- Run migrations: `rails db:migrate`
- Rollback: `rails db:rollback`
- Reset database: `rails db:drop db:create db:migrate db:seed`

### Seeds
- Add sample data in `db/seeds.rb`
- Run seeds: `rails db:seed`

## Background Jobs

### Sidekiq
- Start Sidekiq: `bundle exec sidekiq`
- Web UI: http://localhost:4567/sidekiq
- Create job: `rails generate job MyJob`

## Debugging

### Tools
- **Pry**: Add `binding.pry` to set breakpoints
- **Rails Console**: `./scripts/console`
- **Logs**: Check `log/development.log`

### Common Issues
1. **Port already in use**: Kill process with `lsof -ti:3000 | xargs kill -9`
2. **Database issues**: Try `rails db:reset`
3. **Asset issues**: Clear cache with `rails assets:clobber`

## Performance

### Monitoring
- Use Bullet gem to detect N+1 queries
- Profile with rack-mini-profiler
- Monitor logs for slow queries

### Optimization
- Add database indexes for frequently queried columns
- Use includes() to avoid N+1 queries
- Implement caching for expensive operations
- Use background jobs for long-running tasks

## Deployment

### Environments
- **Development**: Local development
- **Test**: Automated testing
- **Staging**: Pre-production testing
- **Production**: Live application

### Deploy
- Staging: `./scripts/deploy staging`
- Production: `./scripts/deploy production`

## Useful Commands

### Rails
```bash
rails console                 # Start Rails console
rails server                  # Start development server
rails generate model User     # Generate model
rails db:migrate             # Run migrations
rails routes                 # Show all routes
```

### Bundle
```bash
bundle install               # Install gems
bundle update               # Update gems
bundle exec rspec           # Run tests
bundle exec rubocop         # Run linting
```

### Git
```bash
git status                  # Check status
git add .                   # Stage changes
git commit -m "message"     # Commit changes
git push origin branch      # Push to remote
```

## Getting Help

1. Check this documentation
2. Review code comments
3. Ask in team chat
4. Check Rails guides: https://guides.rubyonrails.org/
5. Search Stack Overflow

## Contributing

1. Follow the coding standards
2. Write tests for new features
3. Update documentation
4. Submit pull requests for review
