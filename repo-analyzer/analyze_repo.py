#!/usr/bin/env python3
"""
Repository Analysis Script

This script analyzes a GitHub repository to detect package managers and dependencies.
It updates the repository metadata in repos.json with the detected information.
"""

import os
import json
import subprocess
import shutil
import tempfile
from pathlib import Path
from typing import Dict, Any, Optional, List
import requests
from github import Github, GithubException
from tqdm import tqdm
from datetime import datetime
import yaml
import toml

# Configuration
GITHUB_TOKEN = os.getenv('GITHUB_TOKEN')
REPOS_JSON_PATH = '/data/repos.json'  # Will be mounted from host
TEMP_DIR = '/tmp/repo_analysis'

class RepoAnalyzer:
    def __init__(self, github_token: str = None):
        self.github = Github(github_token) if github_token else Github()
        self.session = requests.Session()
        self.session.headers.update({
            'Accept': 'application/vnd.github.v3+json',
            'Authorization': f'token {github_token}' if github_token else ''
        })

    def clone_repo(self, repo_url: str, dest_dir: str) -> Optional[str]:
        """Clone a repository to a temporary directory."""
        try:
            if os.path.exists(dest_dir):
                shutil.rmtree(dest_dir)
            os.makedirs(dest_dir, exist_ok=True)
            
            # Extract owner and repo name from URL
            if 'github.com' in repo_url:
                path = repo_url.split('github.com/')[-1].rstrip('/')
                if path.endswith('.git'):
                    path = path[:-4]
                owner, repo = path.split('/')[:2]
                
                # Get the default branch
                try:
                    repo_info = self.github.get_repo(f"{owner}/{repo}")
                    default_branch = repo_info.default_branch
                except Exception as e:
                    print(f"Could not get default branch for {owner}/{repo}: {e}")
                    default_branch = 'main'  # Fallback to 'main'
                
                # Clone the default branch
                subprocess.run(
                    ['git', 'clone', '--depth', '1', '--branch', default_branch, repo_url, dest_dir],
                    check=True,
                    capture_output=True
                )
                return dest_dir
        except Exception as e:
            print(f"Error cloning {repo_url}: {e}")
            return None

    def detect_package_manager(self, repo_path: str) -> Dict[str, Any]:
        """Detect package manager and extract package information."""
        result = {
            'package_manager': None,
            'package_name': None,
            'version': None,
            'dependencies': [],
            'has_dockerfile': os.path.exists(os.path.join(repo_path, 'Dockerfile')),
            'has_docker_compose': os.path.exists(os.path.join(repo_path, 'docker-compose.yml')) or 
                                 os.path.exists(os.path.join(repo_path, 'docker-compose.yaml')),
            'has_github_actions': os.path.exists(os.path.join(repo_path, '.github', 'workflows')),
        }
        
        # Check for Python package (setup.py, pyproject.toml, setup.cfg)
        if os.path.exists(os.path.join(repo_path, 'setup.py')):
            result['package_manager'] = 'pip'
            result.update(self._extract_python_metadata(repo_path))
        elif os.path.exists(os.path.join(repo_path, 'pyproject.toml')):
            result['package_manager'] = 'poetry'
            result.update(self._extract_poetry_metadata(repo_path))
        
        # Check for Node.js package (package.json)
        elif os.path.exists(os.path.join(repo_path, 'package.json')):
            result['package_manager'] = 'npm'
            result.update(self._extract_npm_metadata(repo_path))
        
        # Check for Go module (go.mod)
        elif os.path.exists(os.path.join(repo_path, 'go.mod')):
            result['package_manager'] = 'go'
            result.update(self._extract_go_metadata(repo_path))
        
        return result

    def _extract_python_metadata(self, repo_path: str) -> Dict[str, Any]:
        """Extract Python package metadata from setup.py or setup.cfg."""
        result = {'package_name': None, 'version': None, 'dependencies': []}
        
        # Try to get metadata from setup.cfg first
        setup_cfg = os.path.join(repo_path, 'setup.cfg')
        if os.path.exists(setup_cfg):
            try:
                import configparser
                config = configparser.ConfigParser()
                config.read(setup_cfg)
                if 'metadata' in config:
                    result['package_name'] = config['metadata'].get('name')
                    result['version'] = config['metadata'].get('version')
                if 'options' in config and 'install_requires' in config['options']:
                    result['dependencies'] = [dep.strip() for dep in 
                                           config['options']['install_requires'].split('\n') 
                                           if dep.strip()]
            except Exception as e:
                print(f"Error parsing setup.cfg: {e}")
        
        # Fall back to setup.py if needed
        setup_py = os.path.join(repo_path, 'setup.py')
        if (not result['package_name'] or not result['version']) and os.path.exists(setup_py):
            try:
                # Try to extract name and version using ast
                import ast
                with open(setup_py, 'r') as f:
                    tree = ast.parse(f.read())
                
                for node in ast.walk(tree):
                    if isinstance(node, ast.Call) and hasattr(node.func, 'id') and node.func.id == 'setup':
                        for kw in node.keywords:
                            if kw.arg == 'name' and isinstance(kw.value, ast.Str):
                                result['package_name'] = kw.value.s
                            elif kw.arg == 'version' and isinstance(kw.value, ast.Str):
                                result['version'] = kw.value.s
            except Exception as e:
                print(f"Error parsing setup.py: {e}")
        
        return result

    def _extract_poetry_metadata(self, repo_path: str) -> Dict[str, Any]:
        """Extract Python package metadata from pyproject.toml (Poetry)."""
        result = {'package_name': None, 'version': None, 'dependencies': []}
        pyproject_path = os.path.join(repo_path, 'pyproject.toml')
        
        if os.path.exists(pyproject_path):
            try:
                with open(pyproject_path, 'r') as f:
                    data = toml.load(f)
                
                if 'tool' in data and 'poetry' in data['tool']:
                    poetry = data['tool']['poetry']
                    result['package_name'] = poetry.get('name')
                    result['version'] = poetry.get('version')
                    
                    # Get dependencies
                    if 'dependencies' in poetry:
                        result['dependencies'] = list(poetry['dependencies'].keys())
                        # Remove python version constraint if present
                        if 'python' in result['dependencies']:
                            result['dependencies'].remove('python')
            except Exception as e:
                print(f"Error parsing pyproject.toml: {e}")
        
        return result

    def _extract_npm_metadata(self, repo_path: str) -> Dict[str, Any]:
        """Extract npm package metadata from package.json."""
        result = {'package_name': None, 'version': None, 'dependencies': []}
        package_json = os.path.join(repo_path, 'package.json')
        
        if os.path.exists(package_json):
            try:
                with open(package_json, 'r') as f:
                    data = json.load(f)
                
                result['package_name'] = data.get('name')
                result['version'] = data.get('version')
                
                # Get dependencies
                deps = []
                for dep_type in ['dependencies', 'devDependencies', 'peerDependencies']:
                    if dep_type in data and isinstance(data[dep_type], dict):
                        deps.extend(data[dep_type].keys())
                result['dependencies'] = list(set(deps))  # Remove duplicates
                
            except Exception as e:
                print(f"Error parsing package.json: {e}")
        
        return result

    def _extract_go_metadata(self, repo_path: str) -> Dict[str, Any]:
        """Extract Go module metadata from go.mod."""
        result = {'package_name': None, 'version': None, 'dependencies': []}
        go_mod = os.path.join(repo_path, 'go.mod')
        
        if os.path.exists(go_mod):
            try:
                with open(go_mod, 'r') as f:
                    lines = f.readlines()
                
                # The first line should be 'module <module-name>'
                if lines and lines[0].startswith('module '):
                    result['package_name'] = lines[0].split(' ')[1].strip()
                
                # Extract require statements for dependencies
                requires = []
                in_require = False
                for line in lines:
                    line = line.strip()
                    if line == 'require (':
                        in_require = True
                        continue
                    if in_require and line == ')':
                        in_require = False
                        continue
                    if in_require and line and not line.startswith('//'):
                        # Extract the module name (first part of the line)
                        module = line.split()[0]
                        requires.append(module)
                
                result['dependencies'] = requires
                
            except Exception as e:
                print(f"Error parsing go.mod: {e}")
        
        return result

    def check_pypi_package(self, package_name: str) -> bool:
        """Check if a package exists on PyPI."""
        if not package_name:
            return False
            
        try:
            response = self.session.get(f'https://pypi.org/pypi/{package_name}/json', timeout=5)
            return response.status_code == 200
        except Exception as e:
            print(f"Error checking PyPI for {package_name}: {e}")
            return False

    def analyze_repository(self, repo_url: str) -> Dict[str, Any]:
        """Analyze a single repository and return its metadata."""
        print(f"\nAnalyzing {repo_url}...")
        
        # Create a temporary directory for the repository
        with tempfile.TemporaryDirectory(prefix='repo_') as temp_dir:
            # Clone the repository
            repo_path = self.clone_repo(repo_url, temp_dir)
            if not repo_path or not os.path.exists(repo_path):
                print(f"Failed to clone {repo_url}")
                return {}
            
            # Detect package manager and extract metadata
            metadata = self.detect_package_manager(repo_path)
            
            # Check if the package is on PyPI (for Python packages)
            if metadata['package_manager'] in ['pip', 'poetry'] and metadata['package_name']:
                metadata['on_pypi'] = self.check_pypi_package(metadata['package_name'])
            else:
                metadata['on_pypi'] = False
            
            # Add repository URL
            metadata['repo_url'] = repo_url
            
            return metadata

