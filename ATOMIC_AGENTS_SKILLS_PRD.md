# PRD: Integrating Gemini Skills into Atomic Agents

## 1. Executive Summary
This project aims to modernize the **Atomic Agents** framework by transitioning from a static, command-based template system to a dynamic, persona-driven **Gemini Skills** architecture. Currently, Atomic Agents relies on users explicitly invoking commands like `Using the plan-feature command...`. By adopting the native Gemini Skills standard, we enable the agent to autonomously identify and activate specialized expert personas (e.g., "Planner", "Reviewer", "Security Specialist") based on the task context.

The core value proposition is to reduce cognitive load for the user while increasing the agent's autonomy and expertise. We will also introduce a dedicated **Agent Creator** skill within the extension to ensure users can easily expand their "team" of specialized agents.

The MVP goal is to deliver a fully functional, skill-aware version of Atomic Agents that preserves all existing workflows while introducing new, high-value expert personas.

## 2. Mission
To provide a rigorous, professional-grade Agentic Engineering environment that feels like a native extension of the Gemini CLI, empowering users to manage a fleet of specialized AI experts through a standard PIV (Prime, Plan, Execute, Validate) loop.

**Core Principles:**
- **Autonomy:** Agents should know when to "call in an expert."
- **Rigorous Process:** Maintain the high standards of the PIV loop.
- **Extensibility:** Make it trivial to create and share new specialized agents.
- **Context Efficiency:** Load expertise only when needed to preserve the context window.

## 3. Target Users
- **Primary User:** Senior Software Engineers and Architects.
- **Technical Comfort:** High (comfortable with CLI, Git, and PowerShell).
- **Key Needs:** Consistency in AI output, automated validation of code, and easy setup of project-specific AI rules.

## 4. MVP Scope

### Core Functionality
- ✅ Convert all existing "Gold Standard" commands into native Gemini Skills.
- ✅ Implement the `agent-creator` skill within the `atomic-agents` extension.
- ✅ Update the `/atomic-agents:install` command to support the new `skills/` directory structure.
- ✅ Port the `bar-raiser`, `critic`, and `cyber-mr-t` personas from the `gemini-sub-agents` project.

### Technical
- ✅ Update `GEMINI.md` to support autonomous skill activation.
- ✅ Implement YAML frontmatter for all `SKILL.md` files (Name + Description).
- ✅ Add a check for the `experimental.skills` flag in the user's `settings.json`.

### Integration
- ✅ Ensure backward compatibility with existing project structures where possible.
- ✅ Maintain the original naming convention for all converted workflows.

### Out of Scope
- ❌ Automatic migration of existing projects (manual update instructions only).
- ❌ Integration with non-Gemini AI CLI tools.
- ❌ Cloud-based skill registry (local/repo-based only for MVP).

## 5. User Stories
- **As a Developer**, I want the agent to automatically suggest the `plan-feature` skill when I describe a new task, so that I don't have to remember the exact command name.
- **As a Technical Lead**, I want to use the `agent-creator` skill to quickly scaffold a "Documentation Expert" persona for my project, so that I can maintain high documentation standards.
- **As a Security Engineer**, I want to activate the `cyber-mr-t` skill to perform a "tough-love" audit of my auth logic, so that I can identify vulnerabilities before they reach production.
- **As a Developer**, I want the `install` command to verify my CLI settings for skills, so that I don't encounter errors after scaffolding a new project.

## 6. Core Architecture & Patterns

### Directory Structure (The "Gold Standard" Template)
```text
src/.gemini/
├── GEMINI.md            # Refactored for skill-awareness
├── AGENTS.md            # Replacement for COMMANDS.md (Skill Registry)
├── skills/              # New directory for autonomous personas
│   ├── prime/           # Each skill in its own directory
│   │   └── SKILL.md
│   ├── plan-feature/
│   │   └── SKILL.md
│   ├── execute/
│   │   └── SKILL.md
│   ├── code-review/
│   │   └── SKILL.md
│   ├── rca/
│   │   └── SKILL.md
│   ├── implement-fix/
│   │   └── SKILL.md
│   ├── create-prd/
│   │   └── SKILL.md
│   ├── bar-raiser/      # Ported from sub-agents
│   │   └── SKILL.md
│   ├── critic/          # Ported from sub-agents
│   │   └── SKILL.md
│   └── cyber-mr-t/      # Ported from sub-agents
│       └── SKILL.md
└── commands/            # Still used for simple utility scripts
    ├── commit.md
    └── system-review.md
```

