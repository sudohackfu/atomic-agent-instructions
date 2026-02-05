---
description: Generate a project-specific validation.md file
argument-hint: [project-root-path]
---

# Create Validation Document: Generate `validation.md`

## Objective

Generate a `validation.md` file specific to the current project context, containing instructions for linting, testing, and building based on an analysis of the project's technology stack. This file serves as a guide for the agent to validate implementation changes.

## Process

### 1. Analyze Project Technology Stack

- **Input:** The command can take an optional `project-root-path` argument. If not provided, assume the current working directory is the project root.
- **Detect Technologies:** Analyze `package.json` (for Node.js/npm), `pyproject.toml` or `requirements.txt` (for Python/uv), and other build configuration files to identify the primary language, frameworks, and build tools.
- **Identify Test Runners/Linters:** Detect common test runners (e.g., `pytest`, `vitest`) and linters (e.g., `ruff`, `eslint`).

### 2. Generate Validation Steps

Based on the detected technologies, construct a `validation.md` file with the following structure. Use placeholders where project-specific commands cannot be automatically determined.

#### Template Structure:

```markdown
# Project Validation

Run comprehensive validation of the project.

Execute the following commands in sequence and report results:

## 1. Backend Linting

```powershell
# cd <backend_directory> && <backend_linter_command>
# Example: cd backend && uv run ruff check .
```

**Expected:** "All checks passed!" or no output (clean)

## 2. Backend Tests

```powershell
# cd <backend_directory> && <backend_test_command>
# Example: cd backend && uv run pytest -v
```

**Expected:** All tests pass, execution time < 5 seconds

## 3. Backend Tests with Coverage

```powershell
# cd <backend_directory> && <backend_coverage_command>
# Example: cd backend && uv run pytest --cov=app --cov-report=term-missing
```

**Expected:** Coverage >= 80%

## 4. Frontend Build

```powershell
# cd <frontend_directory> && <frontend_build_command>
# Example: cd frontend && npm run build
```

**Expected:** Build completes successfully, outputs to `dist/` directory

## 5. Local Server Validation (Optional)

If the backend is not already running, start it:

```powershell
# cd <backend_directory> && <server_start_command> &
# Example: cd backend && uv run uvicorn app.main:app --port 8000 &
```

Wait 2 seconds for startup, then test:

```powershell
# Test API endpoint
# Example: Invoke-WebRequest -Uri http://localhost:8000/api/habits | Select-Object -ExpandProperty Content

# Check API docs
# Example: (Invoke-WebRequest -Uri http://localhost:8000/docs -UseBasicParsing).StatusCode
```

**Expected:** JSON response from endpoint, HTTP 200 from docs

Stop the server if started:

```powershell
# Windows
taskkill /F /IM uvicorn.exe 2>nul || true

# Linux/Mac (if running in a mixed environment)
lsof -ti:8000 | xargs kill -9 2>/dev/null || true
```

## 6. Summary Report

After all validations complete, provide a summary report with:

- Linting status
- Tests passed/failed
- Coverage percentage
- Frontend build status
- Any errors or warnings encountered
- Overall health assessment (PASS/FAIL)

**Format the report clearly with sections and status indicators**
```

## Output File

Write the generated `validation.md` to the root of the project: `validation.md`

## Notes

- Adapt specific commands based on detected project technologies.
- Prefer automated detection but use placeholders for manual input if necessary.
- Emphasize the creation of a comprehensive report.
