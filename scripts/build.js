#!/usr/bin/env node

const fs = require('fs-extra');
const path = require('path');

// Configuration
const SRC_DIR = path.join(__dirname, '../src');
const PUBLIC_DIR = path.join(__dirname, '../public');
const DIST_DIR = path.join(__dirname, '../dist');
const REPO_DATA_FILE = path.join(__dirname, '../repos.json');

// Ensure the dist directory exists
fs.ensureDirSync(DIST_DIR);

console.log('Cleaning dist directory...');
fs.emptyDirSync(DIST_DIR);

// Copy files from src to dist
console.log('Copying source files...');
fs.copySync(SRC_DIR, DIST_DIR, { overwrite: true });

// Copy public files (overwrites any existing files with the same names)
console.log('Copying public files...');
fs.copySync(PUBLIC_DIR, DIST_DIR, { overwrite: true });

// Copy repository data
if (fs.existsSync(REPO_DATA_FILE)) {
  console.log('Copying repository data...');
  fs.copyFileSync(REPO_DATA_FILE, path.join(DIST_DIR, 'repos.json'));
}

// Create a simple index.html if it doesn't exist
const indexPath = path.join(DIST_DIR, 'index.html');
if (!fs.existsSync(indexPath)) {
  console.log('Creating default index.html...');
  const defaultHtml = `
    <!DOCTYPE html>
    <html lang="en">
    <head>
      <meta charset="UTF-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
      <title>WronAI Projects</title>
      <link rel="stylesheet" href="/www/css/styles.css">
    </head>
    <body>
      <div id="app">
        <h1>WronAI Projects Dashboard</h1>
        <p>Loading projects...</p>
      </div>
      <script src="/www/js/main.js"></script>
    </body>
    </html>
  `;
  fs.writeFileSync(indexPath, defaultHtml);
}

// Create CNAME file for custom domain (if needed)
const cnamePath = path.join(DIST_DIR, 'CNAME');
if (!fs.existsSync(cnamePath)) {
  console.log('Creating CNAME file...');
  fs.writeFileSync(cnamePath, 'www.wron.ai');
}

console.log('Build completed successfully!');
