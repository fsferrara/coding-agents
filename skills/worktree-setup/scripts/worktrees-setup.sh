# worktrees-setup.sh
#
# Shell helpers for managing git worktrees.
#
# Usage:
#   source worktrees-setup.sh
#
# Functions:
#   workon <branch> [base]
#
# Description:
#   Creates or resumes a git worktree under a sibling folder named
#   "<repo-name>.wt/", so all worktrees for a given repo live together. The
#   worktree's own directory is the branch name with any "feature/"/"hotfix/"
#   prefix stripped. Prints the absolute path of the worktree on success.
#
#   Must be run from the root of a git repository (main repo or linked worktree).
#
# Behavior (first matching case wins):
#   1. Target path already exists and is a worktree for <branch> → print path, exit 0.
#   2. Target path exists but doesn't match <branch>            → error, exit 1.
#   3. Branch exists locally                                    → check it out into the worktree.
#   4. Branch exists only on a remote                           → create a local tracking branch in the worktree.
#   5. Branch doesn't exist anywhere                            → create a new branch from [base] (default HEAD).
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
#   # error: worktree '../<repo-name>.wt/JIRA-0000_my-new-feature' already exists

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

  # Resolve the main repo regardless of whether we're in the main working tree
  # or a linked worktree, so every worktree for this repo lands in the same
  # sibling "<repo-name>.wt/" folder.
  local common_dir
  common_dir="$(cd "$(git rev-parse --git-common-dir)" && pwd)"
  local main_repo
  main_repo="$(dirname "$common_dir")"
  local repo_name
  repo_name="$(basename "$main_repo")"
  local wt_root
  wt_root="$(dirname "$main_repo")/${repo_name}.wt"
  local dir="${wt_root}/${name}"

  # Case 1 & 2: target path already exists. If it's a worktree for the same
  # branch we treat this as success (idempotent resume); otherwise refuse so
  # we don't clobber unrelated content.
  if [ -d "$dir" ]; then
    local existing
    existing="$(git -C "$dir" rev-parse --abbrev-ref HEAD 2>/dev/null)"
    if [ "$existing" = "$branch" ]; then
      echo "$(cd "$dir" && pwd)"
      return 0
    fi
    echo "error: '$dir' already exists but is not a worktree for '$branch'" >&2
    return 1
  fi

  mkdir -p "$wt_root"

  # Case 3: branch exists locally — check it out, don't create a new one.
  if git show-ref --verify --quiet "refs/heads/$branch"; then
    git worktree add "$dir" "$branch" && echo "$(cd "$dir" && pwd)"
    return
  fi

  # Case 4: branch exists only on a remote — create a local tracking branch.
  local remote remote_ref=""
  for remote in $(git remote); do
    if git show-ref --verify --quiet "refs/remotes/$remote/$branch"; then
      remote_ref="refs/remotes/$remote/$branch"
      break
    fi
  done
  if [ -n "$remote_ref" ]; then
    git worktree add --track -b "$branch" "$dir" "$remote_ref" && echo "$(cd "$dir" && pwd)"
    return
  fi

  # Case 5: brand new branch from <base> (default HEAD).
  git worktree add -b "$branch" "$dir" "$base" && echo "$(cd "$dir" && pwd)"
}
