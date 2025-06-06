.PHONY: install dev build preview clean test-gh-actions setup-dev

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
WHITE  := $(shell tput -Txterm setaf 7)
RESET  := $(shell tput -Txterm sgr0)

## Help
help:
	@echo ''
	@echo 'Usage:'
	@echo '  ${YELLOW}make${RESET} ${GREEN}<target>${RESET}'
	@echo ''
	@echo 'Targets:'
	@echo '  ${GREEN}install${RESET}    Install dependencies'
	@echo '  ${GREEN}dev${RESET}        Start development server'
	@echo '  ${GREEN}build${RESET}      Build for production'
	@echo '  ${GREEN}preview${RESET}    Preview production build locally'
	@echo '  ${GREEN}clean${RESET}      Clean build artifacts'

## Install dependencies
install:
	@echo "${YELLOW}Installing dependencies...${RESET}"
	@npm install
	@echo "${GREEN}✓ Dependencies installed${RESET}"

## Start development server
dev:
	@echo "${YELLOW}Starting development server on port ${PORT}...${RESET}"
	@echo "${BLUE}Open http://localhost:${PORT} in your browser${RESET}"
	@cp -n repos.json ${SRC_DIR}/repos.json 2>/dev/null || true
	@npx serve -s ${SRC_DIR} -l ${PORT} --cors --no-clipboard

## Build for production
build:
	@echo "${YELLOW}Building for production...${RESET}"
	@npm run build
	@echo "${GREEN}✓ Build complete${RESET}"

## Preview production build locally
preview:
	@echo "${YELLOW}Starting production server on port ${PORT}...${RESET}"
	@echo "${BLUE}Open http://localhost:${PORT} in your browser${RESET}"
	@npx serve -s ${DIST_DIR} -l ${PORT} --cors --no-clipboard

## Clean build artifacts
clean:
	@echo "${YELLOW}Cleaning build artifacts...${RESET}"
	@rm -rf ${DIST_DIR} .act
	@echo "${GREEN}✓ Clean complete${RESET}"

## Set up development environment
setup-dev:
	@echo "${YELLOW}Setting up development environment...${RESET}"
	@npm install -g @nektos/act
	@echo "${GREEN}✓ Development tools installed${RESET}"

## Test GitHub Actions locally
test-gh-actions:
	@echo "${YELLOW}Testing GitHub Actions locally...${RESET}"
	@echo "${BLUE}Note: Docker must be installed and running${RESET}"
	@if ! command -v act &> /dev/null; then \
		echo "${YELLOW}act not found. Installing with npm...${RESET}"; \
		npm install -g @nektos/act; \
	fi
	@echo "${BLUE}Running GitHub Actions locally...${RESET}"
	@act -P ubuntu-latest=ghcr.io/catthehacker/ubuntu:act-latest

## Create required directories and files for local testing
setup-test-env:
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
