# WronAI Projects Dashboard

A static dashboard to showcase WronAI's open source projects with automatic repository analysis and deployment to GitHub Pages.

## Features

- Automatic repository analysis (via GitHub Actions)
- Package manager detection (pip, npm, yarn, poetry)
- PyPI package verification
- Docker support detection
- GitHub Actions workflow detection
- Responsive design with dark mode support
- Deployed as a static site on GitHub Pages
- Local development and testing support
- Automated workflows for analysis and deployment
- Concurrent deployment protection
- Branch-specific deployments

## Local Development

### Prerequisites

- Node.js 20+ (LTS recommended)
- npm
- Python 3.10+ (for repository analysis)
- Docker (for local GitHub Actions testing)

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
   This will start a local server at http://localhost:3000

## GitHub Actions Workflows

The project uses GitHub Actions for CI/CD with the following workflows:

### 1. Analyze Repositories (`analyze.yml`)
- Runs daily at 4 AM UTC or on push to `repo-analyzer/**`
- Analyzes all repositories in the organization
- Updates `repos.json` with the latest information
- Automatically commits and pushes changes

### 2. Deploy to GitHub Pages (`deploy.yml`)
- Triggers on push to `main` branch or after successful analysis
- Builds the production site
- Deploys to GitHub Pages
- Includes branch-specific concurrency control

### 3. Static Site Deployment (`static-deploy.yml`)
- Alternative deployment workflow
- Includes additional validation steps
- Handles SPA routing with custom 404 page

## Local Development

### Prerequisites
- Node.js 20+
- npm
- Python 3.10+
- Docker (for local testing)

### Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/wronai/www.git
   cd www
   ```

2. **Install dependencies**:
   ```bash
   npm install
   ```

3. **Start development server**:
   ```bash
   make dev
   ```
   This starts a local server at http://localhost:3000

4. **Update repository data**:
   ```bash
   make update-repos
   ```
   This updates the `repos.json` with the latest repository information.

## Available Make Commands

Run `make help` to see all available commands:

```
make help           Show this help
make install        Install dependencies
make dev            Start development server
make build          Build for production
make preview        Preview production build
make clean          Clean build artifacts
make update-repos   Update repository data
make setup-dev      Set up development tools
make test-gh-actions Test GitHub Actions locally
make setup-test-env  Set up test environment
```

### Command Details

- `make install` - Install all project dependencies
- `make dev` - Start the development server at http://localhost:3000
- `make build` - Build the production version of the site
- `make preview` - Preview the production build locally
- `make clean` - Remove build artifacts and temporary files
- `make update-repos` - Update repository data using `update_repos.py`
- `make setup-test-env` - Set up the test environment with necessary files

## Repository Analysis

The system automatically analyzes repositories to extract:

- Package information (name, version)
- Dependencies
- Docker support
- CI/CD configuration
- Last update time
- Language detection

### Manual Analysis

To manually update repository data:

```bash
make update-repos
```

This will:
1. Fetch the latest repository information
2. Update `repos.json`
3. Create a backup of the previous data

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

### Adding a New Repository

1. The system automatically detects new repositories in the organization
2. Run `make update-repos` to update the data
3. The changes will be included in the next deployment

### Customizing the Dashboard

- Edit `src/index.html` for the main structure
- Modify `src/css/styles.css` for styling
- Update `src/js/main.js` for interactivity
- Update repository cards in `src/js/main.js`

## Deployment

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
