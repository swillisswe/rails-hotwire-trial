# Photo Gallery

A Rails + Hotwire photo gallery app with session-based authentication and real-time like/unlike updates via Turbo Streams.

## Tech Stack

- Ruby 3.3
- Rails 8.1
- SQLite3
- Hotwire (Turbo Streams)
- Propshaft + Importmap
- RSpec + FactoryBot

## Setup

```bash
bundle install
rails db:setup       # creates, migrates, and seeds the database
rails server
```

Open http://localhost:3000

## Seed Credentials

```
Email:    user@example.com
Password: password
```

## Running Specs

```bash
bundle exec rspec
```

## Architecture Notes

**Authentication** — Custom session-based auth using `has_secure_password`. `ApplicationController#require_login` guards all routes and sets `Cache-Control: no-store` on authenticated responses to prevent browser bfcache from showing stale pages after sign-out.

**Like/Unlike** — `LikesController` handles `POST /photos/:photo_id/like` and `DELETE /photos/:photo_id/like`. Each action responds with a Turbo Stream that replaces only the like button area (`dom_id(@photo, :like)`) in place — no full page reload. Falls back to redirect for non-Turbo requests.

**User-scoped likes** — Operations are scoped to `current_user` (`current_user.likes.find_or_create_by!`, `current_user.likes.find_by!`) to prevent cross-user manipulation without explicit record lookup.

**N+1 prevention** — `PhotosController` loads `Photo.includes(:likes)`. `Photo#liked_by?` checks `likes.loaded?` and uses the preloaded collection when available, falling back to a targeted DB query otherwise.

## Design Choices

- Turbo Streams were used instead of custom JavaScript for server-rendered UI updates and simpler state management.
- Photo rendering uses partials and targeted Turbo Stream replacement to keep updates isolated and maintainable.

## UI Notes

- Responsive card grid layout designed to work across desktop and mobile screen sizes.
