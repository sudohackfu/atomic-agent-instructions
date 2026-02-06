# Atomic Agents Scaffolder

This extension provides tools to scaffold new projects using the Atomic Agents template. It ensures that every new project starts with the high-standard `.gemini` context required for effective Agentic Engineering.

## Dependencies & Setup

### 1. Git
Required for repository initialization and `.gitignore` management.
*   **Verification:** Run `git --version`.

### 2. PowerShell
Command execution is optimized for PowerShell (`win32`).

## Command: /atomic-agents

### Activation Logic

**If the user asks to "start a new project," "scaffold," or "initialize a template":**
1.  **Direct to /atomic-agents:install.**
2.  **Verify Target:** Ensure the user has specified a destination path.

## Operational Guardrails

1.  **Safety First:** Before writing any files, verify if the target directory exists. If it is not empty, you MUST warn the user and ask for explicit confirmation to proceed.
2.  **Git Integration:** Always ask if the project should be a git repository. If so, ensure `.gemini/` is added to `.gitignore` to prevent leaking local agent instructions.
3.  **Context Awareness:** After installation, explain the purpose of the `.gemini` folder and the PIV Loop diagrams.