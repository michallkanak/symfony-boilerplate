# Makefile for Symfony Boilerplate

.PHONY: help build up down restart logs shell php-shell test phpstan clean install

## Colors
COLOR_RESET = \033[0m
COLOR_INFO = \033[32m
COLOR_COMMENT = \033[33m

## Help
help:
	@echo "${COLOR_COMMENT}Usage:${COLOR_RESET}"
	@echo " make [command]"
	@echo ""
	@echo "${COLOR_COMMENT}Available commands:${COLOR_RESET}"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf " ${COLOR_INFO}%-20s${COLOR_RESET} %s\n", $$1, $$2}'

## Docker Commands
build: ## Build Docker containers
	docker compose build --no-cache

up: ## Start Docker containers
	docker compose up -d

down: ## Stop Docker containers
	docker compose down

restart: down up ## Restart Docker containers

logs: ## Show Docker logs
	docker compose logs -f

ps: ## Show running containers
	docker compose ps

## Shell Access
shell: ## Access encore container shell (bash)
	docker exec -it sb-encore /bin/bash

php-shell: ## Access PHP container shell
	docker compose exec php-fpm bash

db-shell: ## Access PostgreSQL shell
	docker compose exec db psql -U postgres dbtest

## Application Commands
install: ## Fresh install (build, start, install dependencies)
	make build
	make up
	docker compose exec php-fpm composer install
	docker compose exec encore npm install
	docker compose exec encore npm run build
	docker compose exec php-fpm bin/console doctrine:migrations:migrate --no-interaction
	@echo "${COLOR_INFO}Installation complete!${COLOR_RESET}"

composer-install: ## Install PHP dependencies
	docker compose exec php-fpm composer install

composer-update: ## Update PHP dependencies
	docker compose exec php-fpm composer update

npm-install: ## Install npm dependencies
	docker compose exec encore npm install

npm-build: ## Build frontend assets
	docker compose exec encore npm run build

npm-watch: ## Watch and rebuild frontend assets
	docker compose exec encore npm run watch

## Database Commands
db-create: ## Create database
	docker compose exec php-fpm bin/console doctrine:database:create --if-not-exists

db-migrate: ## Run database migrations
	docker compose exec php-fpm bin/console doctrine:migrations:migrate --no-interaction

db-fixtures: ## Load fixtures
	docker compose exec php-fpm bin/console doctrine:fixtures:load --no-interaction

db-reset: ## Reset database (drop, create, migrate)
	docker compose exec php-fpm bin/console doctrine:database:drop --force --if-exists
	docker compose exec php-fpm bin/console doctrine:database:create
	docker compose exec php-fpm bin/console doctrine:migrations:migrate --no-interaction

## Testing & Quality
test: ## Run PHPUnit tests
	docker compose exec php-fpm vendor/bin/phpunit

test-coverage: ## Run tests with coverage
	docker compose exec php-fpm vendor/bin/phpunit --coverage-html var/coverage

phpstan: ## Run PHPStan analysis
	docker compose exec php-fpm vendor/bin/phpstan analyse

phpstan-baseline: ## Generate PHPStan baseline
	docker compose exec php-fpm vendor/bin/phpstan analyse --generate-baseline

cache-clear: ## Clear Symfony cache
	docker compose exec php-fpm bin/console cache:clear

## Cleanup
clean: ## Remove containers, volumes, and cache
	docker compose down -v
	rm -rf var/cache/* var/log/*
	@echo "${COLOR_INFO}Cleanup complete!${COLOR_RESET}"

clean-install: clean install ## Clean everything and fresh install
