// Load repository data from JSON file
let repos = [];

// Get base URL from config or use empty string for local development
const BASE_URL = window.BASE_URL || '';

// Language colors mapping
const languageColors = {
    'Python': '#3572A5',
    'JavaScript': '#f1e05a',
    'TypeScript': '#2b7489',
    'HTML': '#e34c26',
    'CSS': '#563d7c',
    'Go': '#00ADD8',
    'Shell': '#89e051',
    'Documentation': '#555555',
    'Other': '#6e5494'
};

// Show error message to the user
function showError(message) {
    const errorDiv = document.createElement('div');
    errorDiv.className = 'bg-red-100 border border-red-400 text-red-700 px-4 py-3 rounded relative';
    errorDiv.role = 'alert';
    
    const strong = document.createElement('strong');
    strong.className = 'font-bold';
    strong.textContent = 'Error: ';
    
    const span = document.createElement('span');
    span.className = 'block sm:inline';
    span.textContent = message;
    
    errorDiv.appendChild(strong);
    errorDiv.appendChild(span);
    
    // Add to the top of the container
    const container = document.querySelector('.container');
    if (container.firstChild) {
        container.insertBefore(errorDiv, container.firstChild);
    } else {
        container.appendChild(errorDiv);
    }
    
    console.error(message);
}

// Fetch repository data
async function loadRepos() {
    // Try multiple possible locations for the repos.json file
    const possiblePaths = [
        // Production paths (GitHub Pages)
        `${window.location.origin}${BASE_URL}/repos.json`,
        `${window.location.origin}${BASE_URL}/data/repos_updated.json`,
        // Fallback paths (for local development)
        `${window.location.origin}/repos.json`,
        `${window.location.origin}/data/repos_updated.json`,
        // Relative paths (as last resort)
        'repos.json',
        'data/repos_updated.json'
    ];

    let lastError = null;
    
    for (const path of possiblePaths) {
        try {
            const response = await fetch(path);
            if (response.ok) {
                const data = await response.json();
                console.log(`Successfully loaded data from: ${path}`);
                
                // Handle both direct array and { repositories: [...] } formats
                if (Array.isArray(data)) {
                    return data;
                } else if (data && Array.isArray(data.repositories)) {
                    return data.repositories;
                } else if (data && data.repositories === undefined) {
                    console.warn('Repository data exists but is empty or malformed');
                    return [];
                } else {
                    throw new Error('Invalid data format in JSON');
                }
            }
            lastError = `Failed to load from ${path}: ${response.status} ${response.statusText}`;
        } catch (error) {
            lastError = `Error loading from ${path}: ${error.message}`;
            console.warn(lastError);
            // Continue to next path
        }
    }
    
    // If we get here, all paths failed
    const errorMessage = `All attempts to load repository data failed. ${lastError || ''}`;
    console.error(errorMessage);
    showError(errorMessage);
    return [];
}

// Render all repositories
function renderRepos(filterLanguage = 'all') {
    const reposContainer = document.getElementById('repos-container');
    reposContainer.innerHTML = '';
    
    const filteredRepos = filterLanguage === 'all' 
        ? repos 
        : repos.filter(repo => repo.language === filterLanguage);
    
    filteredRepos.forEach(repo => {
        const card = createRepoCard(repo);
        if (card) {
            reposContainer.appendChild(card);
        }
    });
}

