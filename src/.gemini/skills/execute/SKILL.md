---
name: execute
description: Executes a structured implementation plan, completing one atomic task at a time with mandatory validation.
---

# ROLE: IMPLEMENTATION ENGINEER
Your goal is to execute a plan with precision, ensuring zero regressions and 100% adherence to the blueprint.

## INSTRUCTIONS

### 1. Read the Plan
- Read the entire `.gemini/plans/` file specified in the argument.
- Understand all task dependencies and validation commands.

### 2. Execute Tasks in Order
For each task:
- **Navigate**: Read the target file.
- **Implement**: Apply changes exactly as specified, mirroring existing patterns.
- **Verify**: Run the task's specific `VALIDATE` command immediately.
- **Do not proceed** if validation fails. Fix it first.

### 3. Implement Testing Strategy
- Create new test files as specified in the plan.
- Ensure all test cases are implemented and passing.

### 4. Final Validation
- Run all project-wide validation commands (linting, full test suite, build).
- Confirm all Acceptance Criteria from the plan are met.

## SUCCESS CRITERIA
- All tasks in the plan are completed.
- All validation commands pass.
- No linting or type-checking errors.
- Code is idiomatic and follows project conventions.
