---
name: worktree-cleanup
description: Tear down a git worktree created by workon when the task is done. Use this skill when the user says they're "done with [branch]", "finished with X", asks to "clean up this worktree", "remove the worktree", "tear down", "wrap up", "PR merged — clean up", or otherwise signals they're wrapping up work on a branch or spec. Also trigger when the user says they've finished a spec and wants to clear its workspace. This skill only removes the worktree directory — it does not delete local or remote branches.
---

# Worktree Cleanup

Tear down a worktree that was created with `workon`. The scope is deliberately narrow: remove the worktree directory and its git registration, and nothing else. Local and remote branches are left untouched — the git provider's auto-delete-on-merge takes care of merged branches, and unmerged branches stay around so no work is lost.

## Gathering context

Work out what the user wants to clean up before running anything:

- **Which worktree?** If they said something like "I'm done with this branch" from inside a linked worktree, infer the target from the current working directory. If they named a branch explicitly (e.g. "clean up `feature/foo`"), use that.
- **Are they inside the worktree they want to remove?** The helper refuses to delete a worktree the user is currently sitting in — they'll need to `cd` out first.
- **Do they have uncommitted changes they care about?** The helper refuses on a dirty worktree by default. If the user explicitly wants to discard that work, `--force` is available. If it's ambiguous, ask before forcing.

If the context is unclear, ask a targeted question; if the signal is strong ("done with this, clean it up"), just act.

## Running cleanup

Use the **Bash tool** to source and run the bundled `cleanup` shell function. The script lives at `scripts/worktrees-cleanup.sh` relative to this skill's directory.

```bash
source <this-skill-dir>/scripts/worktrees-cleanup.sh && cleanup [<branch>] [--force]
```

Replace `<this-skill-dir>` with the actual absolute path to this skill's directory.

- **No branch argument** (preferred shorthand): the helper uses the branch currently checked out in the CWD's worktree. Only works when CWD is inside a linked worktree — it errors out if run from the main repo without an argument.
- **Explicit branch**: pass the same name you'd pass to `workon` (e.g. `feature/user-auth-flow_add-oauth`). Works from anywhere inside the repo.
- **`--force`**: maps to `git worktree remove --force`. Only use this when the user has explicitly agreed to discard uncommitted changes.

The helper is **idempotent** — safe to re-run. If the worktree was already gone it prints `nothing to clean up: <dir>` and exits 0.

**Handling refusals:**

- *Uncommitted changes*: the helper refuses with a message naming the worktree. Surface that to the user and ask whether to commit/stash first or re-run with `--force`. Don't force silently.
- *CWD inside the target*: the helper refuses and names the main repo path. Tell the user to `cd` there first, then re-run. You can derive that path yourself from `git rev-parse --git-common-dir` (its parent directory is the main repo root).

## Reporting completion

Tell the user:

- The absolute path of the worktree that was removed (taken from the `removed: <path>` line the helper prints), or that there was nothing to clean up.
- Explicitly that the **branch was not deleted** — it still exists locally and on the remote. Mention that merged branches will be reaped by the git provider's auto-delete-on-merge, and unmerged branches can be pruned manually if the user wants to.

Keep the completion note short — one or two sentences is enough unless the user asked for detail.