// Create a repository card element
function createRepoCard(repo) {
    if (!repo) return null;
    
    const card = document.createElement('div');
    const color = languageColors[repo.language] || languageColors.Other;
    const updated = formatDate(repo.updatedAt);
    const hasInstallCommand = repo.installCommand && repo.installCommand.trim() !== '';
    const pypiUrl = repo.pypi ? `https://pypi.org/project/${repo.pypi}/` : '';
    const httpUrl = repo.url.replace('github.com', 'github.com').replace('https://', 'https://github.com/');
    
    card.innerHTML = `
        <div class="p-6">
            <div class="flex justify-between items-start mb-3">
                <h3 class="text-xl font-bold text-gray-200 dark:text-white truncate">${repo.name}</h3>
                ${repo.isArchived ? '<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 dark:bg-yellow-900 text-yellow-800 dark:text-yellow-100">Archived</span>' : ''}
            </div>
            
            <p class="text-gray-600 dark:text-gray-300 mb-4 line-clamp-2">${repo.description || 'No description provided'}</p>
            
            <div class="flex flex-wrap items-center text-sm text-gray-900 dark:text-gray-400 mb-4 gap-2">
                <span class="flex items-center">
                    <span class="language-dot" style="background-color: ${color}"></span>
                    ${repo.language || 'Unknown'}
                </span>
                <span class="mx-1">•</span>
                <span>Updated ${updated}</span>
            </div>
            
            <!-- HTTP Clone Section -->
            <div class="mb-4">
                <div class="flex items-center justify-between text-sm text-gray-500 dark:text-gray-400 mb-1">
                    <div class="flex items-center">
                        <i class="fas fa-link mr-2"></i>
                        <span>HTTP</span>
                    </div>
                </div>
                <div class="code-block group" data-command="${httpUrl}.git">
                    <div class="code-block-header">
                        <span>Clone via HTTPS</span>
                    </div>
                    <pre><code>${httpUrl}.git</code></pre>
                    <button class="copy-btn" data-command="${httpUrl}.git" aria-label="Copy to clipboard">
                        <i class="far fa-copy"></i>
                        <span class="tooltip">Copy to clipboard</span>
                    </button>
                </div>
            </div>
            
            <!-- SSH Clone Section -->
            <div class="mb-4">
                <div class="flex items-center justify-between text-sm text-gray-500 dark:text-gray-400 mb-1">
                    <div class="flex items-center">
                        <i class="fas fa-key mr-2"></i>
                        <span>SSH</span>
                    </div>
                </div>
                <div class="code-block group" data-command="git@github.com:${repo.url.split('github.com/')[1]}.git">
                    <div class="code-block-header">
                        <span>Clone with SSH</span>
                    </div>
                    <pre><code>git@github.com:${repo.url.split('github.com/')[1]}.git</code></pre>
                    <button class="copy-btn" data-command="git@github.com:${repo.url.split('github.com/')[1]}.git" aria-label="Copy to clipboard">
                        <i class="far fa-copy"></i>
                        <span class="tooltip">Copy to clipboard</span>
                    </button>
                </div>
            </div>
            
            ${hasInstallCommand ? `
            <div class="mb-4">
                <div class="flex items-center justify-between text-sm text-gray-500 dark:text-gray-400 mb-1">
                    <div class="flex items-center">
                        <i class="fas fa-terminal mr-2"></i>
                        <span>Install with pip</span>
                    </div>
                </div>
                <div class="code-block group" data-command="${repo.installCommand}">
                    <div class="code-block-header">
                        <span>Run in your terminal</span>
                    </div>
                    <pre><code>${repo.installCommand}</code></pre>
                    <button class="copy-btn" data-command="${repo.installCommand}" aria-label="Copy to clipboard">
                        <i class="far fa-copy"></i>
                        <span class="tooltip">Copy to clipboard</span>
                    </button>
                </div>
            </div>` : ''}
            
            <div class="flex flex-wrap gap-2 mt-4">
                <a href="${repo.url}" target="_blank" rel="noopener noreferrer" 
                   class="inline-flex items-center px-3 py-2 border border-gray-300 dark:border-gray-600 text-sm font-medium rounded-md text-gray-700 dark:text-gray-200 bg-white dark:bg-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 transition-colors">
                    <i class="fab fa-github mr-2"></i> View on GitHub
                </a>
                
                ${repo.website ? `
                <a href="${repo.website}" target="_blank" rel="noopener noreferrer"
                   class="inline-flex items-center px-3 py-2 border border-transparent text-sm font-medium rounded-md text-white bg-blue-600 hover:bg-blue-700 transition-colors">
                    <i class="fas fa-external-link-alt mr-2"></i> View Website
                </a>` : ''}
                
                ${pypiUrl ? `
                <a href="${pypiUrl}" target="_blank" rel="noopener noreferrer"
                   class="inline-flex items-center px-3 py-2 border border-gray-300 dark:border-gray-600 text-sm font-medium rounded-md text-gray-700 dark:text-gray-200 bg-white dark:bg-gray-700 hover:bg-gray-50 dark:hover:bg-gray-600 transition-colors">
                    <i class="fab fa-python mr-2"></i> View on PyPI
                </a>` : ''}
            </div>
        </div>
    `;
    
    // Add click handler for copy buttons with improved feedback
    card.querySelectorAll('.copy-btn').forEach(btn => {
        const tooltip = btn.querySelector('.tooltip');
        const icon = btn.querySelector('i');
        const originalIcon = icon ? icon.className : '';
        
        const showTooltip = (text) => {
            if (tooltip) {
                tooltip.textContent = text;
                tooltip.classList.add('tooltip-visible');
            }
        };
        
        const hideTooltip = () => {
            if (tooltip) {
                tooltip.classList.remove('tooltip-visible');
            }
        };
        
        btn.addEventListener('mouseenter', () => showTooltip('Copy to clipboard'));
        btn.addEventListener('mouseleave', hideTooltip);
        
        btn.addEventListener('click', async (e) => {
            e.preventDefault();
            const command = btn.getAttribute('data-command');
            
            try {
                await navigator.clipboard.writeText(command);
                
                // Visual feedback
                if (icon) {
                    const originalClass = icon.className;
                    icon.className = 'fas fa-check';
                    btn.classList.add('copied');
                    
                    // Show success tooltip
                    showTooltip('Copied!');
                    
                    // Reset after delay
                    setTimeout(() => {
                        if (icon) icon.className = originalClass;
                        btn.classList.remove('copied');
                        hideTooltip();
                    }, 2000);
                }
            } catch (err) {
                console.error('Failed to copy text: ', err);
                showTooltip('Failed to copy');
                setTimeout(hideTooltip, 2000);
            }
        });
    });
    
    return card;
}

