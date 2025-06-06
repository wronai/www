# WronAI Projects Dashboard

A dashboard to showcase and manage WronAI's open source projects with automatic repository analysis.

## Features

- Automatic repository analysis (Python, Node.js, Go)
- Package manager detection (pip, npm, yarn, poetry)
- PyPI package verification
- Docker support detection
- GitHub Actions workflow detection
- Easy GitHub token setup
- Responsive design with dark mode support

## Prerequisites

- Docker and Docker Compose
- Python 3.8+
- GitHub Personal Access Token with required scopes

## Getting Started

1. **Clone the repository**:
   ```bash
   git clone https://github.com/wronai/www.git
   cd www
   ```

2. **Set up your environment**:
   ```bash
   # Copy the example .env file
   cp .env.example .env
   
   # Generate a GitHub token with required permissions
   make token-page
   ```

3. **Add your GitHub token**:
   - Open the generated token page in your browser
   - Click "Generate token"
   - Copy the token and add it to your `.env` file:
     ```
     GITHUB_TOKEN=your_token_here
     ```

4. **Install dependencies**:
   ```bash
   make install
   ```

5. **Run the development server**:
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
