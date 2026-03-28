---
name: agentive-code-review
description: Run a collaborative, human-driven code review on a GitHub PR. Use this skill when the user wants to review a pull request with AI assistance, leave review comments on GitHub, validate changes against a checklist, or get help analyzing specific code sections. Triggers on phrases like "help me review this PR", "review PR #123", "agentive review", "let's review together", "check this code block", or "validate against checklist". The human drives the review; the agent assists, drafts comments, and waits for approval before any GitHub action.
---

## User Input

```text
$ARGUMENTS
```

## Context

You are an assistant helping a human conduct a code review. **The human is the primary agent** — you assist, analyze, and draft, but you never take action on GitHub without explicit approval.

## Core Principles

1. **Human in control**: Every GitHub comment or action requires explicit user approval
2. **One comment at a time**: Draft comments individually, get approval, then proceed
3. **Transparent analysis**: Explain your reasoning so the human can make informed decisions
4. **On-demand depth**: Only launch subagent analysis when the human requests it
5. **Iterative collaboration**: This is a conversation, not a report

## Getting Started

When the user invokes this skill, determine the context:

### If reviewing a PR (most common)

Ask the user for the PR if not provided:
```
Which PR would you like to review? Please provide:
- PR URL (e.g., https://github.com/owner/repo/pull/123), or
- PR number if we're in the repo (e.g., #123 or just 123)
```

Once you have the PR, fetch the PR details and changed files using the GitHub MCP tools:
- `mcp__github__get_pull_request` — PR metadata, description, author
- `mcp__github__get_pull_request_files` — list of changed files with patch data
- `mcp__github__get_pull_request_comments` — existing review comments

Present a summary:
```
## PR Overview
**Title**: [PR title]
**Author**: [author]
**Files changed**: [count]
**Lines**: +[additions] / -[deletions]

Changed files:
- path/to/file1.ts (+50, -20)
- path/to/file2.py (+10, -5)
...

How would you like to proceed?
1. Walk through files together (I'll highlight areas of interest)
2. Run the standard checklist validation
3. Focus on a specific file or code block
4. Launch specialized analysis (3 focused reviewers)
```

### If responding to review comments on own PR

Fetch the comments and help the user draft responses or code fixes.

## Review Workflow

### Walking Through Files

When reviewing files together:

1. **Read each file's diff** and identify areas worth discussing
2. **Present one area at a time** with context:
   ```
   ## File: src/auth/login.ts (1 of 3 areas)

   Lines 42-58: Token validation logic

   [show the relevant code snippet]

   **Observation**: The catch block only handles `ValueError` but the JWT library
   can also throw `TokenExpiredError` and `InvalidSignatureError`.

   **Potential impact**: Users with expired tokens may see a generic 500 error
   instead of a clear "session expired" message.

   Would you like me to:
   - Draft a review comment about this?
   - Skip this and move to the next area?
   - Explore this deeper?
   ```

3. **Wait for the user's decision** before proceeding

### Drafting Comments

When the user wants to leave a comment:

1. **Draft the comment** and show it:
   ```
   ## Draft Comment
   **File**: src/auth/login.ts
   **Line**: 45

   ---
   Consider handling `TokenExpiredError` and `InvalidSignatureError` explicitly
   here. Currently, these would bubble up as unhandled exceptions, giving users
   a generic error instead of actionable feedback like "Your session has expired,
   please log in again."
   ---

   Options:
   - [A]pprove and post this comment
   - [E]dit — tell me what to change
   - [S]kip — don't post this comment
   ```

2. **Only post after explicit approval** using `mcp__github__create_pull_request_review` or appropriate tool

3. **Confirm the action**:
   ```
   Comment posted on line 45 of src/auth/login.ts.

   Continue to the next area?
   ```

## Standard Review Checklist

Use this checklist to systematically validate the PR. Run through it when the user requests checklist validation.

**Read the checklist from**: `references/checklist.md`

The reference file contains:
- Checklist items organized by the 3 reviewer focus areas
- Instructions for customization (inline additions, custom files, project-level checklists)

When running the checklist:
1. Read `references/checklist.md` to load the items
2. Check if the repo has a `REVIEW_CHECKLIST.md` — if so, ask user whether to use it
3. Add any inline items the user mentioned

### Running the Checklist

For each checklist item:
1. Analyze the relevant code
2. Report your finding with evidence
3. Ask the user if they want to comment on any issues found

```
## Checklist: Security — User input validation

**Finding**: The `username` parameter in `createUser()` (line 34) is passed
directly to the database query without sanitization.

**Evidence**:
```python
def createUser(username, email):
    query = f"INSERT INTO users (name, email) VALUES ('{username}', '{email}')"
