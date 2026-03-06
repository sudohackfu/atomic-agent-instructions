---
description: Codify a manual process into a new project-local command
argument-hint: [command-name]
---

# Create Command: Codify Automation

## Objective

Transform a manual, repetitive process into a structured `.md` command file within the `.gemini/commands/` directory.

## Instructions

### 1. Analyze the Manual Process
- Review the recent conversation history to identify the steps of the manual process.
- Identify core actions (CREATE, UPDATE, ADD, REMOVE, REFACTOR).
- Note any specific files, line numbers, or patterns involved.

### 2. Design the Command Template
- **Title:** Clear, action-oriented name for the command.
- **Description:** Brief summary of the command's purpose (for the frontmatter).
- **Phases:** Break down the process into logical phases (e.g., Analysis, Execution, Validation).
- **Validation:** Define specific, executable commands to verify the task's success.

### 3. Categorize the Command
Determine where this command belongs:
- **Global Utility:** General-purpose tools (added to `GEMINI.md`).
- **Expert Skill:** Specific to a persona workflow (e.g., Architect, Maintainer, Auditor).

### 4. Create the File
Save the new command to the appropriate subfolder in `.gemini/commands/`:
- `core_piv_loop/` (Architect)
- `github_bug_fix/` (Maintainer)
- `validation/` (Auditor)
- `generation/` (Global)

### 5. Update the Registry
- Update `.gemini/COMMANDS.md` to include the new command and its owner.
- If it's a **Global Utility**, add it to the "Global Utility Tier" in `.gemini/GEMINI.md`.
- If it's an **Expert Tool**, update the corresponding `SKILL.md` in `.gemini/skills/` to include it in its "Owned Commands".

## Finalization
1. Confirm the new file path.
2. Provide a brief summary of the command's logic.
3. Suggest immediate use of the command if applicable.
