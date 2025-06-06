#!/usr/bin/env python3
"""
Update Repository Data Script

This script updates the main repos.json file with the analyzed repository data.
"""

import json
import os
import shutil
from datetime import datetime
from pathlib import Path

def backup_file(filepath: str) -> str:
    """Create a backup of the file with timestamp."""
    timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
    backup_path = f"{filepath}.bak_{timestamp}"
    shutil.copy2(filepath, backup_path)
    return backup_path

def merge_repo_data(original_repos: list, analyzed_repos: list) -> list:
    """Merge original repository data with analyzed data."""
    # Create a mapping of repo URLs to analyzed data
    analyzed_map = {}
    for repo in analyzed_repos:
        if 'repo_url' in repo:
            analyzed_map[repo['repo_url']] = repo
    
    # Merge the data
    merged_repos = []
    for repo in original_repos:
        repo_url = repo.get('url')
        if not repo_url:
            merged_repos.append(repo)
            continue
        
        # Get analyzed data for this repo
        analyzed = analyzed_map.get(repo_url, {})
        
        # Create a copy of the original repo data
        merged = repo.copy()
        
        # Update with analyzed data
        if 'package_manager' in analyzed:
            merged['package_manager'] = analyzed['package_manager']
        
        # Update package info if available
        if 'package_name' in analyzed and analyzed['package_name']:
            package_name = analyzed['package_name']
            package_manager = analyzed.get('package_manager')
            
            if package_manager in ['pip', 'poetry'] and analyzed.get('on_pypi'):
                merged['pypi'] = package_name
                merged['pypi_url'] = f'https://pypi.org/project/{package_name}/'
            elif package_manager == 'npm':
                merged['npm_url'] = f'https://www.npmjs.com/package/{package_name}'
            elif package_manager == 'go':
                merged['go_pkg_url'] = f'https://pkg.go.dev/{package_name}'
        
        # Add other metadata
        for field in ['has_dockerfile', 'has_docker_compose', 'has_github_actions']:
            if field in analyzed:
                merged[field] = analyzed[field]
        
        merged_repos.append(merged)
    
    return merged_repos

def main():
    # Paths
    script_dir = Path(__file__).parent
    data_dir = script_dir.parent
    original_path = data_dir / 'repos.json'
    analyzed_path = data_dir / 'repos_updated.json'
    
    # Check if files exist
    if not original_path.exists():
        print(f"Error: {original_path} not found")
        return
    
    if not analyzed_path.exists():
        print(f"Error: {analyzed_path} not found. Run analyze_repo.py first.")
        return
    
    # Load the data
    with open(original_path, 'r') as f:
        original_data = json.load(f)
    
    with open(analyzed_path, 'r') as f:
        analyzed_data = json.load(f)
    
    # Merge the data
    merged_repos = merge_repo_data(
        original_data.get('repositories', []),
        analyzed_data.get('repositories', [])
    )
    
    # Create updated data
    updated_data = original_data.copy()
    updated_data['repositories'] = merged_repos
    updated_data['last_updated'] = datetime.utcnow().isoformat() + 'Z'
    
    # Create a backup of the original file
    backup_path = backup_file(original_path)
    print(f"Created backup at: {backup_path}")
    
    # Save the updated data
    with open(original_path, 'w') as f:
        json.dump(updated_data, f, indent=2)
    
    print(f"Successfully updated {original_path} with analyzed repository data.")

if __name__ == "__main__":
    main()
