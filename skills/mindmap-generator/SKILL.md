---
name: mindmap-generator
description: Convert a block of text, an outline, or a set of notes into a hierarchical mind map in markmap.js-compatible markdown. Produces a file with the required markmap YAML frontmatter and nested markdown headings / bullet lists that render as an interactive mind map. Use this skill whenever the user asks for a mind map, a markmap, a hierarchical visualization of a document, an "outline as a mind map", wants to turn meeting notes / reading notes / a brief into a branching diagram, or phrasings like "visualize this hierarchically", "make a markmap of X", "mindmap this" — even if they don't mention markmap.js specifically.
---

# Mindmap Generator (markmap.js)

## When to use

Invoke this skill when the user wants a hierarchical visualization of text content rendered as a markmap. Representative phrasings:

- "Turn these release notes into a mind map."
- "Make a markmap of the architecture doc."
- "Visualize this brief hierarchically."
- "Mindmap the key concepts from this article."

If the user wants a *linear* outline, a table, or a flowchart, this skill is not the right fit — suggest the appropriate format instead.

## Inputs

Both parameters are optional. If the user doesn't specify, use the defaults.

- **`language`** — target language for the mind map content (e.g., `en`, `it`, `es`). Default: `en`.
- **`outputFile`** — desired output filename (e.g., `project-overview.md`). Default: `mindmap.md`.

If the source content is in a different language than the requested output, translate while preserving technical terms and proper nouns.

## Required output shape

Every generated mind map consists of (1) required YAML frontmatter and (2) a markdown body using heading hierarchy and bullet lists. The frontmatter is not optional — markmap depends on it to render correctly.

### Frontmatter (always the same)

```markdown
---
title: markmap
markmap:
  colorFreezeLevel: 2
  color: ["blue", "orange", "green", "violet", "grey"]
  maxWidth: 640
  embedAssets: true
---
```

### Body structure

Use markdown headings for the top three levels and bullet lists for finer detail:

```markdown
# Main Topic
## Subtopic 1
### Detail 1.1
### Detail 1.2
## Subtopic 2
### Detail 2.1
- Point A
- Point B
### Detail 2.2
```

- `#` is the root node. There must be exactly one.
- `##` are primary branches (level 1 below root).
- `###` are secondary branches.
- Deeper detail uses bullet lists (`-`) nested under the headings.

## Drafting workflow

1. **Identify the root.** One clear central concept. If the input is a long document, the title of the document is usually the root.
2. **Extract 3–7 primary branches.** Fewer feels thin; more makes the map unreadable.
3. **Add secondary branches** with roughly balanced depth — avoid one branch with ten children while others have one.
4. **Add supporting detail** as bullet lists, not further headings, once a branch is specific enough.
5. **Check for balance.** Prune noise. If a branch has a single child, consider merging.
6. **Translate** the content into the requested `language` if different from the source. Preserve code, product names, and technical jargon.
7. **Write the file** to the requested `outputFile` (default `mindmap.md`) with the frontmatter first, then a blank line, then the body.

## Supported markdown features

Markmap renders these inline enhancements — use when they add clarity:

- Text formatting: `**bold**`, `*italic*`, `~~strikethrough~~`, `==highlight==`.
- Code: `` `inline code` `` and fenced code blocks.
- Lists and checkboxes `- [x]`.
- KaTeX math: `$x = {-b \pm \sqrt{b^2-4ac} \over 2a}$`.
- Tables for small structured comparisons.
- Long text wraps automatically at `maxWidth`.

Don't over-decorate. The hierarchy is the product; formatting is a garnish.

## Quality bar

Before returning the result, confirm:

- Exactly one `#` heading.
- Primary branches (`##`) are mutually distinct and roughly balanced.
- Every node earns its place — no filler branches.
- Frontmatter is present and unchanged.
- Output language matches the requested `language` consistently.
- File extension is `.md`.

## References

- [markmap.js documentation](https://markmap.js.org/) — syntax reference for advanced features.
