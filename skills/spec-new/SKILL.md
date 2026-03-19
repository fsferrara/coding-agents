---
name: spec-new
description: >
  Create a new task spec for a coding agent via guided conversation. Use this
  skill whenever the user wants to create a spec, write a spec, define a task
  for an agent, or says "new spec", "create a spec", "spec for [feature]",
  or "/spec-new". Also triggers on "write up requirements", "define the task",
  or "let's spec this out".
---

# Create a New Spec

Creates a new spec folder and populates `spec.md`, `design.md`, and `tasks.md` through adaptive questioning.

> **Shared conventions:** Read `skills/spec-manager/SKILL.md` for folder layout
> and required sections. Read the templates in `skills/spec-manager/assets/`
> (`spec-template.md`, `design-template.md`, `tasks-template.md`) for the
> structural templates.

## Steps

1. **Resolve the title** using this priority order:
   - Use the explicitly provided title if given
   - Otherwise, scan the recent conversation for a feature, task, or topic being discussed and propose it: _"I'll create a spec for `<inferred-title>` -- sound right?"_ Wait for confirmation or correction.
   - Only if no context can be inferred, ask: _"What's a short title for this spec?"_

2. **Determine the slug:**
   - If the user provided a slug directly (e.g., `PRJ-1234`), use it as-is
   - Otherwise, slugify the resolved title (lowercase, hyphens): e.g. "User Auth Flow" -> `user-auth-flow`

3. **Create** `specs/<slug>/`

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
   - `specs/<slug>/spec.md` from `spec-template.md` -- fill in all required sections with gathered information
   - `specs/<slug>/design.md` from `design-template.md` -- fill in sections where information was gathered; keep placeholder structure for the rest
   - `specs/<slug>/tasks.md` from `tasks-template.md` -- fill in sections where information was gathered; keep placeholder structure for the rest

8. **Confirm:** _"Spec created at `specs/<slug>/` with `spec.md`, `design.md`, and `tasks.md`."_
