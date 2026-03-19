---
name: spec-validate
description: >
  Check that a spec is complete enough to hand off to a coding agent. Use this
  skill whenever the user wants to validate a spec, check spec quality, or says
  "validate the spec", "is this spec ready", "check the spec", or
  "/spec-validate".
---

# Validate a Spec

Checks that a spec is complete enough to hand off to an agent.

> **Shared conventions:** Read `skills/spec-manager/SKILL.md` for folder layout
> and required sections.

## Steps

1. **Resolve the slug:** use the provided slug, or scan `specs/*/spec.md` and ask the user to pick one.

2. **Read** all files in `specs/<slug>/`: `spec.md`, `design.md`, and `tasks.md`

3. **Required checks** (must all pass):

| # | Check | File | Rule |
|---|-------|------|------|
| 1 | spec.md exists | spec.md | `specs/<slug>/spec.md` is present |
| 2 | design.md exists | design.md | `specs/<slug>/design.md` is present |
| 3 | tasks.md exists | tasks.md | `specs/<slug>/tasks.md` is present |
| 4 | Overview | spec.md | Non-empty, at least one sentence |
| 5 | Context & Background | spec.md | Non-empty, explains why |
| 6 | User Story | spec.md | Follows "As a ... I want ... So that ..." format |
| 7 | Scope | spec.md | In Scope has at least one item |
| 8 | Acceptance Criteria | spec.md | At least one criterion in GIVEN/WHEN/THEN format |
| 9 | Verification | spec.md | Has method + at least one command |
| 10 | Technical Constraints | spec.md | Non-empty, has at least one rule |
| 11 | File & Folder Scope | design.md | At least one file/path listed |
| 12 | Task Breakdown | tasks.md | At least one numbered implementation step |

4. **Advisory checks** (recommendations, not blockers):

| # | Check | File | Recommendation |
|---|-------|------|---------------|
| A | Out of Scope | spec.md | Define boundaries to prevent scope creep |
| B | RFC 2119 keywords | spec.md | Use MUST, SHOULD, MAY in constraints for clarity |
| C | Testable ACs | spec.md | Each AC should map to a verifiable outcome |
| D | Expected output | spec.md | Verification should describe what success looks like |
| E | `[HUMAN]` tags | tasks.md | Non-automatable steps in Task Breakdown should be tagged `[HUMAN]` |
| F | API / Interface Contract | design.md | Define interfaces if the task involves APIs or public functions |
| G | Edge Cases | design.md | Identify boundary conditions to prevent regressions |
| H | Design References | design.md | Link mockups or diagrams in `./design/` if they exist |
| I | Dependencies | tasks.md | List external requirements to avoid blockers during implementation |
| J | Notes for the Agent | tasks.md | Add hints or gotchas to save the agent time |

5. **Report format:**

```
Validation: specs/<slug>/

Required:
  [PASS] spec.md exists
  [PASS] design.md exists
  [PASS] tasks.md exists
  [PASS] Overview
  [PASS] Context & Background
  [FAIL] Acceptance Criteria -- not in GIVEN/WHEN/THEN format
  [PASS] Verification
  [PASS] File & Folder Scope
  [PASS] Task Breakdown
  ...

Advisory:
  [WARN] Out of Scope -- not defined, consider adding boundaries
  [OK]   RFC 2119 keywords used
  [WARN] Edge Cases -- none identified, consider adding boundary conditions

Result: 11/12 required checks passed
```

6. If any required checks fail, offer: _"Want me to fix these with `/spec-refine`?"_
