# Source Layouts and Components

This directory contains reusable layout components and design system elements for the Ruby on Rails Blog Application.

## Structure

```
src/
├── layouts/           # Page layout templates
├── components/        # Reusable UI components
├── styles/           # SCSS stylesheets
├── javascript/       # JavaScript modules
└── assets/           # Static assets (images, fonts)
```

## Usage

These source files are designed to be:
1. **Reusable** - Components can be used across different pages
2. **Maintainable** - Centralized styling and behavior
3. **Scalable** - Easy to extend and modify
4. **Accessible** - Built with accessibility in mind

## Development

When working with these files:
1. Follow BEM methodology for CSS classes
2. Use semantic HTML elements
3. Ensure responsive design
4. Test across different browsers
5. Validate accessibility with screen readers

## Integration with Rails

These components integrate with Rails through:
- **View partials** - Rendered in ERB templates
- **Helper methods** - Ruby helpers for dynamic content
- **Asset pipeline** - SCSS and JavaScript compilation
- **Stimulus controllers** - Interactive behavior
