#!/bin/bash

# Rails Blog Application - Main Runner Script
# This script provides a unified interface for all project commands

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Project information
PROJECT_NAME="Rails Blog Application"
VERSION="1.0.0"

# Function to display colored output
print_color() {
    printf "${!1}%s${NC}\n" "$2"
}

# Function to display the header
show_header() {
    echo ""
    print_color "BLUE" "╔══════════════════════════════════════════════════════════════╗"
    print_color "BLUE" "║                    ${PROJECT_NAME}                     ║"
    print_color "BLUE" "║                        Version ${VERSION}                        ║"
    print_color "BLUE" "╚══════════════════════════════════════════════════════════════╝"
    echo ""
}

# Function to show help
show_help() {
    show_header
    print_color "CYAN" "Available Commands:"
    echo ""
    print_color "GREEN" "🚀 Development Commands:"
    echo "  setup          Initial project setup and dependency installation"
    echo "  dev            Start development server with all services"
    echo "  console        Open Rails console (dev/test/staging/production)"
    echo "  db:setup       Setup database (create, migrate, seed)"
    echo "  db:reset       Reset database (drop, create, migrate, seed)"
    echo "  db:migrate     Run pending database migrations"
    echo "  db:seed        Seed database with sample data"
    echo ""
    print_color "YELLOW" "🧪 Testing Commands:"
    echo "  test           Run complete test suite with coverage"
    echo "  test:unit      Run unit tests only"
    echo "  test:integration  Run integration tests only"
    echo "  test:system    Run system/feature tests only"
    echo "  test:watch     Run tests in watch mode"
    echo ""
    print_color "PURPLE" "🔍 Code Quality Commands:"
    echo "  lint           Run all code quality checks"
    echo "  lint:ruby      Run RuboCop for Ruby code"
    echo "  lint:js        Run ESLint for JavaScript"
    echo "  lint:css       Run Stylelint for CSS/SCSS"
    echo "  format         Auto-format code (RuboCop, Prettier)"
    echo "  security       Run security scans (Brakeman, Bundle Audit)"
    echo ""
    print_color "RED" "🚀 Deployment Commands:"
    echo "  deploy:staging Deploy to staging environment"
    echo "  deploy:production  Deploy to production environment"
    echo "  deploy:docker  Deploy with Docker to production"
    echo "  health         Check application health"
    echo ""
    print_color "CYAN" "📦 Utility Commands:"
    echo "  install        Install/update dependencies"
    echo "  clean          Clean temporary files and caches"
    echo "  logs           Show application logs"
    echo "  logs:docker    Show Docker container logs"
    echo "  stats          Show project statistics"
    echo "  doctor         Run comprehensive project health check"
    echo "  docker:stop    Stop all Docker containers"
    echo "  docker:clean   Clean Docker containers and volumes"
    echo ""
    print_color "BLUE" "ℹ️  Information Commands:"
    echo "  help           Show this help message"
    echo "  version        Show version information"
    echo "  status         Show project status"
    echo ""
    echo "Usage: ./run.sh [command] [options]"
    echo "       ./run.sh (defaults to 'dev' - starts development server)"
    echo ""
    echo "Examples:"
    echo "  ./run.sh              # Start development server (default)"
    echo "  ./run.sh dev          # Start development server"
    echo "  ./run.sh console      # Open Rails console"
    echo "  ./run.sh test         # Run test suite"
    echo ""
}

# Function to check if we're in the right directory
check_project_root() {
    # For the 'setup' command, we don't need to check for Gemfile/config.ru
    # as the project might not have been initialized yet.
    if [ "$1" == "setup" ]; then
        return
    fi

    if [ ! -f "src/Gemfile" ] || [ ! -f "src/config.ru" ]; then
        print_color "RED" "❌ Error: This script must be run from the project root directory, and the Rails application must be initialized in 'src'."
        print_color "YELLOW" "Current directory: $(pwd)"
        print_color "YELLOW" "Please run './run.sh setup' first."
        exit 1
    fi
}

# Function to execute commands within the Rails app directory
run_in_app_dir() {
    (cd src && "$@")
}

# --- Docker Helper Functions ---

# Function to check if Docker is running
check_docker() {
    if ! docker info > /dev/null 2>&1; then
        print_color "RED" "❌ Error: Docker is not running. Please start Docker and try again."
        exit 1
    fi
}

# Function to run Docker Compose commands for development
docker_compose_dev() {
    check_docker
    docker-compose -f docker/docker-compose.dev.yml "$@"
}

# Function to run Docker Compose commands for testing
docker_compose_test() {
    check_docker
    docker-compose -f docker/docker-compose.test.yml "$@"
}

