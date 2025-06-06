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
- Local GitHub Actions testing support

## Local Development

### Prerequisites

- Node.js 18+ (LTS recommended)
- npm or yarn
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

## Local GitHub Actions Testing

You can test GitHub Actions workflows locally using `act`. This helps catch issues before pushing to the repository.

### Prerequisites

- [Docker](https://docs.docker.com/get-docker/) installed and running
- Sufficient disk space (Docker images can be large)

### Setup

1. **Install the development tools**:
   ```bash
   make setup-dev
   ```

2. **Set up test environment**:
   ```bash
   make setup-test-env
   ```
   This creates necessary files like `repos.json` and `.env` with test values.

### Running Tests

1. **Test GitHub Actions workflows**:
   ```bash
   make test-gh-actions
   ```
   This will run all GitHub Actions workflows defined in `.github/workflows/`

2. **Run a specific workflow**:
   ```bash
   act -W .github/workflows/static-deploy.yml
   ```

### Tips for Local Testing

- The first run will download the GitHub Actions runner image (can take several minutes)
- Use `-j` to run a specific job:
  ```bash
  act -j build
  ```
- Add `-v` for verbose output
- Use `--rm` to remove containers after run

## Available Make Commands

Run `make help` to see all available commands:

```
make help        Show this help
make install     Install dependencies
make dev         Start development server
make build       Build for production
make preview     Preview production build
make clean       Clean build artifacts
make setup-dev   Set up development tools (act)
make test-gh-actions  Test GitHub Actions locally
make setup-test-env   Set up test environment
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
