#!/usr/bin/env python3
"""
Script to update repos.json and CHANGELOG.md with the latest repository information.
"""

import json
import os
import subprocess
import sys
import os
from datetime import datetime
from pathlib import Path
from typing import Dict, List, Optional, Tuple, Any

# Add the repo-analyzer directory to the Python path
sys.path.append(os.path.join(os.path.dirname(os.path.abspath(__file__)), 'repo-analyzer'))

# Configuration
REPOS_JSON_PATH = Path(__file__).parent / 'repos.json'
CHANGELOG_PATH = Path(__file__).parent / 'CHANGELOG.md'
GITHUB_ORG = 'wronai'

def _cleanup_pypi_info(repo):
    """Helper method to clean up PyPI information from a repo"""
    if 'pypi' in repo:
        del repo['pypi']
    if 'pypi_url' in repo:
        del repo['pypi_url']

def check_pypi_package(package_name):
    """Check if a package exists on PyPI using curl"""
    try:
        result = subprocess.run(
            ['curl', '-s', f'https://pypi.org/pypi/{package_name}/json'],
            capture_output=True,
            text=True
        )
        
        if result.returncode == 0:
            try:
                data = json.loads(result.stdout)
                return 'info' in data and 'name' in data['info']
            except json.JSONDecodeError:
                return False
        return False
    except Exception as e:
        print(f"Error checking PyPI for {package_name}: {e}")
        return False

def get_github_repos() -> List[Dict[str, Any]]:
    """Fetch repository information from GitHub API."""
    try:
        cmd = [
            'gh', 'api', '-H', 'Accept: application/vnd.github+json',
            f'/orgs/{GITHUB_ORG}/repos', '--paginate',
            '--jq', '.[] | "\(.name)|\(.description // "")|\(.html_url)|\(.homepage // "")|\(.updated_at)|\(.archived)|\(.fork)|\(.language // "Other")"'
        ]
        result = subprocess.run(cmd, capture_output=True, text=True, check=True)
        
        repos = []
        for line in result.stdout.strip().split('\n'):
            if not line.strip():
                continue
                
            name, description, url, website, updated_at, is_archived, is_fork, language = line.split('|')
            
            # Clean up description (handle None and strip whitespace)
            description = description.strip() if description else ""
            
            # Format repository data - preserve existing PyPI info if it exists
            repo = {
                'name': name,
                'description': description,
                'url': url,
                'website': website if website and website.startswith('http') else f"https://{GITHUB_ORG}.github.io/{name}/",
                'updatedAt': updated_at,
                'isArchived': is_archived.lower() == 'true',
                'isFork': is_fork.lower() == 'true',
                'language': language,
                'pypi': '',  # Will be updated if package exists on PyPI
                'cloneCommand': f"git clone {url}.git",
                'installCommand': f"pip install {name}" if language.lower() == 'python' else ""
            }
            
            # Preserve existing PyPI info if it exists in the current repos.json
            existing_repos = {}
            if REPOS_JSON_PATH.exists():
                with open(REPOS_JSON_PATH, 'r') as f:
                    data = json.load(f)
                    existing_repos = {r['name']: r for r in data.get('repositories', [])}
            
            if name in existing_repos:
                existing_repo = existing_repos[name]
                if 'pypi' in existing_repo:
                    repo['pypi'] = existing_repo['pypi']
                if 'pypi_url' in existing_repo:
                    repo['pypi_url'] = existing_repo['pypi_url']
            
            # Check if this is a Python package by analyzing the repository
            try:
                from repo_analyzer.analyze_repo import RepoAnalyzer
                
                # Initialize the analyzer
                analyzer = RepoAnalyzer()
                
                # Analyze the repository
                metadata = analyzer.analyze_repository(repo['url'])
                
                # If it's a Python package on PyPI, get the package name
                if metadata.get('on_pypi') and metadata.get('package_name'):
                    pypi_name = metadata['package_name']
                else:
                    pypi_name = None
            except Exception as e:
                print(f"Error analyzing repository {name}: {e}")
                pypi_name = None
            if pypi_name:
                # Verify the package exists on PyPI
                if check_pypi_package(pypi_name):
                    repo['pypi'] = pypi_name
                    repo['pypi_url'] = f'https://pypi.org/project/{pypi_name}/'
                    # Set install command for PyPI packages
                    repo['installCommand'] = f'pip install {pypi_name}'
                else:
                    _cleanup_pypi_info(repo)
                    # Remove install command if package is not on PyPI
                    if 'installCommand' in repo:
                        del repo['installCommand']
            elif name == '2025-06':
                # This is a documentation/planning repo, not a Python package
                if 'installCommand' in repo:
                    del repo['installCommand']
                if 'pypi' in repo:
                    del repo['pypi']
                if 'pypi_url' in repo:
                    del repo['pypi_url']
                    
            # Ensure all Python repos without PyPI info have their PyPI fields cleaned up
            if repo.get('language', '').lower() == 'python' and not repo.get('pypi'):
                if 'pypi_url' in repo:
                    del repo['pypi_url']
            elif repo.get('language', '').lower() == 'python' and repo.get('pypi') and not repo.get('pypi_url'):
                repo['pypi_url'] = f"https://pypi.org/project/{repo['pypi']}/"
                
            repos.append(repo)
            
        return sorted(repos, key=lambda x: x['name'].lower())
        
    except subprocess.CalledProcessError as e:
        print(f"Error fetching repositories from GitHub: {e}")
        print(f"STDERR: {e.stderr}")
        return []

