# VS Code Extensions for Ruby on Rails Development

This document provides a comprehensive guide to all the VS Code extensions recommended for this Ruby on Rails blog project. These extensions enhance the development experience with better syntax highlighting, debugging, testing, and productivity features.

## Installation

All extensions are automatically suggested when you open this workspace. You can install them by:

1. Opening VS Code in this workspace
2. Go to the Extensions panel (Ctrl+Shift+X)
3. Look for the "Workspace Recommendations" section
4. Click "Install All" or install individual extensions

Alternatively, you can install all at once using the command palette:
- Press `Ctrl+Shift+P`
- Type "Extensions: Show Recommended Extensions"
- Click "Install Workspace Extension Recommendations"

## Ruby & Rails Specific Extensions

### 1. Ruby (`rebornix.ruby`)
**Essential for Ruby development**
- Syntax highlighting for Ruby files
- Code folding and indentation
- Basic Ruby language support
- Snippet support for common Ruby patterns

### 2. Solargraph (`castwide.solargraph`)
**Ruby language server for intelligent code completion**
- IntelliSense and autocompletion for Ruby
- Go to definition and find references
- Method signatures and documentation on hover
- Error detection and diagnostics
- Requires `solargraph` gem (included in our Gemfile)

### 3. Ruby LSP (`shopify.ruby-lsp`)
**Modern Ruby language server (alternative to Solargraph)**
- Fast and lightweight Ruby language support
- Built by Shopify for performance
- Provides IntelliSense, go-to-definition, and formatting
- Better performance than Solargraph for large projects
- Note: Use either Solargraph OR Ruby LSP, not both

### 4. Endwise (`kaiwood.endwise`)
**Automatic Ruby block completion**
- Automatically adds `end` statements for Ruby blocks
- Works with `if`, `def`, `class`, `module`, etc.
- Prevents syntax errors from missing `end` statements

### 5. ERB Beautify (`aliariff.vscode-erb-beautify`)
**Formatting for ERB templates**
- Format and beautify `.erb` and `.html.erb` files
- Proper indentation for HTML and Ruby code
- Essential for Rails view templates

### 6. Ruby Debugger (`koichisasada.vscode-rdbg`)
**Ruby debugging support**
- Visual debugging for Ruby applications
- Set breakpoints and inspect variables
- Step through Ruby code execution
- Works with the `debug` gem

## Frontend & Styling Extensions

### 7. Tailwind CSS IntelliSense (`bradlc.vscode-tailwindcss`)
**Enhanced Tailwind CSS development**
- Intelligent autocompletion for Tailwind classes
- CSS class name validation
- Hover previews with CSS values
- Color decorators for color utilities

### 8. Prettier - Code Formatter (`esbenp.prettier-vscode`)
**Code formatting for various file types**
- Automatic formatting for JavaScript, JSON, HTML, CSS
- Consistent code style across the project
- Integrates with our project's Prettier configuration

### 9. ESLint (`dbaeumer.vscode-eslint`)
**JavaScript/TypeScript linting**
- Real-time linting for JavaScript and TypeScript files
- Helps maintain code quality and consistency
- Integrates with our project's ESLint configuration

## Language Support Extensions

### 10. JSON (`ms-vscode.vscode-json`)
**Enhanced JSON support**
- JSON schema validation
- IntelliSense for JSON files
- Error detection and formatting
- Essential for configuration files

### 11. YAML (`redhat.vscode-yaml`)
**YAML language support**
- Syntax highlighting for YAML files
- Schema validation
- Error detection
- Important for Docker Compose, GitHub Actions, and Rails config files

## Docker & DevOps Extensions

### 12. Docker (`ms-azuretools.vscode-docker`)
**Docker integration and management**
- Dockerfile syntax highlighting and IntelliSense
- Build, run, and manage Docker containers
- Docker Compose support
- Container inspection and logs
- Essential for our Docker-based development workflow

