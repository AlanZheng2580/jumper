# Makefile for managing the VNC Jumper environment

.PHONY: help
help:  ## Show all availble commands
	@grep -h -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
	awk 'BEGIN {FS = ":.*?## "}; {printf "🛠  \033[36m%-22s\033[0m %s\n", $$1, $$2}'

up: ## Start all services in the background.
	@echo "Starting VNC Jumper and Airflow services..."
	@docker-compose up -d

down: ## Stop all services.
	@echo "Stopping VNC Jumper and Airflow services..."
	@docker-compose down

restart: ## Restart the jumper service.
	@echo "Restarting VNC Jumper..."
	@docker-compose restart jumper

logs: ## View logs from all services.
	@echo "Following logs..."
	@docker-compose logs -f

test: ## Run a simple test to check if services are up.
	@echo "Running tests..."
	@./test.sh

clean: ## Stop all services and remove data volumes.
	@echo "Stopping services and removing all volumes..."
	@docker-compose down -v --remove-orphans
