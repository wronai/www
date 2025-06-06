// Load repository data from JSON file
let repos = [];

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

// Fetch repository data
async function loadRepos() {
    try {
        const response = await fetch('repos.json');
        const data = await response.json();
        return data.repositories;
    } catch (error) {
        console.error('Error loading repository data:', error);
        return [];
    }
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
                <h3 class="text-xl font-bold text-gray-800 dark:text-white truncate">${repo.name}</h3>
                ${repo.isArchived ? '<span class="inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium bg-yellow-100 dark:bg-yellow-900 text-yellow-800 dark:text-yellow-100">Archived</span>' : ''}
            </div>
            
            <p class="text-gray-600 dark:text-gray-300 mb-4 h-12 line-clamp-2">${repo.description || 'No description provided'}</p>
            
            <div class="flex flex-wrap items-center text-sm text-gray-500 dark:text-gray-400 mb-4 gap-2">
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
                <div class="code-block group">
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
                <div class="code-block group">
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
                <div class="code-block group">
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

// Initialize the page
document.addEventListener('DOMContentLoaded', async () => {
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