### 13. Dev Containers (`ms-vscode-remote.remote-containers`)
**Development inside containers**
- Develop inside Docker containers
- Full VS Code experience in containerized environments
- Consistent development environment across machines
- Perfect for our Docker-first approach

## AI & Productivity Extensions

### 14. GitHub Copilot (`GitHub.copilot`)
**AI-powered code completion**
- Intelligent code suggestions
- Context-aware completions
- Supports Ruby, JavaScript, HTML, CSS, and more
- Significantly speeds up development

### 15. GitHub Copilot Chat (`GitHub.copilot-chat`)
**AI chat assistant for coding**
- Natural language code explanations
- Code refactoring suggestions
- Debug assistance
- Technical documentation help

## Code Quality & Navigation Extensions

### 16. Auto Rename Tag (`formulahendry.auto-rename-tag`)
**Automatic HTML/XML tag renaming**
- Automatically renames paired HTML/ERB tags
- Prevents mismatched tags
- Essential for ERB template development

### 17. Better Comments (`aaron-bond.better-comments`)
**Enhanced comment highlighting**
- Color-coded comments (TODO, FIXME, etc.)
- Better visual organization of code comments
- Supports multiple comment styles

### 18. Material Icon Theme (`PKief.material-icon-theme`)
**Better file icons**
- Beautiful file and folder icons
- Language-specific icons
- Better visual file type recognition

### 19. Path Intellisense (`christian-kohler.path-intellisense`)
**File path autocompletion**
- Intelligent file path suggestions
- Reduces typos in import/require statements
- Works with relative and absolute paths

### 20. Code Spell Checker (`streetsidesoftware.code-spell-checker`)
**Spell checking for code**
- Spell checking in comments and strings
- Customizable dictionaries
- Helps maintain professional documentation

## Testing Extensions

### 21. Test Adapter Converter (`ms-vscode.test-adapter-converter`)
**Test framework integration**
- Converts test adapters for unified testing interface
- Works with various Ruby testing frameworks

### 22. Test Explorer UI (`hbenl.vscode-test-explorer`)
**Visual test runner interface**
- Tree view of all tests
- Run individual tests or test suites
- Visual test results and debugging

