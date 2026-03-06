# Atomic Agents Extension

**Supercharge your development workflow with pre-configured Gemini agents.**

This extension injects the "Atomic Agents" framework into your project. It provides a standardized `.gemini` context folder containing specialized workflows, command templates, and architectural diagrams designed to facilitate high-quality Agentic Engineering.

## Features

*   **Standardized Context:** Installs a ready-to-use `.gemini` directory.
*   **Workflow Templates:** Includes commands for Planning, Execution, Code Review, and Deployment.
*   **Architectural Guidance:** Provides visual references (PIV Loop, Agentic Engineering) directly in your context.
*   **Easy CLI:** Simple `install` and `help` commands to get started.

## Installation

### Prerequisites
*   [Gemini CLI](https://github.com/google/gemini-cli) installed.

### Installing the Extension
Run the provided installation script to add this extension to your global Gemini environment:

```powershell
.\install.ps1
```

## Usage

Once installed, you can use the following commands in any project:

**1. Install Atomic Agents into a repo:**
```bash
/atomic-agents install
```
*Follow the interactive prompts to validate the target and configure .gitignore.*

**2. View Help & Resources:**
```bash
/atomic-agents help
```

## Structure
The installed `.gemini` folder includes:
*   `AGENTS.md`: Registry of available agent skills.
*   `skills/`: Directory of specialized, autonomous expert personas (e.g., `prime`, `plan-feature`).
*   `commands/`: Markdown templates for tactical utility tasks (e.g., `commit`, `system-review`).
*   `GEMINI.md`: Core agent instructions and autonomy protocols.
*   `*.png`: Reference diagrams for the agent to verify architectural decisions.