def update_repos_json(repos: List[Dict[str, Any]]) -> Tuple[bool, Dict[str, Dict]]:
    """Update repos.json with the latest repository information."""
    try:
        # Read existing repos to compare
        existing_repos = {}
        if REPOS_JSON_PATH.exists():
            with open(REPOS_JSON_PATH, 'r') as f:
                data = json.load(f)
                existing_repos = {repo['name']: repo for repo in data.get('repositories', [])}
        
        # Update or add repositories
        changes = {'added': {}, 'updated': {}, 'removed': {}}
        updated_repos = {}
        
        # Check for new or updated repos
        for repo in repos:
            name = repo['name']
            if name in existing_repos:
                # Check if anything changed
                if repo != existing_repos[name]:
                    changes['updated'][name] = {
                        'old': existing_repos[name],
                        'new': repo
                    }
            else:
                changes['added'][name] = repo
            updated_repos[name] = repo
            
        # Check for removed repos
        for name in set(existing_repos.keys()) - set(updated_repos.keys()):
            changes['removed'][name] = existing_repos[name]
        
        # Only update the file if there are changes
        if any(changes.values()):
            with open(REPOS_JSON_PATH, 'w') as f:
                json.dump({'repositories': list(updated_repos.values())}, f, indent=2)
            return True, changes
            
        return False, changes
        
    except Exception as e:
        print(f"Error updating repos.json: {e}")
        return False, {}

def update_changelog(changes: Dict[str, Dict], version: str = None) -> bool:
    """Update CHANGELOG.md with the latest changes."""
    try:
        # Prepare changelog entry
        now = datetime.utcnow().strftime('%Y-%m-%d')
        version = version or f"v{now.replace('-', '.')}"
        
        entry = f"## [{version}] - {now}\n\n"
        
        # Initialize empty sections
        added_entries = []
        updated_entries = []
        removed_entries = []
        
        # Process added repositories
        if 'added' in changes and changes['added']:
            for name, repo in changes['added'].items():
                desc = repo.get('description', 'No description')
                added_entries.append(f"- Added `{name}`: {desc} ([GitHub]({repo['url']}))")
        
        # Process updated repositories
        if 'updated' in changes and changes['updated']:
            for name, data in changes['updated'].items():
                old_repo = data.get('old', {})
                new_repo = data.get('new', {})
                field_changes = []
                
                # Check for description changes
                if old_repo.get('description') != new_repo.get('description'):
                    old_desc = old_repo.get('description', 'No description')
                    new_desc = new_repo.get('description', 'No description')
                    field_changes.append(f"description: '{old_desc}' → '{new_desc}'")
                
                # Check for other field changes
                for field in ['website', 'language', 'pypi']:
                    if old_repo.get(field) != new_repo.get(field):
                        old_val = old_repo.get(field, 'None')
                        new_val = new_repo.get(field, 'None')
                        field_changes.append(f"{field}: '{old_val}' → '{new_val}'")
                
                if field_changes:
                    updated_entries.append(f"- Updated `{name}`: {', '.join(field_changes)}")
        
        # Process removed repositories
        if 'removed' in changes and changes['removed']:
            for name, repo in changes['removed'].items():
                desc = repo.get('description', 'No description')
                removed_entries.append(f"- Removed `{name}`: {desc}")
        
        # Build the changelog entry
        if added_entries:
            entry += "### Added\n" + "\n".join(added_entries) + "\n\n"
        if updated_entries:
            entry += "### Changed\n" + "\n".join(updated_entries) + "\n\n"
        if removed_entries:
            entry += "### Removed\n" + "\n".join(removed_entries) + "\n\n"
        
        # Read existing changelog
        changelog = f"# Changelog\n\nAll notable changes to this project will be documented in this file.\n\n"
        if CHANGELOG_PATH.exists():
            with open(CHANGELOG_PATH, 'r') as f:
                existing_content = f.read()
                # Remove the header if it exists
                if existing_content.startswith('# Changelog'):
                    existing_content = existing_content.split('\n', 2)[-1].lstrip()
                changelog = f"# Changelog\n\n{entry}{existing_content}"
        else:
            changelog = f"# Changelog\n\n{entry}"
        
        # Write the updated changelog
        with open(CHANGELOG_PATH, 'w') as f:
            f.write(changelog)
            
        return True
        
    except Exception as e:
        import traceback
        print(f"Error updating CHANGELOG.md: {e}")
        print(f"Traceback: {traceback.format_exc()}")
        return False

def main():
    print("Fetching repository information from GitHub...")
    repos = get_github_repos()
    
    if not repos:
        print("No repositories found or error occurred while fetching from GitHub.")
        return
    
    print(f"Found {len(repos)} repositories.")
    
    print("Updating repos.json...")
    updated, changes = update_repos_json(repos)
    
    if not any(changes.values()):
        print("No changes detected in repositories.")
        return
    
    if updated:
        print("Successfully updated repos.json")
        
        # Print summary of changes
        if changes.get('added'):
            print(f"\nAdded {len(changes['added'])} repositories:")
            for name in changes['added']:
                print(f"- {name}")
        
        if changes.get('updated'):
            print(f"\nUpdated {len(changes['updated'])} repositories:")
            for name in changes['updated']:
                print(f"- {name}")
        
        if changes.get('removed'):
            print(f"\nRemoved {len(changes['removed'])} repositories:")
            for name in changes['removed']:
                print(f"- {name}")
        
        # Update CHANGELOG.md
        print("\nUpdating CHANGELOG.md...")
        if update_changelog(changes):
            print("Successfully updated CHANGELOG.md")
        else:
            print("Failed to update CHANGELOG.md")
    else:
        print("No changes were made to repos.json")

if __name__ == "__main__":
    main()
