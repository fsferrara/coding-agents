---
name: async-meeting
description: Draft a structured asynchronous-meeting document that walks participants through three phases — Presentation → Discussion → Conclusion — with a clear issue statement, proposed options, acknowledgment checkpoint, time-boxed discussion window, and explicit next steps with owners. Use this skill whenever the user wants to facilitate a decision asynchronously, collect structured input from multiple stakeholders without a live meeting, draft a decision doc, or asks for phrasings like "async meeting for X", "async discussion doc", "decision doc template", "gather async input on Y", "facilitate a remote decision" — even if they don't use the word "async".
---

# Async Meeting Facilitator

## When to use

Invoke this skill when the user wants to turn a decision or discussion into a written, time-boxed document people contribute to on their own schedule.

Representative phrasings:

- "Set up an async meeting about the rollout plan."
- "I need a decision doc for choosing between GraphQL and REST."
- "Gather async input from the team on the new on-call rota."
- "Draft a facilitation doc for the architecture review."

### When **not** to use async meetings

Steer the user away from this format if the situation is:

- A **simple status update** — a message or channel post is better.
- **Urgent** — requires a live conversation or a quick call.
- **Highly interactive brainstorming** — live whiteboarding beats async for idea generation.

If the situation is wrong for async, say so and suggest the better alternative before drafting.

## Structure (always three phases)

Every async meeting document has the same shape. Keep the phase headings verbatim so readers know where to look.

1. **Presentation** — the facilitator states the issue, context, and proposed options. Participants read and acknowledge.
2. **Discussion** — participants add input inline, within a defined deadline. The facilitator may nudge or respond but does not steer to a conclusion yet.
3. **Conclusion** — after the deadline, the facilitator summarizes contributions, records the decision, and lists concrete next steps with owners and dates.

## Required fields

At the top of the document, always collect and surface:

- **Facilitator** — the single person accountable for running the meeting.
- **Deadline** — a specific date and time by which input must be submitted. Default to 2–3 business days if the user doesn't specify.
- **Purpose** — one or two sentences stating why this meeting exists.

## Template

Use this template verbatim unless the user asks for a variation. Replace bracketed placeholders; leave the headings intact.

```markdown
# [Meeting Title]

**Facilitator:** [Name]
**Deadline:** [YYYY-MM-DD HH:MM TZ]

## 1. Presentation

### Purpose
[1–2 sentence meeting objective.]

### Issue
- **What:** [Describe the problem or decision needed.]
- **Why important:** [Impact and urgency.]
- **Proposed solutions:**
  1. [Option 1]
  2. [Option 2]
  3. [Option 3]

### Acknowledgment
Please confirm you have reviewed this document by commenting: "Acknowledged."

## 2. Discussion
*Participants: add your input below by [deadline]. Sign your comments.*

## 3. Conclusion
*To be completed after the discussion period.*

### Summary of contributions
[Summarize key discussion points and insights.]

### Decisions made
[Final decision(s).]

### Next steps
- [ ] [Action item 1] — @[owner] by [YYYY-MM-DD]
- [ ] [Action item 2] — @[owner] by [YYYY-MM-DD]
```

## Drafting workflow

1. **Clarify intent.** If the user gave only a topic, ask one or two targeted questions — who is the facilitator, who are the participants, what's the deadline, and what are the candidate options. If you can infer confidently, infer and flag the assumption.
2. **Right-size the options.** Aim for 2–4 proposed solutions. One option = no decision to make; more than four makes async input unwieldy.
3. **Write from the reader's perspective.** Context before options. State the stakes before the menu.
4. **Leave the Conclusion empty** at draft time — it gets filled in only after the deadline.
5. **Save the doc** in a sensible location if the user asks to persist it: `my/meetings/` for team/work discussions, `second-brain/projects/` if tied to a specific project.

## References

- `my/meetings/` — typical storage location for meeting notes in this vault.
