#!/bin/bash
# Script to open GitHub token creation page with required scopes pre-selected

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if Python is available
if command -v python3 &> /dev/null; then
    PYTHON_CMD="python3"
else
    PYTHON_CMD="python"
fi

# Run the Python script
"$PYTHON_CMD" "$SCRIPT_DIR/open_github_token.py"
