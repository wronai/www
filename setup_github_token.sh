#!/bin/bash

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}Creating .env file from .env.example...${NC}"
    cp .env.example .env
fi

# Check if GITHUB_TOKEN is already set in .env
if grep -q "^GITHUB_TOKEN=" .env; then
    echo -e "${GREEN}✓ GitHub token is already configured in .env${NC}"
    exit 0
fi

echo -e "${YELLOW}GitHub Personal Access Token is not configured.${NC}"
echo -e "Let's create a new token with the required permissions...\n"

# Default scopes needed for the repository analysis
SCOPES=(
    "repo"
    "read:org"
    "read:user"
    "user:email"
    "read:packages"
    "read:project"
    "read:repo_hook"
    "read:discussion"
    "workflow"
)

# Convert scopes to URL parameters
SCOPES_PARAM=$(IFS=,; echo "${SCOPES[*]}" | sed 's/ /,/g')

# Generate the GitHub token creation URL
TOKEN_URL="https://github.com/settings/tokens/new?scopes=${SCOPES_PARAM}&description=WronAI+Dashboard+$(date +%Y%m%d%H%M%S)"

# Create a simple HTML page to redirect to the token creation
cat > token_redirect.html << 'EOL'
<!DOCTYPE html>
<html>
<head>
    <title>GitHub Token Setup - WronAI Dashboard</title>
    <style>
        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            line-height: 1.6;
            max-width: 800px;
            margin: 0 auto;
            padding: 2rem;
            color: #24292e;
        }
        .container {
            background-color: #f6f8fa;
            border: 1px solid #e1e4e8;
            border-radius: 6px;
            padding: 2rem;
            margin-top: 2rem;
        }
        h1 {
            color: #24292e;
            margin-top: 0;
        }
        .btn {
            display: inline-block;
            background-color: #2ea44f;
            color: white;
            padding: 0.75rem 1.5rem;
            text-decoration: none;
            border-radius: 6px;
            font-weight: 600;
            margin: 1rem 0;
            transition: background-color 0.2s;
        }
        .btn:hover {
            background-color: #2c974b;
        }
        .scopes {
            background-color: white;
            border: 1px solid #e1e4e8;
            border-radius: 6px;
            padding: 1rem;
            margin: 1rem 0;
        }
        .scope-item {
            margin: 0.5rem 0;
            display: flex;
            align-items: center;
        }
        .scope-item input[type="checkbox"] {
            margin-right: 0.75rem;
        }
        .scope-name {
            font-weight: 600;
            margin-right: 0.5rem;
        }
        .scope-description {
            color: #586069;
            font-size: 0.9em;
        }
        .manual-steps {
            margin-top: 2rem;
            padding: 1rem;
            background-color: #f1f8ff;
            border-left: 4px solid #0366d6;
            border-radius: 0 6px 6px 0;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>GitHub Token Setup</h1>
        <p>This will help you create a GitHub Personal Access Token with the necessary permissions for the WronAI Dashboard.</p>
        
        <div class="scopes">
            <h3>Required Permissions:</h3>
            <div class="scope-item">
                <input type="checkbox" id="repo" checked disabled>
                <div>
                    <span class="scope-name">repo</span>
                    <div class="scope-description">Full control of private repositories</div>
                </div>
            </div>
            <div class="scope-item">
                <input type="checkbox" id="read_org" checked disabled>
                <div>
                    <span class="scope-name">read:org</span>
                    <div class="scope-description">Read organization membership</div>
                </div>
            </div>
            <div class="scope-item">
                <input type="checkbox" id="read_user" checked disabled>
                <div>
                    <span class="scope-name">read:user</span>
                    <div class="scope-description">Read user profile data</div>
                </div>
            </div>
        </div>

        <a href="" id="token-link" class="btn">Generate Token on GitHub</a>

        <div class="manual-steps">
            <h3>After generating the token:</h3>
            <ol>
                <li>Copy the generated token (it will only be shown once)</li>
                <li>Paste it into your <code>.env</code> file as <code>GITHUB_TOKEN=your_token_here</code></li>
                <li>Save the file and run the setup again</li>
            </ol>
        </div>
    </div>

    <script>
        // Set up the token URL with the correct scopes
        const urlParams = new URLSearchParams(window.location.search);
        const scopes = urlParams.get('scopes') || 'repo,read:org,read:user';
        const description = urlParams.get('description') || 'WronAI+Dashboard';
        
        const tokenUrl = `https://github.com/settings/tokens/new?scopes=${encodeURIComponent(scopes)}&description=${encodeURIComponent(description)}`;
        document.getElementById('token-link').href = tokenUrl;
        
        // Auto-redirect after a short delay
        setTimeout(() => {
            window.location.href = tokenUrl;
        }, 5000);
    </script>
</body>
</html>
EOL

# Start a simple HTTP server to serve the redirect page
if command -v python3 &> /dev/null; then
    # Try Python 3
    PYTHON_CMD="python3"
    PYTHON_VER=$(python3 -c "import sys; print(sys.version_info[0])" 2>/dev/null || echo "0")
    if [ "$PYTHON_VER" -lt 3 ]; then
        PYTHON_CMD="python"
    fi
    
    echo -e "${YELLOW}Opening GitHub token creation page in your browser...${NC}"
    echo -e "If the page doesn't open automatically, please visit: http://localhost:8000/token_redirect.html\n"
    
    # Start the Python HTTP server in the background
    $PYTHON_CMD -m http.server 8000 2> /dev/null &
    SERVER_PID=$!
    
    # Open the browser
    if command -v xdg-open &> /dev/null; then
        xdg-open "http://localhost:8000/token_redirect.html"
    elif command -v open &> /dev/null; then
        open "http://localhost:8000/token_redirect.html"
    fi
    
    # Wait for user to press Enter
    read -p "Press Enter after you have created and copied your GitHub token..."
    
    # Stop the server
    kill $SERVER_PID 2> /dev/null
    rm -f token_redirect.html
    
    # Ask for the token
    echo -e "\n${YELLOW}Please paste your GitHub token (it will not be displayed):${NC}"
    read -s GITHUB_TOKEN
    
    # Update the .env file
    if grep -q "^GITHUB_TOKEN=" .env; then
        sed -i.bak "s/^GITHUB_TOKEN=.*/GITHUB_TOKEN=$GITHUB_TOKEN/" .env
    else
        echo "GITHUB_TOKEN=$GITHUB_TOKEN" >> .env
    fi
    
    echo -e "\n${GREEN}✓ GitHub token has been saved to .env${NC}"
    echo -e "You can now run the repository analysis with: ${YELLOW}make analyze${NC}"
    
else
    echo -e "${YELLOW}Could not start a local server. Please visit this URL to create a token:${NC}"
    echo -e "${TOKEN_URL}\n"
    echo -e "After creating the token, add it to your .env file like this:"
    echo -e "GITHUB_TOKEN=your_token_here\n"
fi
