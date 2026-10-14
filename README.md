# Personal Hub API

A modular Ruby on Rails REST API serving as the backend engine for personal life tracking modules. The API is built with a Docker-first approach and designed for scalability, maintainability, and seamless integration with modern frontend applications.

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

### Getting Started

1. **Clone the repository:**
   ```bash
   git clone https://github.com/markin/personal-hub-api.git
   cd personal-hub-api
   ```

2. **Build the Docker image:**
   ```bash
   docker compose build
   ```
   This builds the development Docker image with Ruby, Rails, and all dependencies. Run this once after cloning or when dependencies change.

3. **Start the development environment:**
   ```bash
   bin/dev
   ```
   This command starts PostgreSQL, Rails server, and other services defined in `compose.yaml`. The Rails app runs at `http://localhost:3000`.

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

## Support

For questions or issues, refer to:
- [AGENTS.md](AGENTS.md) for development conventions
- [docs/decisions/](docs/decisions/) for architectural context
- GitHub Issues for bug reports and feature requests
