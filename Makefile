.PHONY: install dev build preview clean

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
	@rm -rf ${DIST_DIR}
	@echo "${GREEN}✓ Clean complete${RESET}"
