#!/bin/bash
set -e

# Default depth level
DEPTH=${1:-2}

# Validate input is a number
if ! [[ "$DEPTH" =~ ^[0-9]+$ ]]; then
    echo "Error: Depth level must be a number"
    echo "Usage: $0 [depth] (default: 2)"
    exit 1
fi

PATHH=$(pwd)
echo "Starting from directory: $PATHH"
echo "Scanning up to depth level: $DEPTH"

# Create or clear the SUM.md file
echo "# Combined READMEs\n" > SUM.md

# Function to check if a directory is in a git repository
is_git_repo() {
    local dir="$1"
    # Check if .git exists and is a directory (for normal repos) or a file (for submodules)
    [ -e "$dir/.git" ] || git -C "$dir" rev-parse --git-dir > /dev/null 2>&1
}

# Find all README.md files in subdirectories up to specified depth and concatenate them
find "$PATHH" -maxdepth "$DEPTH" -type f -name "README.md" 2>/dev/null | sort | while read -r file; do
    # Get the directory of the current file
    dir=$(dirname "$file")
    
    # Skip if we can't read the file
    [ -r "$file" ] || {
        echo "Warning: Cannot read $file - skipping"
        continue
    }
    
    # Only check git ignore if in a git repo
    if is_git_repo "$dir"; then
        # Check if the directory is ignored by git (suppress stderr for non-git dirs)
        if git -C "$dir" check-ignore -q "$dir" 2>/dev/null; then
            echo "Skipping gitignored directory: $dir"
            continue
        fi
    fi
    
    echo "Processing: $file"
    # Add a header with the file path
    echo -e "\n## ${dir#$PATHH/}\n" >> SUM.md
    # Append the file content
    cat "$file" >> SUM.md
done

echo "\nAll non-ignored README.md files up to depth $DEPTH have been combined into SUM.md"
