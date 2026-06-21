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

The `tests/` directory does not exist in the scaffold — students create it as part of the project.

## Architecture

**Flask + SQLite, no ORM.** All routes live in `app.py`. The database layer (`database/db.py`) is intentionally left empty for students to implement.

### `database/db.py` contract

Three functions are expected:

| Function | Responsibility |
|---|---|
| `get_db()` | Returns a `sqlite3.Connection` with `row_factory = sqlite3.Row` and `PRAGMA foreign_keys = ON` |
| `init_db()` | Creates tables with `CREATE TABLE IF NOT EXISTS` |
| `seed_db()` | Inserts sample rows for development |

The database file is `expense_tracker.db` (gitignored, created at runtime).

### `app.py` route stubs

Placeholder routes return strings; students replace them step by step.

### Templates

All templates extend `base.html` via Jinja2 blocks: `title`, `head`, `content`, `scripts`. The nav in `base.html` is hardcoded for the logged-out state — it needs a `session` conditional once auth is added. The `register.html` and `login.html` templates already render an `{{ error }}` variable; pass it via `render_template('register.html', error=msg)`.

## Step sequence (student project)

Steps 1–9 build the app incrementally:
1. Database setup (`database/db.py`)
2. Registration
3. Login / logout (Flask session)
4. Profile page
5–6. Expense listing and filtering
7. Add expense
8. Edit expense
9. Delete expense

## SSH / Git

Two GitHub accounts via SSH host aliases in `~/.ssh/config`:
- Personal (`ajha264538`): `git@ajha_github:aniket264538/<repo>.git`
- Work (Prolifics): `git@ajha_prolifics_github:<org>/<repo>.git`
