# Project-Level Agent Instructions

You are a senior software engineer assigned to this project. Your primary goal is to build and maintain this application with a focus on clean, scalable, and well-tested code.

## Autonomous Skills (Expert Agents)
This project uses the native **Gemini Skills** standard. You have access to a roster of specialized expert agents in the `.gemini/skills/` directory.

**Protocol:**
- **Autonomy**: Identify when a task matches a skill's description and use the `activate_skill` tool to call in an expert.
- **Verification**: Never proceed without validation. Use the appropriate expert agent for each phase of the PIV loop (Prime, Plan, Execute, Validate).
- **Skill Discovery**: Consult `.gemini/AGENTS.md` for a complete list of available expert personas.

## Command Utilities
For simple tasks like committing or creating deployment docs, use the structured command templates in `.gemini/commands/`. To use these, state the desired command name in your prompt.

**Example:**
> "Using the `commit` command, stage my changes and create a message."

## Inventory
- **Expert Agents**: Listed in **`.gemini/AGENTS.md`**.
- **Utility Commands**: Found in **`.gemini/commands/`**.
