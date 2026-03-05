---
description: Generate a generic deployment-best-practices.md file
argument-hint: [project-root-path]
---

# Create Deployment Best Practices Document

## Objective

Generate a generic `deployment-best-practices.md` file for the current project context. This file will serve as a template containing high-level principles and placeholders for project-specific deployment commands.

## Process

### 1. Analyze Project Technology Stack

- **Input:** The command can take an optional `project-root-path` argument. If not provided, assume the current working directory is the project root.
- **Detect Technologies:** Analyze `package.json` (for Node.js/npm), `pyproject.toml` or `requirements.txt` (for Python), and other build configuration files to identify the primary language and frameworks.

### 2. Generate Document Structure

Create a `deployment-best-practices.md` file with the following sections. Adapt placeholders based on the detected technology stack.

#### Template Structure:

```markdown
# Deployment Best Practices

This document outlines general best practices for deployment. It should be updated with project-specific commands and configurations.

## 1. Environment Configuration
- **Principle:** Use environment variables for all configuration. Do not commit secrets or `.env` files.
- **Action:** Create a `.env.example` file in the repository.
- **PowerShell Example:** `$env:VARIABLE_NAME="value"`
- **Bash Example:** `export VARIABLE_NAME="value"`

## 2. Production Builds
- **Principle:** Create an optimized, production-ready build of the application.
- **Frontend Placeholder:** `cd <frontend_directory> && <build_command>`
- **Backend (if compiled) Placeholder:** `cd <backend_directory> && <build_command>`

## 3. Running in Production
- **Principle:** Use a production-grade process manager or web server to run the application.
- **Node.js Example:** `pm2 start server.js --name "my-app"`
- **Python Example:** `gunicorn --workers 4 myapp:app` (Note: `gunicorn` is not native to Windows and requires WSL or Docker).

## 4. Containerization (Docker)
- **Principle:** Use multi-stage Docker builds to create small and secure production images.
- **Action:** Create a `Dockerfile` for each service and a `.dockerignore` file to exclude unnecessary files from the build context.

## 5. Deployment Strategy
- **Principle:** Document a clear, repeatable process for deploying the application to production.
- **Action:** Add the project-specific deployment script or manual steps below.
  - `# Example: .\scripts\deploy-production.ps1`
```

## Output File

- **Path:** Overwrite the existing file at `.gemini/reference/deployment-best-practices.md`.

## Notes

- The goal is to create a generic, instructive template, not a project-specific artifact.
- Provide examples for both PowerShell and Bash where relevant for maximum portability of the reference document itself.
