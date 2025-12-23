# Secure VNC Jumper for Airflow

This project sets up a secure VNC jumper environment using Docker and KasmVNC. The jumper provides browser-based access to an Apache Airflow web console with significant security restrictions in place.

## Features

- **VNC Jumper**: A `kasmweb/chrome` container that acts as a secure jump host.
- **Target Application**: An Apache Airflow instance running in Docker.
- **Security Hardening**: The jumper is configured to disable:
  - File Uploads
  - File Downloads
  - Clipboard (Copy/Paste)
  - Printing
  - Microphone Access
  - Webcam Access
- **Orchestration**: Managed via `docker-compose` and a `Makefile`.

## Prerequisites

- Docker
- Docker Compose

## File Structure

```
.
├── dags/
│   └── example_dag.py      # Example Airflow DAG
├── .env                    # Environment variables for Airflow (auto-generated)
├── docker-compose.yml      # Defines all services (jumper, airflow, postgres)
├── Makefile                # Provides easy commands (up, down, test, etc.)
└── test.sh                 # A script to test if the services are running
```

## How to Use

### 1. Start the Environment

To build and start all services (jumper and airflow) in the background, run:

```sh
make up
```

The first time you run this, it will download the necessary Docker images, which may take a few minutes. Airflow will also need a minute to initialize its database.

### 2. Access the Secure Jumper

- Open your web browser and navigate to: **http://localhost:6901**
- You will be prompted for a password. The default password is: `password`

Upon successful login, the Airflow web UI will automatically load inside the secure browser session.

### 3. Access Airflow Directly (for comparison)

You can also access the Airflow UI directly on **http://localhost:8080**. The default login is `admin` / `admin`. This is useful for verifying that Airflow is running correctly, but in a real-world scenario, you would not expose this port to the user.

### 4. Test the Environment

To run a quick check to ensure the services are up and running, use:

```sh
make test
```

This script will also provide you with manual steps to verify that the security restrictions (like disabled clipboard) are working as expected.

### 5. View Logs

To see the logs from all running containers:

```sh
make logs
```

### 6. Stop the Environment

To stop all the running services:

```sh
make down
```

### 7. Clean Up

To stop the services and **delete all associated data** (including the Postgres database volume), run:

```sh
make clean
```
