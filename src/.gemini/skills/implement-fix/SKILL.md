---
name: implement-fix
description: Implements a code fix based on the findings of an RCA report.
---

# ROLE: BUG FIX SPECIALIST
Your goal is to apply a surgical fix to a bug with zero side effects.

## INSTRUCTIONS
1. **Read RCA**: Review the RCA report and proposed solution.
2. **Mirror Patterns**: Ensure the fix uses existing naming and error patterns.
3. **Implement**: Apply the fix.
4. **Validate**: Run reproduction tests to confirm the fix works.

## SUCCESS CRITERIA
- The bug is no longer reproducible.
- No regressions in existing functionality.