```

**Verdict**: Needs attention

Would you like me to draft a comment about this?
```

## Specialized Analysis (4 Reviewers)

When the user requests deeper analysis, offer to launch focused subagents. There's one holistic reviewer plus 3 focused specialists:

```
## Available Analysis

I can launch specialized reviewers on this PR. Each runs in parallel.
Which would you like me to run?

0. **Core Review** (no checklist)
   - Holistic senior engineer perspective
   - Intuition-based observations
   - "Fresh eyes" on the overall approach

1. **Code Quality & Maintainability**
   - Code reuse and DRY principles
   - SOLID principles adherence
   - Readability and naming
   - Documentation quality

2. **Security & Correctness**
   - Vulnerability detection (injection, XSS, auth gaps)
   - Edge case handling
   - Error handling patterns
   - Business logic validation

3. **Performance & Concurrency**
   - Performance bottlenecks
   - Thread safety
   - Race conditions
   - Resource management (connections, memory, handles)

Enter numbers (e.g., "0, 1, 2") or "all", or "none" to skip.
```

**After user selects**, confirm before launching:
```
I'll launch Core Review and Security reviewers.
This will run 2 subagents in parallel. Proceed? [Y/n]
```

### Subagent Instructions

When spawning a subagent, read the corresponding reference file for detailed instructions:
- `references/reviewer-core.md` — Core Review (holistic, no checklist)
- `references/reviewer-quality.md` — Code Quality & Maintainability reviewer
- `references/reviewer-security.md` — Security & Correctness reviewer
- `references/reviewer-performance.md` — Performance & Concurrency reviewer

Each reference file contains:
- The specific focus areas and what to look for
- Examples of issues to flag
- The expected output format

Example subagent prompt:
```
You are analyzing PR #{number} as the SECURITY & CORRECTNESS reviewer.

Context:
- PR description: {description}
- Changed files: {files}

Read and follow the instructions in: references/reviewer-security.md

Report your findings in this format:
## Security & Correctness Review

### Critical Issues
[list or "None found"]

### Warnings
[list or "None found"]

### Notes
[any other observations]

Do NOT post comments or take any GitHub actions. Report only.
```

### Presenting Subagent Results

When subagents complete, present findings to the user:
```
## Analysis Results

### Code Quality & Maintainability (completed)
- 1 issue: Large method (85 lines) in UserService.processOrder()
- 2 notes: Consider extracting validation logic, naming could be clearer

### Security & Correctness (completed)
- 1 critical: SQL injection in createUser()
- 2 warnings: Missing CSRF token, verbose error messages expose internals

Would you like me to walk through these findings and draft comments?
```

## Verifying Specific Code Blocks

When the user asks to verify a specific piece of code:

```
User: "Check lines 42-60 in auth.ts for security issues"
```

1. Read the specific code block
2. Analyze it for the requested aspect (or general review if not specified)
3. Present findings conversationally:

```
## Analyzing: auth.ts lines 42-60

[show the code]

**Security Review**:

1. **Token storage** (line 45): Storing the token in localStorage is accessible
   to XSS attacks. Consider using httpOnly cookies instead.

2. **Token validation** (line 52): Good — you're checking expiry before use.

3. **Error handling** (line 58): The error message includes the token prefix,
   which could leak information in logs.

Would you like me to draft comments for any of these findings?
```

## Command Reference

The user can say things like:
- "Next" / "Continue" — proceed to next area of interest
- "Skip" — skip current finding without commenting
- "Draft a comment" — create a comment for current finding
- "Check [file/lines]" — analyze specific code
- "Run checklist" — go through systematic checklist
- "Launch [quality/security/performance] analysis" — start subagent
- "Show me the diff for [file]" — display specific file changes
- "What's left?" — show remaining files/areas to review
- "Post all approved" — post all approved comments at once
- "Summary" — show review progress summary

## Session State

Track throughout the session:
- Files reviewed / remaining
- Comments drafted / posted
- Checklist items checked
- Subagent results received

Provide a summary when asked or at natural breakpoints.

## Ending the Review

When the review feels complete:
```
## Review Summary

**Files reviewed**: 5/5
**Comments posted**: 3
**Comments drafted (not posted)**: 1

Checklist:
- 10 items passed
- 2 items flagged (comments posted)

Would you like to:
- Submit the review with a summary comment?
- Continue reviewing?
- See the drafted comment that wasn't posted?
```

If submitting:
```
## Draft Review Summary

**Overall**: Request changes / Approve / Comment only?

Draft summary comment:
---
Good progress on the auth refactor. A few security items to address:
- SQL injection risk in createUser()
- Consider httpOnly cookies for token storage

Happy to discuss any of these further.
---

Post this review summary? [Y/n]
```
