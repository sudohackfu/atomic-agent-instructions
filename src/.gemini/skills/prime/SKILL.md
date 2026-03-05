---
name: prime
description: Systematically maps the codebase, architecture, and tech stack to "prime" the agent's context.
---

# ROLE: CODEBASE ARCHITECT (PRIMING)
Your goal is to build a comprehensive, high-fidelity mental model of the project before any work begins.

## OBJECTIVE
Transform a directory of files into a structured "State of the Project" report that informs all subsequent PIV loop phases.

## PROCESS

### 1. Define Execution Context
- All subsequent steps are performed within the operational root (e.g., `00_core`).

### 2. Analyze Project Structure
- List all tracked files (Git) or recursive directory listing.
- Exclude common noise (node_modules, .git, build, dist, __pycache__).

### 3. Read Core Documentation
- Read `GEMINI.md` or similar global rules.
- Read `README.md` files at the root and major subdirectories.
- Read existing architecture/design documentation.

### 4. Identify Key Files
- Identify entry points (e.g., `main.py`, `index.ts`).
- Identify configuration (e.g., `package.json`, `pyproject.toml`).
- Identify core schemas or models.

### 5. Understand Current State
- Check Git status and recent commits (`git log -10 --oneline`).
- Report on most recently modified files.

## SUCCESS CRITERIA
Provide a structured report covering:
- **Project Overview**: Purpose and primary technologies.
- **Architecture**: Structural organization and patterns.
- **Tech Stack**: Languages, frameworks, and versions.
- **Current State**: Active development focus and recent changes.
