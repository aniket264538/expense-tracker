# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Starting the app

```powershell
PowerShell -ExecutionPolicy Bypass -File start.ps1
```

Activates the venv at `venv/` and runs Flask on http://localhost:5001 in debug mode. If the venv is missing: `python -m venv venv && .\venv\Scripts\pip install -r requirements.txt`.

## Running tests

```powershell
.\venv\Scripts\python.exe -m pytest
.\venv\Scripts\python.exe -m pytest tests/test_auth.py   # single file
```

## Architecture

**Flask + SQLite, no ORM.** All routes live in `app.py`. The database layer (`database/db.py`) is intentionally left empty for students to implement.

### `database/db.py` contract

Three functions are expected:

| Function | Responsibility |
|---|---|
| `get_db()` | Returns a `sqlite3.Connection` with `row_factory = sqlite3.Row` and `PRAGMA foreign_keys = ON` |
| `init_db()` | Creates tables with `CREATE TABLE IF NOT EXISTS` |
| `seed_db()` | Inserts sample rows for development |

Expected schema:
```sql
CREATE TABLE IF NOT EXISTS users (
    id            INTEGER PRIMARY KEY AUTOINCREMENT,
    name          TEXT    NOT NULL,
    email         TEXT    NOT NULL UNIQUE,
    password_hash TEXT    NOT NULL
);

CREATE TABLE IF NOT EXISTS expenses (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id     INTEGER NOT NULL REFERENCES users(id),
    amount      REAL    NOT NULL,
    category    TEXT    NOT NULL,
    description TEXT,
    date        TEXT    NOT NULL  -- stored as YYYY-MM-DD
);
```

The database file is `expense_tracker.db` (gitignored, created at runtime).

### `app.py` route stubs

Placeholder routes return strings; students replace them step by step. When adding form handling, routes need `methods=['GET', 'POST']`. **`app.secret_key` must be set before Flask sessions work** (required for Step 3 login).

### Templates

All templates extend `base.html` via Jinja2 blocks: `title`, `head`, `content`, `scripts`. The nav in `base.html` is hardcoded for the logged-out state — it needs a `session` conditional once auth is added. The `register.html` and `login.html` templates already render an `{{ error }}` variable; pass it via `render_template('register.html', error=msg)`. Password hashing should use `werkzeug.security` (`generate_password_hash` / `check_password_hash`), which is already installed as a Flask dependency.

## Step sequence (student project)

1. Database setup — implement `database/db.py`
2. Registration — POST `/register`, insert user with hashed password
3. Login / logout — POST `/login`, use `flask.session`, set `app.secret_key`
4. Profile page — `/profile` reads from session
5–6. Expense listing and filtering — query `expenses` joined to `users`
7. Add expense — POST `/expenses/add`
8. Edit expense — GET/POST `/expenses/<id>/edit`
9. Delete expense — POST `/expenses/<id>/delete`

## SSH / Git

Two GitHub accounts via SSH host aliases in `~/.ssh/config`:
- Personal (`ajha264538`): `git@ajha_github:aniket264538/<repo>.git`
- Work (Prolifics): `git@ajha_prolifics_github:<org>/<repo>.git`
