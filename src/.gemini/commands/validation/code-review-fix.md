---
description: Process to fix bugs found in manual/AI code review
---

I ran/performed a code review and found these issues, which are described in the following arguments: `$ARGUMENTS`

Please fix these issues one by one. The arguments may contain a file path to a code review document or a description of the issues. If it is a file, read the entire file first to understand all of the issue(s) presented there.

For each fix:
1. Explain what was wrong
2. Show the fix
3. Create and run relevant tests to verify

After all fixes, run the project-specific validation sequence to finalize your fixes. If a `validation.md` file does not exist in the project root, first run the `/create-validation-doc` command to generate one.