# Refine an Existing Spec

Opens an existing spec for targeted refinement of weak sections.

## Steps

1. **Resolve the slug:** use the provided slug, or scan `<specs-root>/*/spec.md` and ask the user to pick one.

2. **Read** all files in `<specs-root>/<slug>/`: `spec.md`, `design.md`, and `tasks.md`

3. **Assess gaps** across all files:

   **spec.md:**
   - Overview: is it specific enough?
   - Context & Background: does it explain why and reference existing code?
   - User Story: does it follow "As a ... I want ... So that ..." format?
   - Scope: are In Scope items concrete? Is Out of Scope defined?
   - Acceptance Criteria: are they in GIVEN/WHEN/THEN format? Are they testable?
   - Verification: is there a method, command, and expected output?
   - Technical Constraints: are there concrete MUST/SHOULD/MAY rules?

   **design.md:**
   - File & Folder Scope: are allowed files/paths listed?
   - API / Interface Contract: are signatures or types defined (if applicable)?
   - Edge Cases: are boundary conditions identified?

   **tasks.md:**
   - Dependencies: are external requirements listed?
   - Task Breakdown: is there at least one numbered implementation step? Are human-only steps tagged with `[HUMAN]`?
   - Notes for the Agent: are there helpful hints or gotchas?

4. **Present findings:** _"Sections X and Y are thin. What would you like to improve?"_
   - List the weak sections with a one-line explanation of what's missing
   - Suggest which section would benefit most from attention

5. **Targeted adaptive questions** for the sections the user wants to improve:
   - Explore relevant codebase areas if context is thin
   - Ask 2-4 questions per round, propose defaults
   - 1-2 rounds max

6. **Apply edits** directly to the appropriate file (`spec.md`, `design.md`, or `tasks.md`). If the user mentions design files or diagrams, remind them they can drop those into `<specs-root>/<slug>/design/` and reference them in `design.md`.
