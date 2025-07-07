source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

# Core Rails gems
gem 'rails', '~> 7.0.4'
gem 'pg', '~> 1.1'                          # PostgreSQL adapter
gem 'puma', '~> 5.0'                        # Web server
gem 'sass-rails', '>= 6'                    # SCSS support
gem 'webpacker', '~> 5.0'                   # JavaScript bundling
gem 'turbo-rails'                           # SPA-like experience
gem 'stimulus-rails'                        # JavaScript framework
gem 'jbuilder', '~> 2.7'                    # JSON APIs
gem 'bootsnap', '>= 1.4.4', require: false # Faster boot times
gem 'image_processing', '~> 1.2'            # Image variants

# Authentication & Authorization
gem 'devise'                                # Authentication
gem 'cancancan'                            # Authorization
gem 'omniauth'                             # OAuth integration
gem 'omniauth-github'                      # GitHub OAuth
gem 'omniauth-rails_csrf_protection'       # CSRF protection for OAuth

# UI & Frontend
gem 'bootstrap', '~> 5.2'                  # CSS framework
gem 'jquery-rails'                         # jQuery support
gem 'font-awesome-rails'                   # Icon fonts

# Rich Content
gem 'redcarpet'                            # Markdown processing
gem 'rouge'                                # Syntax highlighting

# Background Jobs & Caching
gem 'sidekiq'                              # Background job processing
gem 'redis', '~> 4.0'                      # Redis client
gem 'redis-rails'                          # Redis caching

# Search
gem 'pg_search'                            # PostgreSQL full-text search

# Pagination
gem 'kaminari'                             # Pagination

# File Upload & Processing
gem 'shrine'                               # File upload toolkit
gem 'mini_magick'                          # Image processing

# API & Serialization
gem 'fast_jsonapi'                         # JSON serialization

# Environment & Configuration
gem 'dotenv-rails'                         # Environment variables
gem 'config'                               # Application configuration

# Monitoring & Performance
gem 'bullet'                               # N+1 query detection
gem 'rack-mini-profiler'                   # Performance profiling

group :development, :test do
  # Debugging
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'pry-rails'                          # Better console
  gem 'pry-byebug'                         # Debugging with pry

  # Testing
  gem 'rspec-rails'                        # Testing framework
  gem 'factory_bot_rails'                  # Test data generation
  gem 'faker'                              # Fake data generation
  gem 'shoulda-matchers'                   # RSpec matchers

  # Code Quality
  gem 'rubocop'                            # Code linting
  gem 'rubocop-rails'                      # Rails-specific cops
  gem 'rubocop-rspec'                      # RSpec-specific cops
  gem 'brakeman'                           # Security scanner
end

group :development do
  # Development tools
  gem 'web-console', '>= 4.1.0'           # Console on exceptions
  gem 'listen', '~> 3.3'                  # File watching
  gem 'spring'                             # Application preloader
  gem 'spring-watcher-listen', '~> 2.0.0' # Spring file watcher
  gem 'letter_opener'                      # Email preview
  gem 'annotate'                           # Model annotations
  gem 'rails-erd'                          # Entity relationship diagrams
end

group :test do
  # Testing tools
  gem 'capybara', '>= 3.26'               # Integration testing
  gem 'selenium-webdriver'                # Browser automation
  gem 'webdrivers'                        # WebDriver binaries
  gem 'database_cleaner-active_record'    # Database cleaning
  gem 'simplecov', require: false         # Test coverage
  gem 'vcr'                                # HTTP interaction recording
  gem 'webmock'                            # HTTP request stubbing
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
