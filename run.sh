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
    echo "  health         Check application health"
    echo ""
    print_color "CYAN" "📦 Utility Commands:"
    echo "  install        Install/update dependencies"
    echo "  clean          Clean temporary files and caches"
    echo "  logs           Show application logs"
    echo "  stats          Show project statistics"
    echo "  doctor         Run comprehensive project health check"
    echo ""
    print_color "BLUE" "ℹ️  Information Commands:"
    echo "  help           Show this help message"
    echo "  version        Show version information"
    echo "  status         Show project status"
    echo ""
    echo "Usage: ./run.sh <command> [options]"
    echo "Example: ./run.sh dev"
    echo "Example: ./run.sh console production"
    echo ""
}

# Function to check if we're in the right directory
check_project_root() {
    if [ ! -f "Gemfile" ] || [ ! -f "config.ru" ]; then
        print_color "RED" "❌ Error: This script must be run from the Rails application root directory."
        print_color "YELLOW" "Current directory: $(pwd)"
        exit 1
    fi
}

# Function to check dependencies
check_dependencies() {
    local missing_deps=()
    
    command -v ruby >/dev/null 2>&1 || missing_deps+=("ruby")
    command -v bundle >/dev/null 2>&1 || missing_deps+=("bundler")
    command -v yarn >/dev/null 2>&1 || missing_deps+=("yarn")
    command -v git >/dev/null 2>&1 || missing_deps+=("git")
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_color "RED" "❌ Missing dependencies: ${missing_deps[*]}"
        print_color "YELLOW" "Please install the missing dependencies and try again."
        exit 1
    fi
}

# Function to run scripts with proper error handling
run_script() {
    local script_path="./scripts/$1"
    shift
    
    if [ -f "$script_path" ] && [ -x "$script_path" ]; then
        print_color "BLUE" "🔧 Running: $script_path $*"
        "$script_path" "$@"
    else
        print_color "RED" "❌ Script not found or not executable: $script_path"
        exit 1
    fi
}

