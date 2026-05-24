# Claude Plugin Marketplace Configuration

To install the marketplace in claude code, run the following command:

```
claude plugin marketplace add https://github.com/fsferrara/coding-agents.git
```

or, if you have the repository cloned locally:

```
claude plugin marketplace add /path/to/coding-agents
```

## Plugin catalogue

| Plugin       | Agent       | Skills bundled                                                                                       |
|--------------|-------------|------------------------------------------------------------------------------------------------------|
| `specifier`  | specifier   | `spec-manager`                                                                                       |
| `architect`  | architect   | _none yet_                                                                                           |
| `builder`    | builder     | _none yet_                                                                                           |
| `verifier`   | verifier    | `local-code-review`, `agentive-code-review`                                                          |
| `deployer`   | deployer    | _none yet_                                                                                           |
| `documenter` | documenter  | `create-technical-presentation`, `technical-documentation`                                           |
| `utilities`  | _none_      | `worktree-setup`, `worktree-cleanup`, `conventional-commit`, `mindmap-generator`, `async-meeting`    |

## Packaging convention

Each plugin under `.claude-plugin/<plugin>/` wraps exactly one actor (or, for `utilities`, a cross-cutting group of skills not bound to any actor). Skills and agents are symlinks to their canonical locations under `skills/` and `agents/`, so each plugin is a thin shipping wrapper without content duplication.
