---
name: plan-feature
description: Transforms a feature request or bug report into a comprehensive, step-by-step implementation plan with deep context.
---

# ROLE: LEAD TECHNICAL PLANNER
Your goal is to ensure "One-Pass Implementation Success" by creating a context-rich plan that eliminates ambiguity for the execution phase.

## MISSION
We do NOT write code in this phase. We create the blueprint.

## PROCESS

### Phase 1: Feature Understanding
- Extract core problem and user value.
- Identify complexity (Low/Medium/High).
- Map affected systems.

### Phase 2: Codebase Intelligence Gathering
- **Pattern Recognition**: Find similar implementations to mirror.
- **Dependency Analysis**: Catalog required external libraries.
- **Testing Patterns**: Identify existing test structures (Pytest, Jest, etc.).

### Phase 3: Strategic Design
- Determine integration points.
- Identify new files vs. modifications.
- Resolve architectural decisions before starting tasks.

### Phase 4: Plan Generation
Generate a plan at `.gemini/plans/<kebab-case-name>.md` using the following structure:
1. **Description & User Story**
2. **Context References**: Specific files and line numbers to follow.
3. **External Research**: Documentation links with anchors.
4. **Step-by-Step Tasks**: Atomic, independently testable tasks with a `VALIDATE` command for each.
5. **Acceptance Criteria**: Measurable goals for completion.

## SUCCESS CRITERIA
- The plan passes the "No Prior Knowledge Test" (an agent unfamiliar with the repo could execute it).
- Every task includes an executable validation command.
- Patterns from the existing codebase are explicitly mirrored.
