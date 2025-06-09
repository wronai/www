# Configuration
NODE_ENV ?= development
PORT ?= 3000

# Directories
SRC_DIR = src
DIST_DIR = dist

# Colors
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
BLUE   := $(shell tput -Txterm setaf 4)
RED    := $(shell tput -Txterm setaf 1)
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

# Help target
.PHONY: help
help:  ## Show this help
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*?##/ { printf "  ${GREEN}%-20s${RESET} %s\n", $$1, $$2 } /^##@/ { printf "\n${WHITE}%s${RESET}\n", substr($$0, 5) } ' $(MAKEFILE_LIST)

##@ Development

.PHONY: install
i install:  ## Install dependencies
	@echo "${YELLOW}Installing dependencies...${RESET}"
	@npm install
	@echo "${GREEN}✓ Dependencies installed${RESET}"

.PHONY: dev
dev:  ## Start development server
	@echo "${YELLOW}Starting development server on port ${PORT}...${RESET}"
	@echo "${BLUE}Open http://localhost:${PORT} in your browser${RESET}"
	@cp -n repos.json ${SRC_DIR}/repos.json 2>/dev/null || true
	@npx serve -s ${SRC_DIR} -l ${PORT} --cors --no-clipboard

.PHONY: build
build:  ## Build for production
	@echo "${YELLOW}Building for production...${RESET}"
	@npm run build
	@echo "${GREEN}✓ Build complete${RESET}"

.PHONY: preview
preview: build  ## Preview production build locally
	@echo "${YELLOW}Starting production server on port ${PORT}...${RESET}"
	@echo "${BLUE}Open http://localhost:${PORT} in your browser${RESET}"
	@npx serve -s ${DIST_DIR} -l ${PORT} --cors --no-clipboard

.PHONY: clean
clean:  ## Clean build artifacts
	@echo "${YELLOW}Cleaning build artifacts...${RESET}"
	@rm -rf ${DIST_DIR} .act
	@echo "${GREEN}✓ Clean complete${RESET}"

##@ Repository Management

.PHONY: update-repos
update-repos:  ## Update repository data
	@echo "${YELLOW}Updating repository data...${RESET}"
	@if [ ! -f "update_repos.py" ]; then \
		echo "${RED}Error: update_repos.py not found in the root directory${RESET}"; \
		exit 1; \
	fi
	@if command -v python3 &> /dev/null; then \
		python3 update_repos.py; \
	else \
		echo "${YELLOW}Python 3 is required to update repository data${RESET}"; \
		exit 1; \
	fi
	cp repos.json src/repos.json
	@echo "${GREEN}✓ Repository data updated${RESET}"

##@ Development Setup

.PHONY: setup-dev
setup-dev:  ## Set up development environment
	@echo "${YELLOW}Setting up development environment...${RESET}"
	@npm install -g @nektos/act
	@echo "${GREEN}✓ Development tools installed${RESET}"

.PHONY: setup-test-env
setup-test-env:  ## Set up test environment
	@echo "${YELLOW}Setting up test environment...${RESET}"
	@mkdir -p data
	@if [ ! -f "repos.json" ]; then \
		echo '{"repositories": []}' > repos.json; \
		echo "${GREEN}✓ Created empty repos.json${RESET}"; \
	else \
		echo "${GREEN}✓ repos.json already exists${RESET}"; \
	fi
	@if [ ! -f ".env" ]; then \
		echo "GITHUB_TOKEN=test-token" > .env; \
		echo "${YELLOW}✓ Created .env with test token${RESET}"; \
	else \
		echo "${GREEN}✓ .env already exists${RESET}"; \
	fi
	@echo "${GREEN}✓ Test environment ready${RESET}"

##@ Testing

.PHONY: test-gh-actions
test-gh-actions:  ## Test GitHub Actions locally
	@echo "${YELLOW}Testing GitHub Actions locally...${RESET}"
	@echo "${BLUE}Note: Docker must be installed and running${RESET}"
	@if ! command -v act &> /dev/null; then \
		echo "${YELLOW}act not found. Installing...${RESET}"; \
		echo "${YELLOW}Please install act using one of these methods:${RESET}"; \
		echo "1. Using Homebrew (Linux/macOS): brew install act"; \
		echo "2. Using Chocolatey (Windows): choco install act-cli"; \
		echo "3. Using Pacman (Arch Linux): sudo pacman -S act"; \
		echo "4. From source: https://github.com/nektos/act#installation"; \
		exit 1; \
	fi
	@echo "${BLUE}Running GitHub Actions locally...${RESET}"
	@act -P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest

##@ Documentation

.PHONY: docs
docs:  ## Generate documentation
	@echo "${YELLOW}Generating documentation...${RESET}"
	@# Add documentation generation commands here
	@echo "${GREEN}✓ Documentation generated${RESET}"