def update_repos_with_metadata(repos: List[Dict], metadata_list: List[Dict]) -> List[Dict]:
    """Update repository data with metadata from analysis."""
    # Create a mapping of repo URLs to metadata
    metadata_map = {m['repo_url']: m for m in metadata_list if 'repo_url' in m}
    
    updated_repos = []
    for repo in repos:
        repo_url = repo.get('url')
        if not repo_url:
            updated_repos.append(repo)
            continue
        
        # Find matching metadata
        repo_metadata = metadata_map.get(repo_url, {})
        
        # Create an updated repo object
        updated_repo = repo.copy()
        
        # Update package manager info
        if 'package_manager' in repo_metadata:
            updated_repo['package_manager'] = repo_metadata['package_manager']
        
        # Update package info if available
        if 'package_name' in repo_metadata and repo_metadata['package_name']:
            updated_repo['pypi'] = repo_metadata['package_name'] if repo_metadata.get('on_pypi') else ''
        
        # Add other metadata
        for field in ['has_dockerfile', 'has_docker_compose', 'has_github_actions']:
            if field in repo_metadata:
                updated_repo[field] = repo_metadata[field]
        
        updated_repos.append(updated_repo)
    
    return updated_repos

def main():
    # Create output directory if it doesn't exist
    os.makedirs(TEMP_DIR, exist_ok=True)
    
    # Load repositories from repos.json
    if not os.path.exists(REPOS_JSON_PATH):
        print(f"Error: {REPOS_JSON_PATH} not found")
        return
    
    with open(REPOS_JSON_PATH, 'r') as f:
        data = json.load(f)
    
    repos = data.get('repositories', [])
    if not repos:
        print("No repositories found in repos.json")
        return
    
    print(f"Found {len(repos)} repositories to analyze")
    
    # Initialize analyzer
    analyzer = RepoAnalyzer(GITHUB_TOKEN)
    
    # Analyze each repository
    metadata_list = []
    for repo in tqdm(repos, desc="Analyzing repositories"):
        repo_url = repo.get('url')
        if not repo_url:
            continue
        
        try:
            metadata = analyzer.analyze_repository(repo_url)
            if metadata:
                metadata_list.append(metadata)
        except Exception as e:
            print(f"Error analyzing {repo_url}: {e}")
    
    # Update repositories with metadata
    updated_repos = update_repos_with_metadata(repos, metadata_list)
    
    # Save updated repositories
    output_data = {'repositories': updated_repos}
    output_path = os.path.join(os.path.dirname(REPOS_JSON_PATH), 'repos_updated.json')
    
    with open(output_path, 'w') as f:
        json.dump(output_data, f, indent=2)
    
    print(f"\nAnalysis complete. Updated repository data saved to {output_path}")
    print(f"You should review the changes and then replace {REPOS_JSON_PATH} with the updated file.")

if __name__ == "__main__":
    main()