// Set up filter buttons
function setupFilters() {
    const filterContainer = document.getElementById('filter-buttons');
    
    // Get unique languages
    const languages = [...new Set(repos.map(repo => repo.language).filter(Boolean))].sort();
    
    // Add language filter buttons
    languages.forEach(lang => {
        const btn = document.createElement('button');
        btn.className = 'filter-btn';
        btn.textContent = lang;
        btn.dataset.filter = lang;
        btn.addEventListener('click', () => {
            document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
            btn.classList.add('active');
            renderRepos(lang);
        });
        filterContainer.appendChild(btn);
    });
}

// Format date to relative time
function formatDate(dateString) {
    if (!dateString) return 'unknown';
    
    const date = new Date(dateString);
    const now = new Date();
    const diffInSeconds = Math.floor((now - date) / 1000);
    
    const intervals = {
        year: 31536000,
        month: 2592000,
        week: 604800,
        day: 86400,
        hour: 3600,
        minute: 60
    };
    
    for (const [unit, seconds] of Object.entries(intervals)) {
        const interval = Math.floor(diffInSeconds / seconds);
        if (interval >= 1) {
            return interval === 1 ? `1 ${unit} ago` : `${interval} ${unit}s ago`;
        }
    }
    
    return 'just now';
}

// Toggle dark mode
function toggleDarkMode() {
    document.documentElement.classList.toggle('dark');
    localStorage.setItem('darkMode', document.documentElement.classList.contains('dark'));
}

// Function to copy text to clipboard
async function copyToClipboard(text, button) {
    try {
        // Modern clipboard API (works in secure contexts)
        if (navigator.clipboard) {
            await navigator.clipboard.writeText(text);
        } else {
            // Fallback for insecure contexts
            const textarea = document.createElement('textarea');
            textarea.value = text;
            textarea.style.position = 'fixed';
            document.body.appendChild(textarea);
            textarea.select();
            
            try {
                document.execCommand('copy');
            } catch (err) {
                console.error('Fallback copy failed:', err);
                return false;
            } finally {
                document.body.removeChild(textarea);
            }
        }
        
        // Show copied state
        const icon = button.querySelector('i');
        const originalIcon = icon.className;
        const tooltip = button.querySelector('.tooltip');
        const originalTooltip = tooltip.textContent;
        
        // Update button state
        button.classList.add('copied');
        icon.className = 'fas fa-check';
        tooltip.textContent = 'Copied!';
        
        // Reset button state after delay
        setTimeout(() => {
            button.classList.remove('copied');
            icon.className = originalIcon;
            tooltip.textContent = originalTooltip;
        }, 2000);
        
        return true;
    } catch (err) {
        console.error('Failed to copy text: ', err);
        const tooltip = button.querySelector('.tooltip');
        tooltip.textContent = 'Copy failed!';
        setTimeout(() => {
            tooltip.textContent = 'Copy to clipboard';
        }, 2000);
        return false;
    }
}

// Initialize the page
document.addEventListener('DOMContentLoaded', async () => {
    // Handle clicks on code blocks
    document.addEventListener('click', (e) => {
        // Find the closest code block or copy button
        const codeBlock = e.target.closest('.code-block');
        const copyButton = e.target.closest('.copy-btn');
        
        if (codeBlock) {
            const command = codeBlock.getAttribute('data-command');
            const button = codeBlock.querySelector('.copy-btn');
            if (command && button) {
                copyToClipboard(command, button);
            }
        } else if (copyButton) {
            e.stopPropagation(); // Prevent event bubbling to the code block
            const command = copyButton.getAttribute('data-command');
            if (command) {
                copyToClipboard(command, copyButton);
            }
        }
    });
    
    // Check for dark mode preference
    if (localStorage.getItem('darkMode') === 'true' || 
        (!localStorage.getItem('darkMode') && window.matchMedia('(prefers-color-scheme: dark)').matches)) {
        document.documentElement.classList.add('dark');
    }

    // Add dark mode toggle button
    const header = document.querySelector('header');
    const darkModeToggle = document.createElement('button');
    darkModeToggle.className = 'dark-mode-toggle mt-4';
    darkModeToggle.innerHTML = '<i class="fas fa-moon"></i>';
    darkModeToggle.title = 'Toggle dark mode';
    darkModeToggle.onclick = toggleDarkMode;
    header.appendChild(darkModeToggle);

    // Load and render repositories
    repos = await loadRepos();
    renderRepos();
    setupFilters();
});
