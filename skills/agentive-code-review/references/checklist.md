# Code Review Checklist

This is the default checklist for manual code reviews. Use it when walking through a PR item-by-item with the human reviewer. Users can provide their own checklist file or add items inline.

## Checklist

| Check | Status |
|-------|--------|
| Logic handles expected inputs correctly | ⬜ |
| Edge cases considered (null, empty, bounds) | ⬜ |
| Error handling is appropriate | ⬜ |
| No secrets or credentials in code | ⬜ |
| User input is validated/sanitized | ⬜ |
| No SQL injection or XSS vulnerabilities | ⬜ |
| Code is readable and self-documenting | ⬜ |
| No unnecessary duplication (DRY) | ⬜ |
| Single Responsibility Principle followed | ⬜ |
| Separation of concerns maintained | ⬜ |
| Minimal nesting; methods not overly long | ⬜ |
| Magic values avoided; parameters are configurable | ⬜ |
| Changes are testable | ⬜ |
| Tests cover the critical paths | ⬜ |
| No obvious performance issues | ⬜ |
| No race conditions or shared state issues | ⬜ |
| Async/await and locking patterns are correct | ⬜ |
| File handles, connections, and memory properly managed | ⬜ |
| Appropriate logging without sensitive data exposure | ⬜ |
| Breaking changes are documented | ⬜ |

## How to Customize

### Option 1: Add items inline
User says: "also check that all new functions have type hints"
→ Append to checklist during the session

### Option 2: Provide a custom checklist file
User says: "use checklist from ./my-checklist.md"
→ Read and use that file instead of (or merged with) this default

### Option 3: Project-level checklist
If a `REVIEW_CHECKLIST.md` exists in the repo root, offer to use it:
```
Found REVIEW_CHECKLIST.md in this repo. Should I:
- [R]eplace the default checklist with it?
- [M]erge both checklists?
- [I]gnore and use default only?
```

## Custom Checklist File Format

```markdown
# My Team's Review Checklist

- [ ] Check description
- [ ] All user input is sanitized
- [ ] Edge cases have tests
- [ ] Functions are under 50 lines
- [ ] Public APIs are documented
```

Each line should follow: `- [ ] Description`
