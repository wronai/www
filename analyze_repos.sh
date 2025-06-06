#!/bin/bash
# Script to analyze GitHub repositories using Docker

set -e

# Load environment variables from .env file
if [ -f .env ]; then
    export $(grep -v '^#' .env | xargs)
fi

# Configuration
GITHUB_ORG="${GITHUB_ORG:-wronai}"
GITHUB_TOKEN="${GITHUB_TOKEN:-}"
OUTPUT_DIR="$(pwd)/data"

# Check if GitHub token is set
if [ -z "$GITHUB_TOKEN" ]; then
    echo "Error: GITHUB_TOKEN is not set. Please create a .env file with your GitHub token."
    echo "You can use .env.example as a template."
    exit 1
fi

# Create output directory if it doesn't exist
mkdir -p "${OUTPUT_DIR}"

# Build the Docker image
echo "Building Docker image..."
docker build -t repo-analyzer ./repo-analyzer

# Run the analysis
echo "Starting repository analysis..."
docker run --rm \
  -e "GITHUB_TOKEN=${GITHUB_TOKEN}" \
  -v "${OUTPUT_DIR}:/data" \
  -v "$(pwd)/repo-analyzer:/app" \
  repo-analyzer python analyze_repo.py

# Update the main repos.json with the analyzed data
echo "Updating repository data..."
docker run --rm \
  -v "${OUTPUT_DIR}:/data" \
  -v "$(pwd):/app" \
  -w /app \
  python:3.10-slim \
  python repo-analyzer/update_repo_data.py

echo "Analysis complete! Review the changes in ${OUTPUT_DIR}"
