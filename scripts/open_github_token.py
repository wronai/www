#!/usr/bin/env python3
"""
GitHub Token Page Opener

This script opens the GitHub Personal Access Token creation page with the required scopes pre-selected.
"""

import webbrowser
import sys
import os
from urllib.parse import quote_plus

# Required scopes for the WronAI Dashboard
SCOPES = [
    "repo",                # Full control of private repositories
    "read:org",            # Read org and team membership
    "read:user",           # Read user profile data
    "user:email",          # Access user email addresses
    "read:packages",       # Read package data
    "read:project",        # Read project data
    "read:repo_hook",      # Read repository hooks
    "read:discussion",     # Read discussion data
    "workflow",            # Update GitHub Action workflows
]

def open_github_token_page():
    # Create the token URL with scopes pre-selected
    scopes_param = ",".join(SCOPES)
    description = "WronAI+Dashboard+Token"
    
    token_url = (
        "https://github.com/settings/tokens/new"
        "?scopes=" + quote_plus(scopes_param) +
        "&description=" + quote_plus(description)
    )
    
    print("Opening GitHub token creation page in your default browser...")
    print("Required scopes will be pre-selected.")
    print("\nAfter generating the token, add it to your .env file as:")
    print("GITHUB_TOKEN=your_token_here\n")
    
    # Try to open the URL in the default browser
    try:
        webbrowser.open(token_url)
        print(f"If the page didn't open automatically, visit this URL:")
    except Exception as e:
        print(f"Error opening browser: {e}")
        print("\nPlease visit this URL manually:")
    
    print(f"\n{token_url}")

if __name__ == "__main__":
    open_github_token_page()
