---
name: spec-list
description: >
  List all task specs with their status. Use this skill whenever the user
  wants to see existing specs, or says "list specs", "show specs", "what
  specs do I have", or "/spec-list".
---

# List Specs

Lists all specs in the `specs/` directory with their status.

> **Shared conventions:** Read `skills/spec-manager/SKILL.md` for folder layout
> and required sections.

## Steps

1. Scan `specs/*/spec.md`
2. For each, extract: title (first `# heading`), Status field, and count which of the 3 expected files exist (`spec.md`, `design.md`, `tasks.md`)
3. Print a compact table:

```
Slug                    Status    Files
-----------------------------------------
user-auth-flow          ready     3/3
checkout-redesign       draft     1/3
```

4. If no specs found: _"No specs found. Use `/spec-new` to create one."_
