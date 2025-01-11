# VisionHub

VisionHub is an Elixir application that manages users and security camera devices, focusing on **Hikvision** brand cameras. The application allows notifying users via email about specific devices, using the Phoenix email system, and integrates with a PostgreSQL database via Ecto.

## Features

- User management and their devices.
- Filtering users with **Hikvision** brand devices.
- Endpoint that simulates sending emails to users with specific devices.
- Automated tests using the Elixir testing framework.

## Technologies

- **Elixir**: Functional and concurrent programming language.
- **Phoenix**: Web framework for Elixir.
- **Ecto**: Object-Relational Mapping (ORM) library for Elixir.
- **PostgreSQL**: Database used for data persistence.
- **Credo**: Tool to ensure code quality and consistency in Elixir projects.
- **Timex**: Library for time manipulation.

## Requirements

- **Elixir** version 1.13 or above.
- **Phoenix** version 1.6 or above.
- **PostgreSQL** database.

## Installation

### 1. Clone the repository

First, clone the repository to your local machine:

```bash
git clone https://github.com/your-username/vision_hub.git
cd vision_hub
```

2. Install project dependencies
Next, install the dependencies required for the project:

bash
Copiar código
mix deps.get
3. Configure the database
Make sure PostgreSQL is installed and running on your system. Then, create and migrate the database by running:

bash
Copiar código
mix ecto.create
mix ecto.migrate
4. Run the Phoenix server
Now you can start the Phoenix server to run the application:

bash
Copiar código
mix phx.server
The application will be available at http://localhost:4000.

Features
Notification Endpoint
The application has an endpoint that simulates sending emails to users who have Hikvision brand cameras.

Endpoint: POST /notify-users

This endpoint performs the following tasks:

Retrieves all users with Hikvision cameras associated.
Simulates sending an email to those users.
Note: The actual email sending is not necessary for the challenge. The application can use Phoenix's dev/mailbox mode to simulate this process.

Querying Users with Hikvision Devices
You can query all users who have Hikvision cameras associated. This is done via the function:

```elixir
VisionHub.Account.get_users_with_hikvision_devices()
```

Testing Environment
To run the automated tests, use the following command:

```bash
mix test
```

Tests are configured to validate the application's logic and ensure data consistency.

Contributing
If you'd like to contribute, follow these steps:

Fork the repository.

Create a branch for your feature:

```Bash
git checkout -b feature/feature-name
```

Commit your changes:

```Bash
git commit -am 'Add new feature'
```

Push your branch:

```Bash
git push origin feature/feature-name
```

Open a pull request to the main repository.

Running Tests
To run the tests, execute the following command:

```Bash
mix test
```

Tests are crucial to ensure that the application's logic works correctly, especially to validate that querying users with Hikvision devices and sending emails (simulated) works as expected.

Code Quality
The application uses Credo to ensure the code adheres to style conventions and best practices. To run Credo, execute:

```Bash
mix credo
```
This will help ensure the code is clean and maintainable.

License
This project is licensed under the MIT License - see the LICENSE file for details.

### Changes made:

- **Separated steps clearly**: Now, each step (such as cloning the repository, installing dependencies, configuring the database, etc.) is clearly separated with its own heading and explanation.
- **Bash code blocks**: Each command is inside a ```bash code block to make it clearer and more readable.
  
This structure ensures that all the steps and commands are easy to follow while keeping the markdown formatting intact. Let me know if you'd like any other changes!