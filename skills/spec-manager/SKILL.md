---
name: spec-manager
description: >
  Create, refine, validate, and load task specs for coding agents. Use this
  skill whenever the user wants to work with a spec -- even if they don't say
  the word "spec-manager". Triggers on natural phrasings like "create a spec
  for [feature]", "write up requirements", "spec this out", "draft the task",
  "refine the spec", "flesh out the spec", "the spec needs more detail",
  "validate the spec", "is this spec ready", "check the spec", "load the
  spec", "open the spec", "let's implement the [slug] spec", or any mention
  of a `specs/` folder. Also triggers when the user mentions a spec file
  (spec.md, design.md, tasks.md) by name, or references an existing
  `specs/<slug>/` directory. Covers the full lifecycle: creation, refinement,
  validation, and loading into plan mode. Use this skill aggressively -- if
  the user is talking about a task definition, requirements doc, or planning
  artifact for a coding agent, this is almost certainly the right tool.
---

# Spec Manager

A lightweight system for creating and managing portable, folder-based task specs that coding agents can read, implement, and verify. Specs are **ephemeral planning artifacts** -- written to communicate intent, drive agent planning, and then discarded.

This skill handles four intents: **create**, **refine**, **validate**, and **load**. Detect the intent from the user's free-form message, then follow the corresponding workflow. For create, continue in this file. For refine, validate, and load, read the matching reference file in `references/` and follow it.

## Folder convention

All specs live under a **specs root** directory. Each spec gets its own folder:

```
<specs-root>/
  <task-slug>/
    spec.md          <- always created: requirements
    design.md        <- always created: technical decisions
    tasks.md         <- always created: implementation plan
    design/          <- created when needed: wireframes, mockups, exports
    assets/          <- created when needed: sample data, fixtures, references
```

All three `.md` files are always created when a new spec is made.

## Templates

Templates live in `skills/spec-manager/assets/`:

| Template | File | Purpose |
|----------|------|---------|
| `spec-template.md` | `spec.md` | Requirements: overview, context, user story, scope (in/out), acceptance criteria, verification, constraints |
| `design-template.md` | `design.md` | Technical decisions: file & folder scope, API contracts, edge cases, design references |
| `tasks-template.md` | `tasks.md` | Implementation plan: dependencies, task breakdown with `[HUMAN]` tagging, notes for the agent |

## Required sections

**`spec.md`:**
- Overview + Status
- Context & Background
- User Story (As a ... I want ... So that ...)
- Scope (In Scope / Out of Scope)
- Acceptance Criteria (GIVEN/WHEN/THEN)
- Verification (method + commands + expected output)
- Technical Constraints (RFC 2119 keywords)

**`design.md`:**
- File & Folder Scope (at least one path)

**`tasks.md`:**
- Task Breakdown (at least one numbered step; tag human-only steps with `[HUMAN]`)

## Detect the intent

Match the user's phrasing to one of four intents:

| Intent | Triggers |
|---|---|
| **create** | "create a spec for X", "new spec", "write a spec", "draft requirements for X", "spec this out", "define the task" |
| **refine** | "refine the X spec", "flesh out the spec", "the spec is too thin", "add detail to the spec", "improve the spec" |
| **validate** | "validate the spec", "is the X spec ready", "check the spec", "is this spec agent-ready" |
| **load** | "load the X spec", "open the spec", "let's implement the X spec", "pull the spec into context" |

**Ambiguity rule:** If the user names a spec without a clear verb ("the auth spec"), ask which action they want: load, refine, or validate. If they mention a spec slug that doesn't yet exist under the specs root, default to **create**. Never silently pick between refine and validate -- they produce very different outputs, so when in doubt, ask.

## Resolve the spec directory

Determine the `<specs-root>` for this invocation:

1. Scan the user's message for an explicit path. A path is anything that:
   - matches `[\w./-]+/` and ends with a slash (e.g., `docs/specs/`, `./my-specs/`)
   - appears in quotes or backticks
   - follows a preposition like `under`, `in`, `inside`, or `at`

   If found, that's the specs root for this invocation.

2. Otherwise, default to `./specs/`. Do not scan other folders like `./docs/specs/` -- if specs live elsewhere, the user will name the path explicitly.

3. For **refine**, **validate**, and **load**: if `<specs-root>/<slug>/` doesn't exist, list what's under `<specs-root>/` and ask the user to pick a slug.

