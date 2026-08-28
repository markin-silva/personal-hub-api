# Agent Guidelines — Personal Hub API

This document serves as persistent memory regarding conventions, architecture, and project decisions.

## Core Principles
- **Simplicity over abstraction:** Modular Rails monolith, avoiding overengineering.
- **Rails conventions:** Follow standard framework-first patterns. Avoid premature Service Objects, Repositories, or Interactors.
- **Docker-first:** Do not assume Ruby or PostgreSQL are installed on the host machine.
- **Commit Standards:** Use Conventional Commits in English (e.g., `feat:`, `fix:`, `chore:`, `docs:`).

## Tech Stack & Architecture
- **Ruby:** 3.4.10
- **Rails:** 8.1.3 (API Mode)
- **PostgreSQL:** 17.10
- **Testing:** RSpec (to be configured)

## Execution Patterns via Docker
All commands must run via Docker Compose:
- **Execute Rails CLI:** `docker compose run --rm api bin/rails [command]`
- **Start services in background:** `docker compose up -d db`

## Documentation Structure
- `CHANGELOG.md`: Tracks notable changes per release using Keep a Changelog conventions.
- `docs/decisions/`: ADR (Architecture Decision Record) files using the format `NNNN-short-title.md`.