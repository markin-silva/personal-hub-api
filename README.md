# Personal Hub API

A modular Ruby on Rails REST API serving as the backend engine for personal life tracking modules. The API is built with a Docker-first approach and designed for scalability, maintainability, and seamless integration with modern frontend applications.

**Current Focus:** Workout Module — tracking exercises, workout plans, and session execution.

## Tech Stack

| Component | Version |
|-----------|---------|
| Ruby | 3.4.10 |
| Rails | 8.1.3 (API Mode) |
| PostgreSQL | 17.10 |
| Authentication | Devise + `devise-jwt` (Stateless Bearer Tokens) |
| Testing | RSpec + RuboCop (`rubocop-rails-omakase`) |
| Container Runtime | Docker + Docker Compose |

## Architecture

- **API-First Design:** All endpoints namespaced under `/api/v1` following REST conventions.
- **Authentication:** JWT-based stateless authentication via Bearer tokens in the `Authorization` header.
- **Docker-First:** Local development, testing, and CI/CD all run in containerized environments. No requirement for local Ruby or PostgreSQL installation.
- **Modular Structure:** Rails generators and conventions keep code organized by feature modules (exercises, workouts, users, etc.).

## Local Development

### Prerequisites

- Docker & Docker Compose
- Git
- (Optional) VS Code with Remote - Containers extension

### Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/markin/personal-hub-api.git
   cd personal-hub-api
   ```

2. **Start the development environment:**
   ```bash
   bin/dev
   ```
   This command starts PostgreSQL, Rails server, and other services defined in `compose.yaml`. The Rails app runs at `http://localhost:3000`.

3. **Verify the API is running:**
   ```bash
   curl http://localhost:3000/api/v1/health
   ```

### Common Development Tasks

#### Run Database Migrations & Seeds
```bash
bin/run bin/rails db:prepare db:seed
```

#### Run the Test Suite
```bash
bin/run bundle exec rspec
```

#### Run the Linter
```bash
bin/run bundle exec rubocop
```

#### Execute Other Rails Commands
```bash
bin/run bin/rails generate model User email:string
bin/run bin/rails console
```

## API Endpoints

All endpoints are versioned under `/api/v1`. The API uses JWT Bearer token authentication (except for registration and login).

### Health & System

- **`GET /api/v1/health`**  
  Returns system status and PostgreSQL connectivity.

### Authentication

- **`POST /api/v1/users`**  
  Register a new user. Returns JWT token in `Authorization` header response.
  ```json
  {
    "user": {
      "email": "user@example.com",
      "password": "secure_password"
    }
  }
  ```

- **`POST /api/v1/users/sign_in`**  
  User login. Returns JWT Bearer token in `Authorization` header.
  ```json
  {
    "user": {
      "email": "user@example.com",
      "password": "secure_password"
    }
  }
  ```

- **`DELETE /api/v1/users/sign_out`**  
  Revoke the current session (logout).

### Workout Module

- **`GET /api/v1/exercises`**  
  Fetch all exercises (global catalog and user-custom).

- **`POST /api/v1/exercises`**  
  Create a custom exercise.

- **`GET /api/v1/workout_plans`**  
  Fetch all workout plans.

- **`POST /api/v1/workout_plans`**  
  Create a new workout plan.

- **`GET /api/v1/workout_sessions`**  
  Fetch all workout session history.

- **`POST /api/v1/workout_sessions`**  
  Log a new workout session execution.

## Production Deployment

### Deployment Platform

The API is designed for deployment on **Render** with **Neon PostgreSQL**.

### Environment Variables

The following environment variables must be set in your Render Web Service:

| Variable | Description | Example |
|----------|-------------|---------|
| `DATABASE_URL` | Neon PostgreSQL connection string (with SSL) | `postgresql://user:pass@host/db?sslmode=require` |
| `RAILS_ENV` | Environment mode | `production` |
| `RAILS_MASTER_KEY` | Credentials encryption key | (generated locally, set in Render secrets) |
| `FRONTEND_URL` | Production frontend domain for CORS | `https://personal-hub.example.com` |
| `PORT` | Server port (default: 3000) | `3000` |

### Deployment Steps

1. **Create a Render Web Service:**
   - Connect your GitHub repository.
   - Set Runtime: Docker.
   - Configure Environment Variables (see table above).

2. **Configure Neon PostgreSQL:**
   - Create a Neon project and database.
   - Copy the connection string to `DATABASE_URL`.

3. **Deployment Behavior:**
   - The Docker entrypoint automatically runs database migrations (`db:prepare`) and seeds on startup.
   - HTTPS is enforced; SSL redirect excludes the health check endpoint (`/up`).
   - CORS is configured to accept requests from `FRONTEND_URL`.

4. **Verify Deployment:**
   ```bash
   curl https://your-api.onrender.com/api/v1/health
   ```

## Repository Guidelines

### Key Documentation

- **[AGENTS.md](AGENTS.md)** — Instructions and conventions for AI-assisted development.
- **[CHANGELOG.md](CHANGELOG.md)** — Release notes and notable changes per version.
- **[docs/decisions/](docs/decisions/)** — Architecture Decision Records (ADRs) documenting key technical choices.

### Commit Conventions

This project follows [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add user registration endpoint
fix: correct CORS header configuration
chore: update dependencies
docs: add deployment guide
```

## Testing

All code changes require tests and must pass the linter:

```bash
# Run full test suite
bin/run bundle exec rspec

# Run tests for a specific file
bin/run bundle exec rspec spec/controllers/api/v1/users_controller_spec.rb

# Run with coverage
bin/run bundle exec rspec --format progress --format RcovFormatter

# Run linter
bin/run bundle exec rubocop

# Auto-fix linter violations
bin/run bundle exec rubocop -A
```

## Development Workflow

1. **Create a feature branch:** `git checkout -b feat/new-feature`
2. **Write code and tests.**
3. **Run the test suite and linter:** `bin/run bundle exec rspec && bin/run bundle exec rubocop -A`
4. **Commit with Conventional Commits:** `git commit -m "feat: add new feature"`
5. **Push and open a Pull Request.**

## Troubleshooting

### Database Connection Issues

If the app can't connect to PostgreSQL:
```bash
bin/run bin/rails db:drop db:create db:migrate
```

### Container Port Already in Use

If port 3000 is occupied:
```bash
docker-compose -f compose.yaml down
docker ps  # verify all containers are stopped
bin/dev   # restart
```

### Clear Docker Cache

To rebuild containers from scratch:
```bash
docker-compose -f compose.yaml down -v
bin/dev
```

## License

(Add your license here if applicable.)

## Support

For questions or issues, refer to:
- [AGENTS.md](AGENTS.md) for development conventions
- [docs/decisions/](docs/decisions/) for architectural context
- GitHub Issues for bug reports and feature requests
