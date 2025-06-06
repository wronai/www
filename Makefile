.PHONY: install dev build analyze deploy clean setup-token token-page

# Configuration
GITHUB_ORG ?= wronai
GITHUB_TOKEN ?= $(shell [ -f .env ] && grep -E '^GITHUB_TOKEN=' .env | cut -d '=' -f2- || echo "")
NODE_ENV ?= development
PORT ?= 3000

# Directories
SRC_DIR = src
DIST_DIR = dist
SCRIPTS_DIR = scripts
ANALYZER_DIR = repo-analyzer
DATA_DIR = data

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
	@echo "${YELLOW}Starting development server on port ${PORT}...${RESET}"
	@echo "${BLUE}Open http://localhost:${PORT} in your browser${RESET}"
	@npm run dev

## Build for production
build: check-env
	@echo "${YELLOW}Building for production...${RESET}"
	@rm -rf ${DIST_DIR}
	@npm run build
	@echo "${GREEN}✓ Production build complete in ${DIST_DIR}${RESET}"

## Build for GitHub Pages
build-gh-pages: check-env
	@echo "${YELLOW}Building for GitHub Pages...${RESET}"
	@rm -rf ${DIST_DIR}
	@echo "${BLUE}Setting base URL for GitHub Pages...${RESET}"
	@echo 'window.BASE_URL = "/www";' > ${SRC_DIR}/config.js
	@npm run build
	@echo "${GREEN}✓ GitHub Pages build complete in ${DIST_DIR}${RESET}"

## Setup GitHub token
setup-token:
	@./setup_github_token.sh

## Open GitHub token page with required scopes
token-page:
	@./scripts/open-token-page.sh

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
	@mkdir -p ${DATA_DIR}
	@if [ ! -f "${ANALYZER_DIR}/analyze_repo.py" ]; then \
		echo "${YELLOW}Repository analyzer not found.${RESET}"; \
		exit 1; \
	fi
	@docker build -t repo-analyzer ${ANALYZER_DIR}
	@docker run --rm \
		-e "GITHUB_TOKEN=${GITHUB_TOKEN}" \
		-e "GITHUB_ORG=${GITHUB_ORG}" \
		-v "$(PWD)/${DATA_DIR}:/data" \
		repo-analyzer python /app/analyze_repo.py
	@echo "${GREEN}✓ Repository analysis complete${RESET}"

## Deploy to GitHub Pages
deploy: build-gh-pages
	@echo "${YELLOW}Deploying to GitHub Pages...${RESET}"
	@if [ -d ".git" ]; then \
		echo "${BLUE}Committing changes...${RESET}"; \
		git add -A; \
		git commit -m "Deploy to GitHub Pages" || true; \
		echo "${BLUE}Pushing to GitHub...${RESET}"; \
		git push origin main; \
		echo "${GREEN}✓ Deployment complete!${RESET} Visit https://wronai.github.io/www"; \
	else \
		echo "${YELLOW}Not a git repository. Please commit and push changes manually.${RESET}"; \
	fi

## Clean build artifacts
clean:
	@echo "${YELLOW}Cleaning up...${RESET}"
	@rm -rf ${DIST_DIR}
	@rm -rf node_modules
	@rm -f ${DATA_DIR}/repos_updated.json
	@echo "${GREEN}✓ Clean complete${RESET}"

.DEFAULT_GOAL := help
