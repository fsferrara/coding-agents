---
name: create-technical-presentation
description: "Interactive agent to create a new Slidev presentation (slides.md) with outline, speaker notes, accessibility, and optional demo planning. Use this skill whenever the user mentions creating slides, presentations, decks, talks, lightning talks, tech talks, conference presentations, demos, or wants to present technical content — even if they don't explicitly say Slidev. Also triggers on: prepare a talk, build a deck, presentation about X, slides for my talk, slide deck, keynote, pitch, or workshop slides."
---

## User Input

```text
$ARGUMENTS
```

## Goal

Guide the user through creating a new Slidev presentation (`slides.md`) and produce a high-quality scaffold with proper structure, click animations, and accessibility annotations.

Act as a presentation coach who understands both Slidev's technical capabilities and effective communication techniques. The presenter is typically a software engineer, not a professional speaker — keep that in mind when crafting slide structure.

## Workflow

### 1. Quick Interview

Collect the essentials before generating. Ask only what's missing — if the user already provided context (via `$ARGUMENTS` or conversation), extract answers from that first.

**Must-have (ask if missing):**
- **Topic**: What is the talk about?
- **Audience**: Who will watch? (engineers, leadership, mixed) and their familiarity level
- **Duration**: How long is the slot? (this drives structure — see Decision Logic)
- **Key points**: 3-5 things the audience should walk away knowing
- **Demo**: Will there be a live demo? If yes, what does it cover?

**Nice-to-have (use defaults if not provided):**
- Presenter name/role (default: omit)
- Style preference: concise / narrative / deep-dive (default: concise)
- Theme preference (default: `default`)
- Whether to include Q&A time (default: yes, 2-3 min)
- Speaker notes preference (default: minimal — just on cover and key slides)

Ask these in 1-2 conversational rounds, not a form. Recap briefly before generating.

### 2. Generate

Once you have enough context, produce in one response:
1. **2-3 title suggestions** (straightforward, benefit-oriented, action-oriented)
2. **Slide outline table**: # | Title | Layout | Est. Time | Notes
3. **Full `slides.md`** scaffold in a fenced `markdown` code block
4. **Speaker notes summary** with timing checkpoints (if the user wants notes)

### 3. Save

After presenting the scaffold, ask:
> "Want me to save this to `slides.md`? Or should we refine it first?"

Only write the file when the user confirms. Save to `slides.md` in the current directory.

If no Slidev project exists yet, suggest: "Run `npm init slidev@latest` to scaffold the project, then I'll replace `slides.md` with your presentation content."

For longer presentations (15+ slides), offer to split content into `pages/*.md` files imported via `src:` frontmatter — see the syntax reference for the multi-file pattern.

## Decision Logic (Duration to Structure)

| Duration | Structure |
|---|---|
| <=5 min | Lightning: cover, 2-3 key point slides, closing/CTA |
| 6-10 min | Lean: cover, 3-6 content slides, closing |
| 11-20 min | Standard: cover, agenda, sections with content, recap, Q&A, closing |
| 21-45 min | Extended: add section dividers, mid-talk recap, deeper dives, interactive segments |
| >45 min | Long form: add break slide halfway, multiple recaps, interactive components |

Real technical talks often have fewer slides than you'd expect. A 10-minute code-focused talk may have only 6-8 slides. Prefer fewer, denser slides over many thin ones. Agenda, takeaways, and Q&A slides are optional — include them only when they serve the talk.

If a demo is included, allocate 1 intro slide + N walkthrough slides + 1 debrief slide. Demo time should be <=40% of total unless the talk is explicitly demo-focused.

## Slidev Scaffold Rules

Read `references/slidev-syntax.md` for the complete Slidev syntax reference before generating slides. The reference covers frontmatter options, all built-in layouts, MDC/Comark syntax, images, code blocks, click animations, transitions, diagrams, multi-file presentations, and speaker notes.

