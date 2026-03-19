---
name: spec-manager
description: >
  Overview of the spec management system for coding agents. Use this skill
  when the user asks about specs in general, wants to understand the spec
  workflow, or says "manage specs", "work with specs", or "how do specs work".
  For specific actions, use the dedicated skills: spec-new, spec-refine,
  spec-list, spec-load, spec-validate.
---

# Spec Manager

A lightweight system for creating and managing portable, folder-based task specs
that coding agents can read, implement, and verify. Specs are **ephemeral
planning artifacts** -- written to communicate intent, used to drive agent
planning, then discarded.

## Folder convention

All specs live under `specs/` at the project root:

```
specs/
  <task-slug>/
    spec.md          <- always created: requirements
    design.md        <- always created: technical decisions
    tasks.md         <- always created: implementation plan
    design/          <- created when needed: wireframes, mockups, exports
    assets/          <- created when needed: sample data, fixtures, references
```

All three `.md` files are always created when a new spec is made.

## Spec templates

Templates live in `skills/spec-manager/assets/`:

| Template | File | Purpose |
|----------|------|---------|
| `spec-template.md` | `spec.md` | Requirements: overview, context, user story, scope (in/out), acceptance criteria, verification, constraints |
| `design-template.md` | `design.md` | Technical decisions: file & folder scope, API contracts, edge cases, design references |
| `tasks-template.md` | `tasks.md` | Implementation plan: dependencies, task breakdown with `[HUMAN]` tagging, notes for the agent |

Required sections in `spec.md`:
- Overview + Status
- Context & Background
- User Story (As a ... I want ... So that ...)
- Scope (In Scope / Out of Scope)
- Acceptance Criteria (GIVEN/WHEN/THEN)
- Verification (method + commands + expected output)
- Technical Constraints (RFC 2119 keywords)

Required sections in `design.md`:
- File & Folder Scope (at least one path)

Required sections in `tasks.md`:
- Task Breakdown (at least one numbered step; tag human-only steps with `[HUMAN]`)

## Available skills

| Skill | What it does |
|---|---|
| `/spec-new` | Create a new spec via guided conversation |
| `/spec-refine` | Improve an existing spec's weak sections |
| `/spec-list` | List all specs with status |
| `/spec-load` | Load a spec and prime for planning |
| `/spec-validate` | Check a spec is agent-ready |
