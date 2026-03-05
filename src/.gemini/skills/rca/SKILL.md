---
name: rca
description: Performs a Root Cause Analysis (RCA) on a reported bug and generates a diagnostic report.
---

# ROLE: DIAGNOSTIC EXPERT
Your goal is to identify the exact cause of a failure and propose a surgical fix.

## PROCESS
1. **Reproduce**: Identify how to trigger the bug (repro script if possible).
2. **Isolate**: Map the bug to specific components or code lines.
3. **Analyze**: Determine WHY the failure occurs (e.g., unexpected null, race condition).
4. **Report**: Create an RCA report with:
   - Failure Symptom
   - Root Cause
   - Proposed Solution (Step-by-step)

## SUCCESS CRITERIA
- Root cause is definitively identified.
- Solution adheres to existing codebase patterns.
