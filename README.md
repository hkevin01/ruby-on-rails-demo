# Ruby on Rails Blog Application

A modern, full-featured blog application built with Ruby on Rails showcasing popular integrations and best practices.

## Features

- 🔐 User authentication with Devise
- 📝 Rich text blog posts with ActionText
- 💬 Comment system
- 🏷️ Categories and tags
- 🔍 Search functionality
- 📱 Responsive design with Bootstrap
- 🖼️ Image uploads with ActiveStorage
- ⚡ Modern JavaScript with Stimulus and Turbo
- 🔧 Admin panel
- 📊 Background job processing

## Tech Stack

- **Backend**: Ruby on Rails 7.x
- **Database**: PostgreSQL
- **Frontend**: Bootstrap 5, Stimulus, Turbo
- **Authentication**: Devise
- **Rich Text**: ActionText
- **File Storage**: ActiveStorage
- **Background Jobs**: Sidekiq
- **Testing**: RSpec, FactoryBot, Capybara
- **Caching**: Redis

## Quick Start

### Prerequisites
- Ruby 3.0+
- Rails 7.0+
- PostgreSQL
- Redis
- Node.js and Yarn

### Installation

1. Clone the repository:
```bash
git clone <repository-url>
cd ruby-on-rails
```

2. Install dependencies:
```bash
bundle install
yarn install
```

3. Setup database:
```bash
rails db:create
rails db:migrate
rails db:seed
```

4. Start the development server:
```bash
./scripts/dev
```

Visit `http://localhost:3000` to see the application.

## Development

### Running Tests
```bash
bundle exec rspec
```

### Code Quality
```bash
bundle exec rubocop
```

### Background Jobs
```bash
bundle exec sidekiq
```

## Development Tools

### VS Code Extensions

This project includes a curated set of VS Code extensions to enhance your development experience. When you open this workspace, VS Code will automatically suggest installing the recommended extensions.

**Key extensions include:**
- Ruby language support with Solargraph
- Docker and Dev Containers for containerized development
- GitHub Copilot for AI-assisted coding
- Testing tools and coverage visualization
- Code formatting and linting tools

For a complete list and detailed information about each extension, see [VS Code Extensions Guide](docs/vscode-extensions.md).

To install all recommended extensions at once:
1. Open Command Palette (`Ctrl+Shift+P`)
2. Run "Extensions: Show Recommended Extensions"
3. Click "Install Workspace Extension Recommendations"

## Deployment

See [deployment guide](docs/deployment.md) for production deployment instructions.

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests
5. Submit a pull request

## License

This project is open source and available under the [MIT License](LICENSE).
