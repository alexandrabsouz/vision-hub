DOCKER_COMPOSE = docker-compose

APP_SERVICE = app
DB_SERVICE = db

MIX_CMD = docker-compose exec $(APP_SERVICE) mix

setup:
	$(DOCKER_COMPOSE) up -d $(DB_SERVICE)
	@echo "Esperando o PostgreSQL iniciar..."
	sleep 5
	$(MIX_CMD) ecto.create
	$(MIX_CMD) ecto.migrate
	@echo "Banco de dados criado e migrações aplicadas."

up:
	$(DOCKER_COMPOSE) up -d

server:
	$(DOCKER_COMPOSE) exec $(APP_SERVICE) mix phx.server

db:
	$(DOCKER_COMPOSE) up -d $(DB_SERVICE)

down:
	$(DOCKER_COMPOSE) down

logs:
	$(DOCKER_COMPOSE) logs -f

clean:
	$(DOCKER_COMPOSE) down -v