# Function to run Docker Compose commands for production
docker_compose_prod() {
    check_docker
    docker-compose -f docker/docker-compose.yml "$@"
}


# --- Main Command Functions ---

# Initial Project Setup
cmd_setup() {
    show_header
    print_color "GREEN" "🚀 Starting project setup..."

    # Create src directory if it doesn't exist
    if [ ! -d "src" ]; then
        print_color "YELLOW" "Creating 'src' directory..."
        mkdir -p src
    fi

    # Check if Rails project already exists
    if [ -f "src/Gemfile" ]; then
        print_color "YELLOW" "Rails project already exists in 'src'. Skipping new application setup."
    else
        print_color "CYAN" "Generating new Rails application in 'src' directory..."
        # Use a dedicated setup container to run `rails new`
        docker-compose -f docker/docker-compose.setup.yml run --rm setup rails new . --force --database=postgresql
        print_color "GREEN" "✅ New Rails application created."
    fi

    print_color "CYAN" "Adjusting file permissions..."
    # When Docker creates files, they are owned by root. Change ownership to the current user.
    # This requires sudo privileges.
    if command -v sudo >/dev/null 2>&1; then
        sudo chown -R "$(id -u):$(id -g)" src
    else
        # If sudo is not available, we can't change ownership.
        # The user might need to do this manually.
        print_color "YELLOW" "⚠️ Warning: 'sudo' command not found. Could not change file ownership of 'src' directory."
        print_color "YELLOW" "You may need to manually run 'chown -R \$(id -u):\$(id -g) src' to avoid permission issues."
    fi


    print_color "CYAN" "Starting services to complete setup..."
    # Start all services, including the database
    docker_compose_dev up --build -d

    print_color "CYAN" "Installing dependencies..."
    docker_compose_dev exec web bundle install
    docker_compose_dev exec web yarn install

    print_color "CYAN" "Creating databases..."
    docker_compose_dev exec web rails db:create

    print_color "GREEN" "✅ Project setup complete!"
    print_color "YELLOW" "Run './run.sh dev' to see the application."
    print_color "YELLOW" "You can stop all services with './run.sh docker:stop'."
}

# Start Development Server
cmd_dev() {
    check_project_root "$1"
    show_header
    print_color "GREEN" "🚀 Starting development environment..."
    docker_compose_dev up --build -d
    print_color "YELLOW" "🔗 Application running at http://localhost:3000"
    print_color "YELLOW" "Use './run.sh logs' to view logs."
}

# Open Rails Console
cmd_console() {
    check_project_root "$1"
    local env=${2:-development}
    print_color "GREEN" "🚀 Opening Rails console in ${env} environment..."
    case "$env" in
        development)
            docker_compose_dev run --rm web rails console
            ;;
        test)
            docker_compose_test run --rm web rails console
            ;;
        production)
            docker_compose_prod run --rm web rails console
            ;;
        *)
            print_color "RED" "❌ Invalid environment: $env. Use 'development', 'test', or 'production'."
            exit 1
            ;;
    esac
}

# Database Commands
cmd_db() {
    check_project_root "$1"
    local action=${2:-setup}
    print_color "GREEN" "🚀 Running database command: db:${action}..."
    case "$action" in
        setup|reset|migrate|seed)
            docker_compose_dev run --rm web rails db:${action}
            ;;
        *)
            print_color "RED" "❌ Invalid db command: $action. Use 'setup', 'reset', 'migrate', or 'seed'."
            exit 1
            ;;
    esac
}

# Run Tests
cmd_test() {
    check_project_root "$1"
    local scope=${2:-all}
    print_color "YELLOW" "🧪 Running tests (${scope})..."
    case "$scope" in
        all)
            docker_compose_test run --rm web rspec
            ;;
        unit|integration|system)
            docker_compose_test run --rm web rspec spec/${scope}
            ;;
        watch)
            docker_compose_test run --rm web guard
            ;;
        *)
            print_color "RED" "❌ Invalid test scope: $scope. Use 'all', 'unit', 'integration', 'system', or 'watch'."
            exit 1
            ;;
    esac
}

# Code Quality Commands
cmd_lint() {
    check_project_root "$1"
    local tool=${2:-all}
    print_color "PURPLE" "🔍 Running linter (${tool})..."
    case "$tool" in
        all)
            docker_compose_dev run --rm web bundle exec rubocop && \
            docker_compose_dev run --rm node npm run lint:js && \
            docker_compose_dev run --rm node npm run lint:css
            ;;
        ruby)
            docker_compose_dev run --rm web bundle exec rubocop
            ;;
        js|css)
            docker_compose_dev run --rm node npm run lint:${tool}
            ;;
        *)
            print_color "RED" "❌ Invalid lint tool: $tool. Use 'all', 'ruby', 'js', or 'css'."
            exit 1
            ;;
    esac
}

