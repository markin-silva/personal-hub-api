# 3. Authentication with Devise and JWT

* Status: Accepted
* Date: 2026-08-28

## Context
The API requires user management and authentication to associate workouts and user-specific data.

## Decision
We adopt **Devise** combined with **`devise-jwt`**:
- Devise handles user creation, validations, and password hashing.
- `devise-jwt` manages authentication tokens returned in HTTP headers (`Authorization: Bearer <token>`).
- API mode configuration uses empty `navigational_formats` to strictly serve JSON responses.

## Consequences
- Standardized authentication flow for current React web client and future clients (e.g., React Native).
- User credentials and tokens follow production-tested security standards.