4. Never persist the chosen path. Each invocation is independent.

## Routing

Once you've classified intent:

- **refine** → read `references/refine.md` and follow it.
- **validate** → read `references/validate.md` and follow it.
- **load** → read `references/load.md` and follow it.
- **create** → continue with the workflow below.

---

## Create workflow

Creates a new spec folder and populates `spec.md`, `design.md`, and `tasks.md` through adaptive questioning.

### Steps

1. **Resolve the title** using this priority order:
   - Use the explicitly provided title if given
   - Otherwise, scan the recent conversation for a feature, task, or topic being discussed and propose it: _"I'll create a spec for `<inferred-title>` -- sound right?"_ Wait for confirmation or correction.
   - Only if no context can be inferred, ask: _"What's a short title for this spec?"_

2. **Determine the slug:**
   - If the user provided a slug directly (e.g., `PRJ-1234`), use it as-is
   - Otherwise, slugify the resolved title (lowercase, hyphens): e.g. "User Auth Flow" -> `user-auth-flow`

3. **Create** `<specs-root>/<slug>/`

4. **Explore the codebase** before asking questions:
   - Search for files and patterns related to the topic
   - Identify existing code, tests, configs, and conventions relevant to the task
   - Note the tech stack, framework patterns, and project structure

5. **Check for pre-filled content:** If the user provided requirements text (pasted description, ticket content, etc.), extract and map it to spec sections:
   - Identify which sections are already covered (e.g., Context & Background, User Story, Acceptance Criteria, Scope)
   - Pre-fill those sections in the checklist and confirm: _"I've mapped your requirements to these sections: X, Y, Z. Let me ask about the rest."_
   - Only ask adaptive questions for uncovered sections

6. **Adaptive questioning** (2-3 rounds, 2-4 questions per round):

   You are filling in all three spec files. Track this internal checklist:

   **spec.md (requirements):**
   - [ ] Overview (1-2 sentences)
   - [ ] Context & Background (why, what exists, relevant files)
   - [ ] User Story (As a ... I want ... So that ...)
   - [ ] Scope: In Scope (concrete deliverables)
   - [ ] Scope: Out of Scope (boundaries)
   - [ ] Acceptance Criteria (GIVEN/WHEN/THEN scenarios)
   - [ ] Verification (method + commands + expected output)
   - [ ] Technical Constraints (MUST/SHOULD/MAY rules)

   **design.md (technical decisions):**
   - [ ] File & Folder Scope (files to create/modify/delete)
   - [ ] API / Interface Contract (signatures, types)
   - [ ] Edge Cases (boundary conditions)
   - [ ] Design References (mockups, diagrams)

   **tasks.md (implementation plan):**
   - [ ] Dependencies (external requirements)
   - [ ] Task Breakdown (numbered steps; tag human-only steps with `[HUMAN]`)
   - [ ] Notes for the Agent (hints, gotchas)

   **Round structure:**
   - Present what you learned from codebase exploration as proposed context: _"I see `src/auth/login.ts` and `src/auth/__tests__/` -- is this the area we're modifying?"_
   - Ask 2-4 focused questions targeting uncovered sections
   - Propose sensible defaults based on what you found: _"Verification: `npm test -- --grep auth` -- does that work?"_
   - Accept the user's answers and check off sections

   **Human tasks** -- during questioning, ask:
   _"Are there any steps a human needs to handle (e.g., scheduling a demo, requesting access)? These go in the Task Breakdown tagged with `[HUMAN]`."_

   **Completion signals** -- move to writing when:
   - All required sections have content (even brief)
   - The user says "that's enough", "looks good", "go ahead", or similar
   - You've done 3 rounds of questions

   **Skip sections** that clearly don't apply (e.g., don't ask about API contracts for a CSS-only change).

7. **Write** all three files using the templates in `skills/spec-manager/assets/`:
   - `<specs-root>/<slug>/spec.md` from `spec-template.md` -- fill in all required sections with gathered information
   - `<specs-root>/<slug>/design.md` from `design-template.md` -- fill in sections where information was gathered; keep placeholder structure for the rest
   - `<specs-root>/<slug>/tasks.md` from `tasks-template.md` -- fill in sections where information was gathered; keep placeholder structure for the rest

8. **Confirm:** _"Spec created at `<specs-root>/<slug>/` with `spec.md`, `design.md`, and `tasks.md`."_