# Format Code
cmd_format() {
    check_project_root "$1"
    print_color "PURPLE" "🎨 Formatting code..."
    docker_compose_dev run --rm web bundle exec rubocop -A
    docker_compose_dev run --rm node npm run format
}

# Security Scan
cmd_security() {
    check_project_root "$1"
    print_color "RED" "🛡️  Running security scans..."
    docker_compose_dev run --rm web bundle exec brakeman
    docker_compose_dev run --rm web bundle audit check --update
}


# Deployment Commands
cmd_deploy() {
    check_project_root "$1"
    local env=${2:-staging}
    print_color "RED" "🚀 Deploying to ${env}..."
    case "$env" in
        staging|production)
            ./scripts/deploy ${env}
            ;;
        docker)
            print_color "CYAN" "Building and pushing Docker production image..."
            docker_compose_prod build
            # Add your docker push command here, e.g., docker-compose -f docker/docker-compose.yml push
            print_color "GREEN" "✅ Docker image built. Ready for deployment."
            ;;
        *)
            print_color "RED" "❌ Invalid deployment target: $env. Use 'staging', 'production', or 'docker'."
            exit 1
            ;;
    esac
}

# Utility Commands
cmd_logs() {
    local service=${2:-all}
    print_color "CYAN" "📋 Fetching logs for ${service}..."
    if [ "$service" == "all" ]; then
        docker_compose_dev logs -f
    else
        docker_compose_dev logs -f ${service}
    fi
}

cmd_clean() {
    print_color "YELLOW" "🧹 Cleaning project..."
    # Stop all containers first
    cmd_docker_stop
    # Clean Rails temp files
    if [ -d "src/tmp" ]; then
        run_in_app_dir rm -rf tmp/cache/* tmp/pids/* tmp/sockets/*
    fi
    # Clean Docker artifacts
    cmd_docker_clean
    print_color "GREEN" "✅ Clean complete."
}

cmd_docker_stop() {
    print_color "YELLOW" "🛑 Stopping all Docker containers..."
    docker_compose_dev down --remove-orphans
    docker_compose_test down --remove-orphans
    docker_compose_prod down --remove-orphans
    print_color "GREEN" "✅ Docker containers stopped."
}

cmd_docker_clean() {
    print_color "YELLOW" "🧹 Cleaning Docker containers, volumes, and networks..."
    # This will remove all stopped containers, all networks not used by at least one container,
    # all dangling images, and all dangling build cache.
    docker system prune -f
    # To remove all unused volumes, uncomment the line below
    # docker volume prune -f
    print_color "GREEN" "✅ Docker clean complete."
}


# --- Command Dispatcher ---

# Case statement for commands
COMMAND=$1

# If no command provided, default to 'dev'
if [ -z "$COMMAND" ]; then
    COMMAND="dev"
    print_color "CYAN" "ℹ️  No command provided, defaulting to 'dev' (development server)"
    echo ""
else
    shift # remove command from argument list only if one was provided
fi

# Before running any command, check project root, except for help, version, etc.
case "$COMMAND" in
    help|version)
        # No root check needed
        ;;
    *)
        check_project_root "$COMMAND"
        ;;
esac


case "$COMMAND" in
    setup)
        cmd_setup "$@"
        ;;
    dev)
        cmd_dev "$@"
        ;;
    console)
        cmd_console "$@"
        ;;
    db:setup|db:reset|db:migrate|db:seed)
        cmd_db "${COMMAND#db:}" "$@"
        ;;
    test)
        cmd_test "all" "$@"
        ;;
    test:unit|test:integration|test:system|test:watch)
        cmd_test "${COMMAND#test:}" "$@"
        ;;
    lint)
        cmd_lint "all" "$@"
        ;;
    lint:ruby|lint:js|lint:css)
        cmd_lint "${COMMAND#lint:}" "$@"
        ;;
    format)
        cmd_format "$@"
        ;;
    security)
        cmd_security "$@"
        ;;
    deploy:staging|deploy:production|deploy:docker)
        cmd_deploy "${COMMAND#deploy:}" "$@"
        ;;
    logs)
        cmd_logs "$@"
        ;;
    clean)
        cmd_clean "$@"
        ;;
    docker:stop)
        cmd_docker_stop "$@"
        ;;
    docker:clean)
        cmd_docker_clean "$@"
        ;;
    status)
        show_header
        print_color "GREEN" "Project Status:"
        docker-compose -f docker/docker-compose.dev.yml ps
        ;;
    version)
        show_header
        ;;
    help)
        show_help
        ;;
    *)
        print_color "RED" "❌ Unknown command: $COMMAND"
        show_help
        exit 1
        ;;
esac

exit 0
