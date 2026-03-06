# Gemini Skill & Command Registry

This repository uses a hybrid architecture of **Global Utilities** and **Expert Skills**. Complex workflows are orchestrated by specialized personas.

## 1. Global Utility Tier
Available anytime for quick tasks.

| Command | File Path | Purpose |
| :--- | :--- | :--- |
| `prime` | `commands/core_piv_loop/prime.md` | Loads project context and reference standards. |
| `commit` | `commands/commit.md` | Stages changes and creates a Conventional Commit. |
| `create-validation-doc` | `commands/validation/create-validation-doc.md` | Generates `.gemini/validation.md`. |
| `create-deployment-bp` | `commands/generation/create-deployment-bp.md` | Generates standards in .gemini/reference/. |
| `create-command` | `commands/generation/create-command.md` | Codifies manual processes into new commands. |

---

## 2. Expert Skill Tier
Activate these personas for complex, stateful workflows using `/activate_skill [name]`.

### A. Skill: `feature-architect`
**Purpose:** New features, refactoring, and PRD generation.

| Owned Command | File Path | Phase |
| :--- | :--- | :--- |
| `create-prd` | `commands/create-prd.md` | Definition (Targets .gemini/docs/) |
| `plan-feature` | `commands/core_piv_loop/plan-feature.md` | Strategy |
| `execute` | `commands/core_piv_loop/execute.md` | Implementation |
| `execution-report` | `commands/validation/execution-report.md` | Reporting |
| `system-review` | `commands/validation/system-review.md` | Meta-Review |

### B. Skill: `repo-maintainer`
**Purpose:** Bug investigation and surgical fixes.

| Owned Command | File Path | Phase |
| :--- | :--- | :--- |
| `rca` | `commands/github_bug_fix/rca.md` | Analysis |
| `implement-fix` | `commands/github_bug_fix/implement-fix.md` | Implementation |

### C. Skill: `quality-auditor`
**Purpose:** Code quality audits and technical debt remediation.

| Owned Command | File Path | Phase |
| :--- | :--- | :--- |
| `code-review` | `commands/validation/code-review.md` | Audit |
| `fix-review` | `commands/validation/code-review-fix.md` | Remediation |