### 23. Coverage Gutters (`ryanluker.vscode-coverage-gutters`)
**Code coverage visualization**
- Shows test coverage in the editor gutter
- Highlights covered and uncovered lines
- Supports SimpleCov (Ruby's coverage tool)

## Development Tools

### 24. Live Server (`ms-vscode.live-server`)
**Local development server**
- Quick local server for static files
- Auto-refresh on file changes
- Useful for frontend development and testing

### 25. Code Runner (`formulahendry.code-runner`)
**Quick code execution**
- Run code snippets in various languages
- Useful for testing Ruby scripts
- Quick prototyping and debugging

### 26. JavaScript Profiler (`ms-vscode.vscode-js-profile-table`)
**Performance profiling for JavaScript**
- Profile JavaScript performance
- Useful for frontend optimization
- Advanced debugging capabilities

## Configuration Notes

### Solargraph Setup
To get the most out of Solargraph, ensure you have the gem installed:

```bash
# The gem is already in our Gemfile, but you can install it manually:
gem install solargraph

# Generate Solargraph configuration
solargraph config
```

### Ruby Language Server Choice
This workspace includes both Solargraph and Ruby LSP. **Choose one:**

**Option 1: Solargraph (Default)**
- More mature and feature-complete
- Better documentation support
- Requires `solargraph` gem

**Option 2: Ruby LSP (Performance)**
- Faster performance, especially for large projects
- Built by Shopify
- More modern architecture

To use Ruby LSP instead of Solargraph:
1. Disable Solargraph extension
2. Enable Ruby LSP extension
3. Add to your Gemfile: `gem 'ruby-lsp'`

### Ruby Debugging
For Ruby debugging support, you may want to install additional debugging extensions:

```bash
# Install the Ruby debug gem
gem install debug
```

Then add to your extensions:
- `ruby-lsp` - Ruby Language Server Protocol
- `vscode-rdbg` - Ruby debugging support

### Prettier Configuration
Our project includes Prettier configuration in `package.json`. The extension will automatically use these settings.

### ESLint Configuration
ESLint configuration is included in our project setup and will automatically lint JavaScript files according to our coding standards.

## VS Code Tasks and Debugging

This workspace includes pre-configured VS Code tasks and debugging configurations:

### Available Tasks
Access via Command Palette (`Ctrl+Shift+P`) → "Tasks: Run Task":

1. **Rails: Start Development Server** - Starts the Docker development environment
2. **Rails: Generate New App** - Initializes a new Rails application
3. **Rails: Run Tests** - Executes the test suite
4. **Rails: Run Linter** - Runs RuboCop linting
5. **Rails: Open Console** - Opens Rails console
6. **Docker: Build Development Environment** - Rebuilds Docker containers
7. **Docker: Stop All Services** - Stops all running containers
8. **Rails: Database Setup** - Sets up the database
9. **Rails: Generate Migration** - Creates new migration
10. **Rails: Run Migrations** - Applies pending migrations

### Debugging Configurations
Access via Run and Debug panel (`Ctrl+Shift+D`):

1. **Debug Rails Server (Docker)** - Attach debugger to running Rails server
2. **Run Rails Server in Terminal** - Launch Rails server with integrated terminal

To enable full Ruby debugging, install the `debug` gem and consider additional Ruby debugging extensions.

## Extension Categories Summary

| Category | Count | Purpose |
|----------|-------|---------|
| Ruby/Rails | 4 | Core Ruby and Rails development and debugging |
| Frontend | 3 | CSS, JavaScript, and styling |
| Language Support | 2 | JSON and YAML files |
| Docker/DevOps | 2 | Container development |
| AI/Productivity | 2 | GitHub Copilot assistance |
| Code Quality | 5 | Navigation, comments, icons, paths, spelling |
| Testing | 3 | Test running and coverage |
| Development Tools | 3 | Servers, runners, profiling |

**Total: 24 Extensions**

## Recommended Workflow

1. **Start with Core Extensions**: Install Ruby, Solargraph, and Docker extensions first
2. **Add AI Assistance**: Enable GitHub Copilot for enhanced productivity
3. **Install Quality Tools**: Add linting, formatting, and spell checking
4. **Enable Testing**: Set up test runners and coverage tools
5. **Customize Experience**: Add themes, icons, and productivity extensions

## Troubleshooting

### Common Issues

1. **Solargraph not working**: Ensure the `solargraph` gem is installed and run `solargraph download-core`
2. **Docker extension issues**: Make sure Docker is running on your system
3. **Prettier conflicts**: Check if multiple formatters are enabled for the same file type
4. **Test extensions not finding tests**: Ensure your test files follow Rails conventions

### Performance Considerations

- Some extensions may impact VS Code startup time
- Disable unused extensions for better performance
- Consider using workspace-specific settings for large projects

## Contributing

When adding new extensions to the project:

1. Add the extension ID to `.vscode/extensions.json`
2. Document the extension in this file
3. Include any necessary configuration in `.vscode/settings.json`
4. Update the README if the extension requires special setup

## Additional Resources

- [VS Code Ruby Extension Pack](https://marketplace.visualstudio.com/items?itemName=castwide.ruby-extension-pack)
- [Rails Development Setup Guide](https://code.visualstudio.com/docs/languages/ruby)
- [Docker Development in VS Code](https://code.visualstudio.com/docs/containers/overview)
- [GitHub Copilot Documentation](https://docs.github.com/en/copilot)

---

*This documentation is part of the Ruby on Rails Blog Project. For questions or improvements, please open an issue or submit a pull request.*