# Main command handler
main() {
    case "${1:-help}" in
        # Help and information
        help|--help|-h)
            show_help
            ;;
        
        version|--version|-v)
            show_header
            print_color "GREEN" "Ruby Version: $(ruby -v)"
            print_color "GREEN" "Bundler Version: $(bundle -v)"
            print_color "GREEN" "Yarn Version: $(yarn -v)"
            if [ -f "Gemfile.lock" ]; then
                rails_version=$(grep -A 1 "rails (" Gemfile.lock | tail -1 | tr -d ' ' | cut -d'(' -f2 | cut -d')' -f1)
                print_color "GREEN" "Rails Version: $rails_version"
            fi
            ;;
        
        status)
            show_header
            print_color "CYAN" "📊 Project Status:"
            echo ""
            
            # Git status
            if git rev-parse --git-dir > /dev/null 2>&1; then
                print_color "GREEN" "Git Repository: ✅ Initialized"
                current_branch=$(git branch --show-current)
                print_color "BLUE" "Current Branch: $current_branch"
                
                if [[ -n $(git status --porcelain) ]]; then
                    print_color "YELLOW" "Working Directory: ⚠️  Has uncommitted changes"
                else
                    print_color "GREEN" "Working Directory: ✅ Clean"
                fi
            else
                print_color "RED" "Git Repository: ❌ Not initialized"
            fi
            
            # Dependencies
            if [ -f "Gemfile.lock" ]; then
                print_color "GREEN" "Ruby Dependencies: ✅ Installed"
            else
                print_color "YELLOW" "Ruby Dependencies: ⚠️  Not installed"
            fi
            
            if [ -f "yarn.lock" ] || [ -f "package-lock.json" ]; then
                print_color "GREEN" "JavaScript Dependencies: ✅ Installed"
            else
                print_color "YELLOW" "JavaScript Dependencies: ⚠️  Not installed"
            fi
            
            # Database
            if bundle exec rails runner "ActiveRecord::Base.connection" >/dev/null 2>&1; then
                print_color "GREEN" "Database: ✅ Connected"
            else
                print_color "YELLOW" "Database: ⚠️  Not accessible"
            fi
            ;;
        
        # Development commands
        setup)
            run_script "setup"
            ;;
        
        dev|start|server)
            run_script "dev"
            ;;
        
        console)
            run_script "console" "${2:-development}"
            ;;
        
        # Database commands
        db:setup)
            print_color "BLUE" "🗄️  Setting up database..."
            bundle exec rails db:create db:migrate db:seed
            ;;
        
        db:reset)
            print_color "YELLOW" "⚠️  Resetting database (this will destroy all data)..."
            read -p "Are you sure? (y/N): " -n 1 -r
            echo
            if [[ $REPLY =~ ^[Yy]$ ]]; then
                bundle exec rails db:drop db:create db:migrate db:seed
            else
                print_color "BLUE" "Operation cancelled."
            fi
            ;;
        
        db:migrate)
            bundle exec rails db:migrate
            ;;
        
        db:seed)
            bundle exec rails db:seed
            ;;
        
        # Testing commands
        test)
            run_script "test"
            ;;
        
        test:unit)
            print_color "BLUE" "🧪 Running unit tests..."
            bundle exec rspec spec/models spec/lib --format documentation
            ;;
        
        test:integration)
            print_color "BLUE" "🧪 Running integration tests..."
            bundle exec rspec spec/requests spec/controllers --format documentation
            ;;
        
        test:system)
            print_color "BLUE" "🧪 Running system tests..."
            bundle exec rspec spec/features spec/system --format documentation
            ;;
        
        test:watch)
            print_color "BLUE" "🧪 Running tests in watch mode..."
            bundle exec guard
            ;;
        
        # Code quality commands
        lint)
            run_script "lint"
            ;;
        
        lint:ruby)
            print_color "BLUE" "🔍 Running RuboCop..."
            bundle exec rubocop
            ;;
        
        lint:js)
            print_color "BLUE" "🔍 Running ESLint..."
            yarn run lint:js
            ;;
        
        lint:css)
            print_color "BLUE" "🔍 Running Stylelint..."
            yarn run lint:css
            ;;
        
        format)
            print_color "BLUE" "✨ Formatting code..."
            bundle exec rubocop -a
            yarn run format
            ;;
        
        security)
            print_color "BLUE" "🔒 Running security scans..."
            bundle exec brakeman --exit-on-warn
            bundle exec bundle-audit check --update
            ;;
        
        # Deployment commands
        deploy:staging)
            run_script "deploy" "staging"
            ;;
        
        deploy:production)
            run_script "deploy" "production"
            ;;
        
        health)
            print_color "BLUE" "🏥 Checking application health..."
            if command -v curl >/dev/null 2>&1; then
                if curl -f -s "http://localhost:3000/health" >/dev/null; then
                    print_color "GREEN" "✅ Application is healthy"
                else
                    print_color "RED" "❌ Application health check failed"
                    exit 1
                fi
            else
                print_color "YELLOW" "⚠️  curl not available, skipping health check"
            fi
            ;;
        
        # Utility commands
        install)
            print_color "BLUE" "📦 Installing dependencies..."
            bundle install
            yarn install
            ;;
        
        clean)
            print_color "BLUE" "🧹 Cleaning temporary files..."
            rm -rf tmp/cache/*
            rm -rf log/*.log
            rm -rf coverage/
            rm -rf node_modules/.cache/
            bundle exec rails tmp:clear
            print_color "GREEN" "✅ Cleanup completed"
            ;;
        
        logs)
            print_color "BLUE" "📄 Showing recent logs..."
            if [ -f "log/development.log" ]; then
                tail -f log/development.log
            else
                print_color "YELLOW" "No development log found"
            fi
            ;;
        
        stats)
            print_color "BLUE" "📊 Project Statistics:"
            echo ""
            if command -v cloc >/dev/null 2>&1; then
                cloc --exclude-dir=node_modules,vendor,coverage,tmp,log .
            else
                print_color "YELLOW" "Install 'cloc' for detailed code statistics"
                find . -name "*.rb" -not -path "./vendor/*" -not -path "./node_modules/*" | wc -l | xargs echo "Ruby files:"
                find . -name "*.js" -not -path "./vendor/*" -not -path "./node_modules/*" | wc -l | xargs echo "JavaScript files:"
                find . -name "*.scss" -not -path "./vendor/*" -not -path "./node_modules/*" | wc -l | xargs echo "SCSS files:"
            fi
            ;;
        
        doctor)
            print_color "BLUE" "🏥 Running comprehensive health check..."
            echo ""
            
            # Check dependencies
            check_dependencies
            print_color "GREEN" "✅ Dependencies check passed"
            
            # Check database connection
            if bundle exec rails runner "ActiveRecord::Base.connection" >/dev/null 2>&1; then
                print_color "GREEN" "✅ Database connection successful"
            else
                print_color "RED" "❌ Database connection failed"
            fi
            
            # Check for security issues
            if bundle exec brakeman -q; then
                print_color "GREEN" "✅ Security scan passed"
            else
                print_color "YELLOW" "⚠️  Security issues detected"
            fi
            
            # Check code style
            if bundle exec rubocop; then
                print_color "GREEN" "✅ Code style check passed"
            else
                print_color "YELLOW" "⚠️  Code style issues detected"
            fi
            
            print_color "BLUE" "🏥 Health check completed"
            ;;
        
        *)
            print_color "RED" "❌ Unknown command: $1"
            echo ""
            print_color "YELLOW" "Run './run.sh help' to see available commands"
            exit 1
            ;;
    esac
}

# Check if we're in the right directory (unless showing help or version)
if [[ "${1:-help}" != "help" && "${1:-help}" != "--help" && "${1:-help}" != "-h" && "${1:-help}" != "version" && "${1:-help}" != "--version" && "${1:-help}" != "-v" ]]; then
    check_project_root
fi

# Run the main function with all arguments
main "$@"
