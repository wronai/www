#!/bin/bash
# Build script for WronAI Website

set -e  # Exit on error

# Create dist directory if it doesn't exist
mkdir -p dist

# Copy all files to dist directory
echo "📦 Copying files to dist directory..."
cp -r src/* dist/

# Copy necessary root files
cp -t dist/ README.md .env.example

# Create necessary directories in dist
mkdir -p dist/.github/workflows
cp .github/workflows/* dist/.github/workflows/ 2>/dev/null || true

# Copy repo-analyzer to dist
cp -r repo-analyzer dist/ 2>/dev/null || true

echo "✨ Build complete! Files are in the 'dist' directory"
