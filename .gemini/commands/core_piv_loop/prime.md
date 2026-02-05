---
description: Prime agent with codebase understanding
---

# Prime: Load Project Context

## Objective

Build comprehensive understanding of the codebase by analyzing structure, documentation, and key files.

## Process

### 1. Define Execution Context

- If a specific subdirectory (e.g., `00_core`) has been designated as the operational root, all subsequent steps will be performed exclusively within that directory's context.

### 2. Analyze Project Structure

- If the project is a Git repository, list all tracked files:
  !`git ls-files`
- Otherwise, or in addition, list all files recursively using the appropriate command for the OS. For PowerShell, use the following to exclude the root `.gemini` directory and common build artifacts:
  ```powershell
  $rootPath = (Get-Location).Path; $geminiPath = Join-Path -Path $rootPath -ChildPath ".gemini"; Get-ChildItem -Recurse -Path . | Where-Object { $_.FullName -notlike "$geminiPath*" -and $_.FullName -notlike "*\node_modules\*" -and $_.FullName -notlike "*\__pycache__\*" -and $_.FullName -notlike "*\.git\*" -and $_.FullName -notlike "*\dist\*" -and $_.FullName -notlike "*\build\*" } | Select-Object -ExpandProperty FullName
  ```

### 3. Read Core Documentation

- Read GEMINI.md or similar global rules file
- Read README files at project root and major directories
- Read any architecture documentation

### 4. Identify Key Files

Based on the structure, identify and read:
- Main entry points (main.py, index.ts, app.py, etc.)
- Core configuration files (pyproject.toml, package.json, tsconfig.json)
- Key model/schema definitions
- Important service or controller files
- **If common entry points are not found, attempt to deduce them by analyzing build scripts (e.g., `Dockerfile`, `build.gradle`), package manager files with `scripts` sections (e.g., `package.json`), or by searching for `main` functions in source files.**

### 5. Understand Current State

- If the project is a Git repository, check recent activity and status:
  !`git log -10 --oneline`
  !`git status`
- Otherwise, report on the most recently modified files to understand recent development focus.

## Output Report

Provide a concise summary covering:

### Project Overview
- Purpose and type of application
- Primary technologies and frameworks
- Current version/state

### Architecture
- Overall structure and organization
- Key architectural patterns identified
- Important directories and their purposes

### Tech Stack
- Languages and versions
- Frameworks and major libraries
- Build tools and package managers
- Testing frameworks

### Core Principles
- Code style and conventions observed
- Documentation standards
- Testing approach

### Current State
- Active branch
- Recent changes or development focus
- Any immediate observations or concerns

**Make this summary easy to scan - use bullet points and clear headers.**
