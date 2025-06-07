# WronAI Projects Dashboard

A static dashboard showcasing WronAI's open source projects with automatic repository analysis and deployment to GitHub Pages.

## Features

- Automatic repository analysis via GitHub Actions
- Package manager detection (pip, npm, yarn, poetry)
- PyPI package verification
- Docker support detection
- GitHub Actions workflow detection
- Responsive design with dark mode support
- Automated deployment to GitHub Pages
- Concurrent deployment protection
- Branch-specific deployments

## Getting Started

### Prerequisites

- Node.js 20+ (LTS recommended)
- npm
- Python 3.10+ (for repository analysis)
- Docker (for local GitHub Actions testing)

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/wronai/www.git
   cd www
   ```

2. **Install dependencies**:
   ```bash
   make install
   ```

3. **Start development server**:
   ```bash
   make dev
   ```
   This starts a local server at http://localhost:3000

## Development

### Available Commands

Run `make help` to see all available commands:

```
make help           Show this help
make install       Install dependencies
make dev           Start development server
make build         Build for production
make preview       Preview production build
make clean         Clean build artifacts
make update-repos  Update repository data
make setup-dev     Set up development tools
make test-gh-actions  Test GitHub Actions locally
make setup-test-env  Set up test environment
```

### Repository Analysis

The system automatically analyzes repositories to extract:
- Package information (name, version)
- Dependencies
- Docker support
- CI/CD configuration
- Last update time
- Language detection

To manually update repository data:
```bash
make update-repos
```

### Project Structure

```
www/
├── src/                  # Source files
│   ├── css/              # Stylesheets
│   ├── js/               # JavaScript files
│   └── index.html        # Main HTML file
├── .github/workflows/    # GitHub Actions workflows
├── repo-analyzer/        # Repository analysis tools
├── scripts/              # Utility scripts
└── update_repos.py       # Main repository update script
```

## GitHub Actions Workflows

1. **Analyze Repositories** (`.github/workflows/analyze.yml`)
   - Runs daily at 4 AM UTC or on push to `repo-analyzer/**`
   - Updates `repos.json` with repository information

2. **Deploy to GitHub Pages** (`.github/workflows/deploy.yml`)
   - Triggers on push to `main` branch
   - Builds and deploys the production site

3. **Static Site Deployment** (`.github/workflows/static-deploy.yml`)
   - Alternative deployment with SPA routing support

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License

This project is licensed under the terms of the MIT license. See [LICENSE](LICENSE) for more details.

The site is automatically deployed to GitHub Pages through GitHub Actions. The deployment process:

1. **Analysis Workflow**:
   - Runs daily or on push to `repo-analyzer/**`
   - Updates repository metadata
   - Commits changes to `repos.json`

2. **Deployment Workflow**:
   - Triggers on push to `main` or after analysis
   - Installs dependencies
   - Builds the production site
   - Deploys to GitHub Pages

### Manual Deployment

1. Make your changes
2. Commit and push to `main`
3. The deployment will start automatically

## Troubleshooting

### Common Issues

1. **Build fails**
   - Run `npm install` to ensure all dependencies are installed
   - Check for errors in the GitHub Actions logs

2. **Repository data not updating**
   - Run `make update-repos` manually
   - Check the `analyze` workflow logs

3. **Deployment fails**
   - Verify all required files exist
   - Check for syntax errors in the workflow files
   - Ensure GitHub Pages is properly configured in the repository settings

## License

Apache 2.0

## License

Apache
