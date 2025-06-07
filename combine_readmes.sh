#!/bin/bash

# Create or clear the SUM.md file
echo "# Combined READMEs\n" > SUM.md

# Find all README.md files in subdirectories and concatenate them
find . -type f -name "README.md" | sort | while read -r file; do
    # Add a header with the file path
echo -e "\n## $(dirname "$file")\n" >> SUM.md
    # Append the file content
    cat "$file" >> SUM.md
done

echo "All README.md files have been combined into SUM.md"
