#!/bin/bash
# Script to analyze GitHub repositories using Docker

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"

# Load environment variables from .env file
if [ -f "${PROJECT_ROOT}/.env" ]; then
    export $(grep -v '^#' "${PROJECT_ROOT}/.env" | xargs)
fi

# Configuration
GITHUB_ORG="${GITHUB_ORG:-wronai}"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"
OUTPUT_DIR="${PROJECT_ROOT}/data"
ANALYZER_DIR="${PROJECT_ROOT}/repo-analyzer"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="${OUTPUT_DIR}/backups"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Logging functions
info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
    exit 1
}

# Check if GitHub token is set
if [ -z "$GITHUB_TOKEN" ]; then
    error "GITHUB_TOKEN is not set. Please create a .env file with your GitHub token.\nYou can use .env.example as a template."
fi

# Create necessary directories
mkdir -p "${OUTPUT_DIR}" "${BACKUP_DIR}"

# Backup existing data if it exists
if [ -f "${OUTPUT_DIR}/repos_updated.json" ]; then
    info "Backing up existing repository data..."
    cp "${OUTPUT_DIR}/repos_updated.json" "${BACKUP_DIR}/repos_${TIMESTAMP}.json"
fi

# Build the Docker image
info "Building Docker image..."
if ! docker build -t repo-analyzer "${ANALYZER_DIR}"; then
    error "Failed to build Docker image"
fi

# Run the analysis
info "Starting repository analysis..."
# Run the repository analysis
info "Running repository analysis..."
if ! docker run --rm \
  -e "GITHUB_TOKEN=${GITHUB_TOKEN}" \
  -e "GITHUB_ORG=${GITHUB_ORG}" \
  -v "${OUTPUT_DIR}:/data" \
  -v "${ANALYZER_DIR}:/app" \
  repo-analyzer python /app/analyze_repo.py; then
    error "Repository analysis failed"
fi

# Update the main repos.json with the analyzed data
info "Updating repository data..."
if ! docker run --rm \
  -v "${OUTPUT_DIR}:/data" \
  -v "${PROJECT_ROOT}:/app" \
  -w /app \
  python:3.10-slim \
  python /app/repo-analyzer/update_repo_data.py; then
    error "Failed to update repository data"
fi

# Verify the output
if [ -f "${PROJECT_ROOT}/repos.json" ]; then
    info "Analysis complete! Updated ${PROJECT_ROOT}/repos.json"
    
    # Count the number of repositories processed
    REPO_COUNT=$(jq length "${PROJECT_ROOT}/repos.json" 2>/dev/null || echo "unknown")
    info "Processed ${REPO_COUNT} repositories"
    
    # Show the latest backup
    LATEST_BACKUP=$(ls -t "${BACKUP_DIR}/"repos_*.json 2>/dev/null | head -n 1)
    if [ -n "${LATEST_BACKUP}" ]; then
        info "Previous version backed up to ${LATEST_BACKUP}"
    fi
    
    info "You can now run 'make dev' to start the development server"
else
    warn "Analysis completed, but repos.json was not created"
    exit 1
fi
