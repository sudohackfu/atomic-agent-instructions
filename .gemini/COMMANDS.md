# Gemini Agent Custom Commands

This file lists the available custom commands that can be invoked using the pattern:
**"Using the `[command_name]` command, [your request]..."**

| Command Name | File Path | Description |
| :--- | :--- | :--- |
| `commit` | `commands/commit.md` | Stages all current changes and creates a Conventional Commit. |
| `create-prd` | `commands/create-prd.md` | Generates a comprehensive Product Requirements Document (PRD) for a new feature or project. |
| `execute` | `commands/core_piv_loop/execute.md` | Executes an implementation plan created by `plan-feature`. |
| `implement-fix` | `commands/github_bug_fix/implement-fix.md` | Implements a bug fix based on a completed RCA document. |
| `plan-feature` | `commands/core_piv_loop/plan-feature.md` | Creates a detailed, step-by-step implementation plan for a new feature. |
| `prime` | `commands/core_piv_loop/prime.md` | Primes the agent with the full context of the current project codebase. |
| `rca` | `commands/github_bug_fix/rca.md` | Performs a Root Cause Analysis on a GitHub issue and generates a report. |
| `code-review` | `commands/validation/code-review.md` | Performs a technical code review on recent changes and reports issues. |
| `fix-review` | `commands/validation/code-review-fix.md` | Fixes issues that were identified in a code review report. |
| `system-review`| `commands/validation/system-review.md`| Reviews the entire planning and execution process for meta-level improvements. |
| `create-validation-doc` | `commands/validation/create-validation-doc.md` | Generates a project-specific `validation.md` file with commands for linting, testing, and building. |
| `create-deployment-bp` | `commands/generation/create-deployment-bp.md` | Generates a generic `deployment-best-practices.md` file for the current project context. |
