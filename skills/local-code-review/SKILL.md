---
name: local-code-review
description: Conduct a local code review of the current branch changes. Use when the user asks to review their code, check their changes before committing or pushing, get feedback on a branch, or wants a second pair of eyes on their work. Triggers on phrases like "review my diff", "review my changes", "what do you think of these changes", "anything I missed", or "code review".
---

## Context

$ARGUMENTS

If the user provided specific focus areas or context above, prioritize those in your review.

## Goal

Perform a thoughtful code review of the changes in the current branch compared to the default branch. Act as a helpful senior engineer — catch real issues, skip the noise, and explain the *why* behind your feedback.

## Gather the Changes

Run these commands to see what changed:

```shell
# Get default branch (with fallback)
DEFAULT_BRANCH=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
if [ -z "$DEFAULT_BRANCH" ]; then
  DEFAULT_BRANCH="main"
fi

# Show changed files and full diff
git diff --name-status ${DEFAULT_BRANCH}...HEAD
git diff ${DEFAULT_BRANCH}...HEAD
```

## Review Philosophy

- **Focus on what matters**: Bugs, security issues, and maintainability problems take priority over style preferences
- **Be selective**: Flag 3-7 issues max. If everything looks good, say so briefly
- **Skip the obvious**: Don't comment on things the author clearly already knows
- **Proportional depth**: Small changes get quick reviews; large refactors deserve more analysis
- **Assume competence**: The author made deliberate choices — question things you genuinely don't understand rather than assuming mistakes

## What to Look For

1. **Correctness**: Will this work as intended? Are there edge cases, off-by-one errors, or unhandled states?
2. **Maintainability**: Will someone else (or future-you) understand this in 6 months? Is the intent clear?
3. **Performance**: Any obvious inefficiencies? (Don't speculate — only flag things that clearly matter)
4. **Security**: Input validation, data exposure, injection risks, auth/authz gaps
5. **Error handling**: Are failures handled gracefully? Will errors be debuggable?

## Output Format

Structure your review as follows:

### Summary
One paragraph describing what these changes accomplish and your overall impression.

### Findings
For each issue worth mentioning:

- **[Category]** `file:line` — Brief description
  - Why it matters
  - Suggested fix (if you have one)

Order by severity: critical issues first, minor observations last.

### What's Done Well
Mention 1-2 things the author did right — good patterns, clean structure, thoughtful edge case handling. Skip this section only if the changes are purely mechanical.

## Feedback Style

Your tone should be constructive and educational, like a mentor doing a code review.

**Good feedback:**
> **[Correctness]** `auth.py:42` — This catches `ValueError` but the API can also raise `KeyError` when the token is malformed.
> - Users with malformed tokens will see an unhandled exception instead of a clear error message.
> - Consider catching both, or use a broader exception handler with logging.

**Avoid:**
> Line 42 is wrong. You should catch KeyError too.

The difference: explain *why* something matters, not just *what* to change.
