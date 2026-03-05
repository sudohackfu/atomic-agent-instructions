# Gemini Expert Agents (Skills)

This project uses native Gemini Skills to provide specialized expertise throughout the development lifecycle. The following agents are available in `.gemini/skills/`.

## Core PIV Loop Agents
| Agent | Description |
| :--- | :--- |
| `prime` | Builds a comprehensive mental model of the codebase. |
| `plan-feature` | Transforms feature requests into exhaustive implementation plans. |
| `execute` | Implements changes precisely from a plan with mandatory validation. |

## Validation & Quality Agents
| Agent | Description |
| :--- | :--- |
| `code-review` | Performs technical audits of recent changes. |
| `rca` | Diagnoses root causes for bugs and proposes fixes. |
| `implement-fix` | Applies surgical fixes based on RCA reports. |
| `create-prd` | Generates comprehensive Product Requirements Documents. |

## Expert Personas (Ported)
| Agent | Description |
| :--- | :--- |
| `bar-raiser` | Senior reviewer focused on architectural standards and elegance. |
| `critic` | Contrarian agent that finds technical debt and over-engineering. |
| `cyber-mr-t` | Security expert who enforces strict hygiene and least privilege. |

## How to Use
These agents are **autonomous**. You do not need to call them manually. Simply describe your goal (e.g., "I want to add a login page"), and the main agent will identify the appropriate skill (e.g., `plan-feature`) and request to activate it.
