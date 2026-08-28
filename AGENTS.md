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
- **Testing:** RSpec
- **API Architecture:** All application endpoints must be versioned under `Api::V1` namespace (`app/controllers/api/v1/`).

## Execution Patterns via Helper Scripts
Prefer using helper scripts from `bin/` instead of raw Docker commands:
- **Start local environment:** `bin/dev`
- **Execute Rails/Ruby commands:** `bin/run bin/rails [command]`
- **Run specs:** `bin/run bundle exec rspec`

## Documentation Structure
- `CHANGELOG.md`: Tracks notable changes per release using Keep a Changelog conventions.
- `docs/decisions/`: ADR (Architecture Decision Record) files using the format `NNNN-short-title.md`.