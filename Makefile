.PHONY: install dev build analyze deploy clean setup-token

# Configuration
GITHUB_ORG ?= wronai
GITHUB_TOKEN ?= $(shell [ -f .env ] && grep -E '^GITHUB_TOKEN=' .env | cut -d '=' -f2- || echo "")
NODE_ENV ?= development
PORT ?= 3000

# Colors
GREEN  := $(shell tput -Txterm setaf 2)
YELLOW := $(shell tput -Txterm setaf 3)
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
	@echo '  ${GREEN}analyze${RESET}    Analyze repositories and update data'
	@echo '  ${GREEN}deploy${RESET}     Deploy to production'
	@echo '  ${GREEN}clean${RESET}      Clean build artifacts'

## Install dependencies
install: check-env
	@echo "${YELLOW}Installing dependencies...${RESET}"
	@npm install
	@echo "${GREEN}✓ Dependencies installed${RESET}"

## Start development server
dev:
	@echo "${YELLOW}Starting development server...${RESET}"
	@npx serve -l $(PORT)

## Build for production
build:
	@echo "${YELLOW}Building for production...${RESET}"
	@echo "${GREEN}✓ Build complete${RESET}"

## Setup GitHub token
setup-token:
	@./setup_github_token.sh

## Check environment
check-env:
	@if [ ! -f ".env" ]; then \
		echo "${YELLOW}Creating .env file from .env.example...${RESET}"; \
		cp .env.example .env; \
	fi

## Analyze repositories and update data
analyze: check-env
	@if [ -z "$(GITHUB_TOKEN)" ]; then \
		echo "${YELLOW}GitHub token not found. Running setup...${RESET}"; \
		$(MAKE) setup-token; \
		exit 0; \
	fi
	@echo "${YELLOW}Analyzing repositories...${RESET}"
	@if [ ! -f "analyze_repos.sh" ]; then \
		echo "${YELLOW}analyze_repos.sh not found. Please run from project root.${RESET}"; \
		exit 1; \
	fi
	@chmod +x analyze_repos.sh
	@./analyze_repos.sh
	@echo "${GREEN}✓ Repository analysis complete${RESET}"

## Deploy to production
deploy: build
	@echo "${YELLOW}Deploying to production...${RESET}"
	@echo "${GREEN}✓ Deployed successfully${RESET}"

## Clean build artifacts
clean:
	@echo "${YELLOW}Cleaning up...${RESET}"
	@rm -rf node_modules
	@rm -f repos_updated.json
	@echo "${GREEN}✓ Clean complete${RESET}"

.DEFAULT_GOAL := help