### Key Design Patterns
- **The Hybrid Extension:** The `atomic-agents` extension provides the global tools (`install`, `help`) and the `agent-creator` skill, while the project template provides the local task-specific skills.
- **Skill Discovery Pattern:** Using YAML frontmatter in `SKILL.md` files to allow the Gemini CLI to automatically index and present skills to the user.

## 7. Tools/Features

### Extension Command: `/atomic-agents:install`
- **Purpose:** Scaffolds the new skill-based environment.
- **Operations:**
    - Checks target directory (Safety).
    - Initializes Git + `.gitignore` (Security).
    - Copies `src/.gemini/skills/` and `src/.gemini/commands/`.
    - **New**: Validates `~/.gemini/settings.json` for skill support.

### Extension Skill: `agent-creator`
- **Location:** `extensions/atomic-agents/skills/agent-creator/SKILL.md`
- **Purpose:** To scaffold new specialized agent personas.
- **Key Features:**
    - Prompts for Agent Name and Expertise.
    - Generates directory in `.gemini/skills/`.
    - Creates `SKILL.md` with boilerplate YAML and instructions.

### Local Skill: `plan-feature`
- **Description:** "Transforms a feature request into a comprehensive implementation plan."
- **Logic:** Preserves the exhaustive planning process from the original command but activates autonomously when the user says "I want to add a feature" or "Plan this."

## 8. Technology Stack
- **Gemini CLI:** Version 1.15.0+ (for Skill support).
- **Environment:** Windows PowerShell (`win32`).
- **Standard:** [Agent Skills](https://agentskills.io) YAML/Markdown format.

## 9. Security & Configuration
- **Skill Activation:** Requires user consent via the `activate_skill` tool confirmation.
- **Configuration:** Users must have `previewFeatures: true` and `experimental: { skills: true }` in their global `settings.json`.

## 10. Success Criteria
- ✅ All 7 core workflows (`prime`, `plan-feature`, etc.) are functional as native skills.
- ✅ The `agent-creator` skill successfully scaffolds a new project-level skill.
- ✅ The `install` command correctly sets up the new `skills/` folder structure.
- ✅ The agent can autonomously identify and request to activate at least 3 different skills during a standard development session.

## 11. Implementation Phases

### Phase 1: Structural Setup
- **Goal:** Prepare the local environment and update the extension manifest.
- **Deliverables:**
    - ✅ Create `src/.gemini/skills/` directory.
    - ✅ Update `extensions/atomic-agents/gemini-extension.json`.
    - ✅ Implement the `agent-creator` skill in the extension folder.

### Phase 2: Workflow Migration
- **Goal:** Move existing commands to the skill structure with proper YAML.
- **Deliverables:**
    - ✅ Port `prime`, `plan-feature`, `execute`, `code-review`, `rca`, `implement-fix`, `create-prd`.
    - ✅ Port `bar-raiser`, `critic`, and `cyber-mr-t` from sub-agents.

### Phase 3: Extension Update & Validation
- **Goal:** Update the installer and global instructions.
- **Deliverables:**
    - ✅ Update `install.toml` to support the new structure and settings check.
    - ✅ Refactor `GEMINI.md` for skill-awareness.
    - ✅ Verify the entire loop in a sandbox environment.

## 12. Risks & Mitigations
- **Risk:** Users don't have skills enabled in `settings.json`.
- **Mitigation:** The `install` command and the `help` documentation will explicitly check and warn about this.
- **Risk:** Naming collisions with other installed extensions.
- **Mitigation:** Ensure skills are namespaced correctly and use descriptive descriptions in YAML.
- **Risk:** Loss of context when switching skills.
- **Mitigation:** The PIV loop commands will be updated to include "Context Carry-over" instructions.
