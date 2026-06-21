# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Starting the app

```powershell
PowerShell -ExecutionPolicy Bypass -File start.ps1
```

This activates the venv at `venv/` and runs Flask on http://localhost:5001 in debug mode.

## Running tests

```powershell
.\venv\Scripts\python.exe -m pytest
```

Run a single test file:
```powershell
.\venv\Scripts\python.exe -m pytest tests/test_auth.py
```

## Architecture

**Flask + SQLite, no ORM.** The app uses raw SQLite via `database/db.py`, which students implement in Step 1. Three functions are expected there:
- `get_db()` — returns a connection with `row_factory = sqlite3.Row` and `PRAGMA foreign_keys = ON`
- `init_db()` — creates all tables with `CREATE TABLE IF NOT EXISTS`
- `seed_db()` — inserts sample data

`app.py` is the single entry point — all routes live there. The scaffold has placeholder routes returning strings; students replace them with real implementations across Steps 2–9.

**Templates** extend `base.html` using Jinja2 blocks (`title`, `head`, `content`, `scripts`). The nav in `base.html` is hardcoded for logged-out state — it will need to conditionally render based on session once auth is added (Step 2–3).

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

The database file is `expense_tracker.db` (gitignored, created at runtime by `init_db()`).

## SSH / Git

Two GitHub accounts are configured via SSH host aliases in `~/.ssh/config`:
- Personal (`ajha264538`): use remote `git@ajha_github:aniket264538/<repo>.git`
- Work (Prolifics): use remote `git@ajha_prolifics_github:<org>/<repo>.git`
