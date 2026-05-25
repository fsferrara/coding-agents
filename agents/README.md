# Agents

Actor archetype definitions for the SDLC roles described in `drafts/actors.md`.
Each agent is a thin role wrapper that points at one or more skills under
`skills/`. Skills remain the unit of reusable behaviour; agents describe
**when** that behaviour applies and **who** owns it.

## Layout

Each agent lives in its own folder, mirroring the `skills/<name>/` convention:

```
agents/
  <name>/
    <name>.md          # the agent definition (frontmatter + body)
```

The folder leaves room for per-agent auxiliary files (`references/`,
`examples/`, `assets/`) without cluttering the top of `agents/`.

## Frontmatter schema

Every `agents/<name>/<name>.md` file starts with YAML frontmatter:

```yaml
---
name: <kebab-case>           # required, unique
description: >               # required, free-text trigger guidance
  When to invoke this agent. Used by Claude Code / OpenCode for routing.
model: inherit               # optional; "inherit" is portable across runtimes
tools: [Read, Write, Edit, Bash, Glob, Grep]   # optional, Claude-specific allowlist
skills:                      # custom, repo convention; mirrored in body
  - <skill-name>
---
```

Field-by-field:

- **`name`** — kebab-case identifier, must match the filename minus `.md`.
- **`description`** — free-text guidance that runtimes use to decide when to
  delegate. Phrase it as the situation that should trigger the agent, not as a
  job title.
- **`model: inherit`** — portable default. Lets the host runtime decide which
  model to use, instead of pinning a Claude- or OpenAI-specific model name.
- **`tools`** — optional allowlist of Claude Code tool names. Other runtimes
  ignore this field. Omit to grant the full default toolset.
- **`skills`** — custom repo convention. Lists the skills this agent owns,
  using paths relative to the repo root. Re-stated in the body so runtimes that
  don't read frontmatter still see it.

## Body shape

Below the frontmatter, every agent follows the same fixed structure:

1. A one- or two-paragraph intro stating the role and which SDLC phase(s) it
   covers.
2. `## When to invoke` — bulleted triggers, in the user's own phrasing where
   possible.
3. `## Skills` — the same list as the frontmatter `skills:` array, with a
   one-line description of each. Stub agents (no skill yet) state
   `TODO: needs skill` here.
4. `## Boundaries` — what this agent does **not** do, and which other agent
   takes over at each handoff. Defines the seams between actors.

## Runtime mapping

| Field              | Claude Code   | OpenCode      | Codex          |
|--------------------|---------------|---------------|----------------|
| `name`             | required      | required      | informational  |
| `description`      | routing       | routing       | informational  |
| `model` / `tools`  | honored       | honored       | ignored        |
| `skills:` (custom) | informational | informational | informational  |
| body               | full prompt   | full prompt   | full prompt    |

How to consume an agent on each runtime:

- **Claude Code** — wire `agents/` into the project via a symlink
  (`.claude/agents/ -> ../agents`) or copy step. Claude Code's subagent loader
  recurses into subdirectories under `.claude/agents/` and identifies agents by
  their `name:` frontmatter, so `agents/architect/architect.md` is discovered
  exactly the same as a flat `agents/architect.md`. The Task tool will list
  them by `name` and route based on `description`.
- **OpenCode** — point its agent loader at `agents/` (or symlink it into the
  expected location). Frontmatter and body are read directly from each
  `agents/<name>/<name>.md`.
- **Codex** — no native agent registry. Paste the agent file (frontmatter +
  body) into a system prompt, or load it via your own scaffolding.

## Catalogue

| Agent          | SDLC phase            | Skills                                                                 |
|----------------|-----------------------|------------------------------------------------------------------------|
| `specifier`    | Planning, Analysis    | `skills/spec-manager`                                                  |
| `architect`    | Design                | _stub — TODO: needs skill_                                             |
| `builder`      | Development           | _stub — TODO: needs skill_                                             |
| `verifier`     | Testing, Review       | `skills/local-code-review`, `skills/agentive-code-review`              |
| `deployer`     | Deployment            | _stub — TODO: needs skill_                                             |
| `documenter`   | All phases            | `skills/create-technical-presentation`, `skills/technical-documentation` |

Stub agents exist so the gap is visible: the role is named and bounded, but
the backing skill still has to be authored.

## Cross-cutting skills

These skills under `skills/` are intentionally **not** bound to any actor —
they are utilities used across phases:

- `skills/worktree-setup`
- `skills/worktree-cleanup`
- `skills/conventional-commit`
- `skills/mindmap-generator`
- `skills/async-meeting`

They stay invokable directly, without going through an agent.

## `commands/` — reserved

The sibling `commands/` directory is reserved for a follow-up round. Slash
commands will be thin delegators to agents (e.g. `/spec` → `specifier`), but
the agent layer is being validated first before that wiring is added.
