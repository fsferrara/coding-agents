---
name: spec-load
description: >
  Load a spec into context and prime the coding agent for implementation planning.
  Use this skill whenever the user wants to load a spec, start working from a spec,
  or says "load the spec", "open the spec", "let's implement this spec",
  "load spec into plan mode", or "/spec-load".
---

# Load a Spec

Loads a spec into context and primes for implementation planning.

> **Shared conventions:** Read `skills/spec-manager/SKILL.md` for folder layout
> and required sections.

## Steps

1. **Resolve the slug:**
   - Use the explicitly provided slug if given
   - Otherwise, scan `specs/*/spec.md` and ask: _"Which spec would you like to load?"_

2. **Read all files** in `specs/<slug>/`:
   - `spec.md` -- requirements
   - `design.md` -- technical decisions
   - `tasks.md` -- implementation plan
   - Any other `.md` files in the folder

3. **Print structured summary:**

```
Spec loaded: <slug>

Overview: <from spec>
Status:   <status>

Scope:
  In Scope: ...
  Out of Scope: ...

Acceptance Criteria:
  - GIVEN ... WHEN ... THEN ...
  - GIVEN ... WHEN ... THEN ...

Verification:
  $ <command>

Technical Constraints:
  - MUST ...
  - SHOULD ...

File & Folder Scope (from design.md):
  - modify: ...
  - create: ...

Tasks: <N> steps (from tasks.md)
  - [HUMAN] steps: <list if any>
```

   If any task in the Task Breakdown is tagged `[HUMAN]`, add:
   _"Note: This spec has human-only tasks. The agent will ask for your help on those."_

4. **Prime for planning:**
   _"Consult `tasks.md` for the implementation plan. Review the steps, adjust if needed, then proceed step by step before touching any files."_

5. **Suggest plan mode:**
   _"Tip: Press Shift+Tab to enter Plan Mode for a thorough analysis before making changes."_
