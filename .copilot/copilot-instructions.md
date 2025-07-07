# GitHub Copilot Instructions for Ruby on Rails Blog Application

## Project Context
This is a Ruby on Rails 7.x blog application demonstrating modern Rails practices and popular gem integrations.

## Code Style Guidelines
- Follow Ruby community style guide (Rubocop configuration)
- Use 2 spaces for indentation
- Prefer Ruby idioms and conventions
- Use strong parameters for controller actions
- Follow RESTful routing conventions
- Use Rails helpers and built-in methods when available

## Architecture Patterns
- Follow MVC pattern strictly
- Use services for complex business logic
- Implement presenters for view logic
- Use concerns for shared functionality
- Follow Rails naming conventions

## Key Gems & Integrations
- **Authentication**: Devise for user authentication
- **Authorization**: CanCanCan for permissions
- **Frontend**: Bootstrap 5, Stimulus, Turbo
- **Rich Content**: ActionText for WYSIWYG editing
- **File Uploads**: ActiveStorage
- **Background Jobs**: Sidekiq with Redis
- **Testing**: RSpec, FactoryBot, Capybara
- **Search**: pg_search for PostgreSQL full-text search
- **Pagination**: Kaminari

## Coding Preferences
- Prefer functional over imperative style where appropriate
- Use ActiveRecord associations and scopes
- Implement proper error handling and validation
- Write descriptive method and variable names
- Include appropriate comments for complex logic
- Use Rails generators when appropriate

## Testing Approach
- Write unit tests for models
- Write request specs for controllers
- Use feature specs for user interactions
- Mock external dependencies
- Aim for high test coverage

## Security Considerations
- Always use strong parameters
- Implement proper authorization checks
- Sanitize user input
- Use CSRF protection
- Follow Rails security best practices

## Performance Guidelines
- Use database indexes appropriately
- Implement caching where beneficial
- Optimize N+1 queries
- Use background jobs for expensive operations
- Monitor and profile performance

When suggesting code, please:
1. Follow Rails conventions and best practices
2. Include appropriate error handling
3. Consider security implications
4. Write readable and maintainable code
5. Include relevant comments for complex logic
6. Suggest appropriate tests when adding new functionality
