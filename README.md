# VisionHub


Setup and Development Workflow
To easily set up your environment and get started with VisionHub, you can use the Makefile commands to handle the setup process. This file automates various tasks like database creation, migrations, and starting the application.

Requirements
Docker and Docker Compose: Ensure that Docker and Docker Compose are installed on your machine.
Elixir: The application is built with Elixir, so you need Elixir and Erlang installed as well.
Setup Steps
Clone the Repository:

```bash
git clone https://github.com/your-username/visionhub.git
cd visionhub
```
Run the setup Command:

The setup target automates the process of setting up your Docker containers, initializing the database, running migrations, and starting the Phoenix server. Simply run:

```bash
make setup
```
This command does the following:

Spins up the Docker containers (including PostgreSQL).
Waits for the PostgreSQL database to initialize.
Creates the database (ecto.create).
Applies database migrations (ecto.migrate).
Seeds the database with initial data (run priv/repo/seeds.exs).
Starts the Phoenix server.
After running this command, your app should be up and running on http://localhost:4000.

Other Useful Commands
make up: Start the Docker containers in the background.

```bash
make up
```
make server: Start the Phoenix server manually (if you prefer not to use setup).

```bash
make db: Starts only the Docker containers related to the database.
```

```bash
make down: Shut down and remove the Docker containers.
```

```bash
make logs: Tail the Docker logs for all running containers.
```

```bash
make clean: Stop and remove the Docker containers and volumes, effectively cleaning up the environment.
```

Troubleshooting
If you run into any issues while setting up the environment, here are some tips:

Ensure Docker is running and that your system meets all prerequisites.
Check Docker container logs using make logs to see any errors.
Make sure the Elixir dependencies are installed via mix deps.get.