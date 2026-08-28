# 2. Development Bind Mount and Helper Scripts

* Status: Accepted
* Date: 2026-08-28

## Context
Running long Docker Compose commands frequently increases typing friction during development. Additionally, changes made on the host machine must sync seamlessly with the container filesystem in real time.

## Decision
1. **Bind Mount:** Configured a host-to-container volume mapping (`.:/rails`) in `compose.yaml` for the development service.
2. **Helper Scripts:** Created executable wrapper scripts in `bin/`:
   - `bin/dev`: Starts `docker compose up`.
   - `bin/run`: Wraps `docker compose run --rm api <command>`.

## Consequences
- Live code changes on the host instantly take effect inside the container.
- Developer command-line experience is simplified while maintaining Docker isolation.