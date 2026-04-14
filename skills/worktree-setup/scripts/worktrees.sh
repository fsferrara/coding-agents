# worktrees.sh
#
# Shell helpers for managing git worktrees.
#
# Usage:
#   source worktrees.sh
#
# Functions:
#   workon <branch> [base]
#
# Description:
#   Creates a new git worktree in a sibling directory named after the branch
#   (excluding any prefix like "feature/" or "hotfix/").
#   Prints the absolute path of the created worktree on success.
#
#   Must be run from the root of a git repository.
#
# Arguments:
#   branch  Branch name to create. Can include a gitflow-style prefix.
#   base    (optional) Base branch or commit to branch off. Defaults to HEAD.
#
# Examples:
#   # Simple branch, branches off HEAD
#   workon JIRA-0000_my-new-feature
#
#   # With gitflow-style prefix
#   workon feature/JIRA-0000_my-new-feature
#
#   # With explicit base branch
#   workon feature/JIRA-0000_my-new-feature develop
#   workon hotfix/JIRA-9999_fix-login main
#
#   # Already exists → error
#   workon JIRA-0000_my-new-feature
#   # error: worktree '../JIRA-0000_my-new-feature' already exists

workon() {
  if [ -z "$1" ]; then
    echo "error: usage: workon <branch> [base]" >&2
    return 1
  fi

  if [ -n "$(git rev-parse --show-prefix 2>/dev/null)" ] || ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "error: not at the root of a git repository" >&2
    return 1
  fi

  local branch="$1"
  local base="${2:-HEAD}"
  local name="${branch##*/}"
  local dir="../$name"

  if [ -d "$dir" ]; then
    echo "error: worktree '$dir' already exists" >&2
    return 1
  fi

  git worktree add "$dir" -b "$branch" "$base" && echo "$(cd "$dir" && pwd)"
}
