# Makefile for managing the VNC Jumper environment

.PHONY: all up down logs test clean

# Default command
all: up

# Bring up the services in detached mode
up:
	@echo "Starting VNC Jumper and Airflow services..."
	@docker-compose up -d

# Bring down the services
down:
	@echo "Stopping VNC Jumper and Airflow services..."
	@docker-compose down

# Follow logs of all services
logs:
	@echo "Following logs..."
	@docker-compose logs -f

# Run the test script
test:
	@echo "Running tests..."
	@./test.sh

# Stop services and remove all volumes
clean:
	@echo "Stopping services and removing all volumes..."
	@docker-compose down -v --remove-orphans

help:
	@echo "Available commands:"
	@echo "  make up     - Start all services in the background."
	@echo "  make down   - Stop all services."
	@echo "  make logs   - View logs from all services."
	@echo "  make test   - Run a simple test to check if services are up."
	@echo "  make clean  - Stop all services and remove data volumes."