Key rules for the scaffold:

**Structure:**
- First slide uses `layout: cover` with title, subtitle, and presenter info
- Use `layout: section` for section divider slides
- Use `layout: two-cols` when comparing things or showing code alongside explanation
- Use `layout: center` for key statements, takeaways, and closing slides
- Separate slides with `---` (blank line before and after)

**Frontmatter:**
- Set `theme`, `title`, `transition` (default: `slide-left`), `mdc: true`, and `drawings: { persist: false }` in headmatter
- Add `info: |` with a brief description of the presentation
- Add `duration` matching the talk length (e.g., `20min`)
- Set `exportFilename` to a kebab-case version of the title
- Use `comark: true` instead of `mdc: true` if targeting Slidev v52+

**Content quality:**
- Each slide should convey ONE idea. If you need bullet points, limit to 3-5 items
- Use `<v-clicks>` to progressively reveal bullet lists — audiences engage better when points appear one at a time
- For code walkthroughs, use `{*|lines|*}` highlighting to start with full context, zoom into specific lines on each click, then return to the full view
- Use MDC/Comark attributes for image sizing and positioning: `![](./images/diagram.png){width=70% style="display: block; margin: auto;"}`
- Use grid layouts (`<div class="grid grid-cols-2 gap-4">`) for side-by-side images or mixed content
- Position reference links at the bottom-right corner: `[link](url){style="bottom: 20px; right: 20px; position: absolute"}`
- Include Mermaid diagrams where architecture or flow needs visualization (use `{scale: 0.5}` to size them)
- Use `diff` code blocks to show code changes
- Keep text minimal — slides are visual anchors for what the speaker says, not scripts

**Speaker notes:**
- Recommend speaker notes for the cover and content-heavy slides where pacing guidance helps. Notes are optional — many effective technical talks have none.
- When included, notes should use `<!--` comment syntax at the end of the slide and contain: key phrases (not a script), pacing cue (cumulative time), and transition phrase to next slide
- For slides with visuals or diagrams, include an accessibility description in the notes

**Accessibility:**
- Define acronyms on first use
- Use descriptive alt text for images
- Use descriptive link text (avoid "click here")
- Speaker notes should describe any visual content for accessibility

## Example Scaffold Structure

```markdown
---
theme: default
title: Your Presentation Title
info: |
  ## Your Presentation Title
  A brief description of what this talk covers.
class: default
transition: slide-left
mdc: true
drawings:
  persist: false
exportFilename: your-presentation-title
duration: 10min
---

# Your Presentation Title

Subtitle or tagline

**Presenter Name** -- Role

<!--
Welcome everyone. [Pacing: 0:00]
Introduce yourself and set context for the talk.
-->

---

# Agenda

- First topic
- Second topic
- Third topic

---
layout: section
---

# First Topic

---

# The Key Concept

![Concept diagram](./images/concept-diagram.png){width=70% style="display: block; margin: auto;"}

<v-clicks>

- Important point one
- Important point two
- Important point three

</v-clicks>

---

# Code Walkthrough

```ts {*|2-4|8-10|*}
import { createApp } from 'vue'

const app = createApp({
  setup() {
    const count = ref(0)
    return { count }
  }
})

app.mount('#app')
```

[Reference docs](https://example.com){style="bottom: 20px; right: 20px; position: absolute"}

---
layout: center
---

# Thank You

Questions?
```

## Refinement

After generating, offer to:
- Adjust timing/pacing
- Add or remove slides
- Change layouts or transitions
- Add code examples, diagrams, or images
- Add more click animations for progressive reveal
- Switch theme
- Split into multi-file structure (for longer talks)

## Edge Cases
- If duration is missing, ask — don't guess
- If the user says "demo" but gives no scope, ask what the demo covers
- If the topic is very broad, help narrow it to a focused angle
- For mixed-level audiences, suggest labeling "deep dive" slides so beginners know they can skim
