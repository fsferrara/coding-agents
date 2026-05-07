# worktrees-cleanup.sh
#
# Shell helper for tearing down a git worktree created by workon. Does NOT
# delete branches (local or remote) — that's left to the git provider's
# auto-delete-on-merge, or to the user if they want to prune manually.
#
# Usage:
#   source worktrees-cleanup.sh
#   cleanup                     # infer branch from current worktree's HEAD
#   cleanup <branch>            # explicit branch name (same form workon takes)
#   cleanup [<branch>] --force  # skip the uncommitted-changes guard
#
# Behavior (first matching case wins):
#   1. No arg + CWD isn't inside a linked worktree   → error, exit 1
#   2. Target worktree doesn't exist                 → no-op, exit 0
#   3. Target worktree has uncommitted changes       → error unless --force
#   4. CWD is inside the target worktree             → error, ask user to cd out
#   5. Otherwise                                     → git worktree remove [--force]
#
# Prints the removed path on success, or "nothing to clean up: <dir>" when
# the worktree was already gone.

cleanup() {
  local branch=""
  local force=0
  local arg
  for arg in "$@"; do
    case "$arg" in
      --force)
        force=1
        ;;
      -*)
        echo "error: unknown option: $arg" >&2
        return 1
        ;;
      *)
        if [ -n "$branch" ]; then
          echo "error: usage: cleanup [<branch>] [--force]" >&2
          return 1
        fi
        branch="$arg"
        ;;
    esac
  done

  if ! git rev-parse --git-dir >/dev/null 2>&1; then
    echo "error: not inside a git repository" >&2
    return 1
  fi

  # Case 1: no branch given — infer from CWD's HEAD, but only if CWD is inside
  # a linked worktree (not the main repo). In the main repo, --git-dir and
  # --git-common-dir resolve to the same path; in a linked worktree they differ.
  if [ -z "$branch" ]; then
    local git_dir git_common
    git_dir="$(cd "$(git rev-parse --git-dir)" && pwd)"
    git_common="$(cd "$(git rev-parse --git-common-dir)" && pwd)"
    if [ "$git_dir" = "$git_common" ]; then
      echo "error: no branch argument, and the current directory is not inside a linked worktree" >&2
      return 1
    fi
    branch="$(git rev-parse --abbrev-ref HEAD)"
  fi

  local name="${branch##*/}"

  # Resolve <repo>.wt/<name> using the same logic as workon.
  local common_dir
  common_dir="$(cd "$(git rev-parse --git-common-dir)" && pwd)"
  local main_repo
  main_repo="$(dirname "$common_dir")"
  local repo_name
  repo_name="$(basename "$main_repo")"
  local wt_root
  wt_root="$(dirname "$main_repo")/${repo_name}.wt"
  local dir="${wt_root}/${name}"

  # Case 2: worktree already gone — idempotent no-op.
  if [ ! -d "$dir" ]; then
    echo "nothing to clean up: $dir"
    return 0
  fi

  local abs_dir
  abs_dir="$(cd "$dir" && pwd)"

  # Case 3: uncommitted changes — refuse unless --force.
  if [ "$force" -eq 0 ] && [ -n "$(git -C "$dir" status --porcelain 2>/dev/null)" ]; then
    echo "error: worktree '$abs_dir' has uncommitted changes; commit/stash first or re-run with --force" >&2
    return 1
  fi

  # Case 4: CWD inside the target worktree — refuse, ask user to cd out.
  local cwd
  cwd="$(pwd)"
  case "$cwd" in
    "$abs_dir"|"$abs_dir"/*)
      echo "error: current directory is inside the target worktree; cd to '$main_repo' first" >&2
      return 1
      ;;
  esac

  # Case 5: remove.
  if [ "$force" -eq 1 ]; then
    git worktree remove --force "$dir" && echo "removed: $abs_dir"
  else
    git worktree remove "$dir" && echo "removed: $abs_dir"
  fi
}
