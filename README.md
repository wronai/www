# WronAI Projects Dashboard

A static dashboard to showcase WronAI's open source projects with automatic repository analysis.

## Features

- Automatic repository analysis (via GitHub Actions)
- Package manager detection (pip, npm, yarn, poetry)
- PyPI package verification
- Docker support detection
- GitHub Actions workflow detection
- Responsive design with dark mode support
- Deployed as a static site on GitHub Pages

## Local Development

### Prerequisites

- Node.js 18+
- npm or yarn

### Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/wronai/www.git
   cd www
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Run the development server**:
   ```bash
   make dev
   ```

## Available Commands

- `make install` - Install dependencies
- `make dev` - Start development server
- `make build` - Build for production
- `make analyze` - Analyze repositories and update data
- `make token-page` - Open GitHub token creation page
- `make deploy` - Deploy to production
- `make clean` - Clean build artifacts

## Repository Analysis

The system automatically analyzes repositories to extract:

- Package information (name, version)
- Dependencies
- Docker support
- CI/CD configuration

To manually trigger repository analysis:

```bash
make analyze
```

This will:
1. Clone and analyze all repositories
2. Update `repos.json` with the latest information
3. Create a backup of the previous data

## Development

### Adding a New Repository

1. Add the repository to `repos.json`
2. Run `make analyze` to update the metadata
3. Commit and push the changes

### Customizing the Dashboard

- Edit `index.html` for the main structure
- Modify `css/styles.css` for styling
- Update `js/main.js` for interactivity

## Deployment

The site is automatically deployed to GitHub Pages on push to the `main` branch. The deployment includes:

1. Repository analysis
2. Dependency installation
3. Site building
4. Deployment to GitHub Pages

## License

Apache
