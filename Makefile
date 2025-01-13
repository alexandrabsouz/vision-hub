DOCKER_COMPOSE = docker compose

MIX_CMD = mix

setup:
	$(DOCKER_COMPOSE) up -d 
	@echo "Esperando o PostgreSQL iniciar..."
	sleep 1
	$(MIX_CMD) deps.get
	$(MIX_CMD) ecto.create
	$(MIX_CMD) ecto.migrate
	$(MIX_CMD) run priv/repo/seeds.exs
	@echo "Banco de dados criado e migrações aplicadas."
	$(MIX_CMD) phx.server

up:
	$(DOCKER_COMPOSE) up -d 

server:
	$(MIX_CMD) phx.server

db:
	$(DOCKER_COMPOSE) up -d 

down:
	$(DOCKER_COMPOSE) down

logs:
	$(DOCKER_COMPOSE) logs -f

clean:
	$(DOCKER_COMPOSE) down -v
