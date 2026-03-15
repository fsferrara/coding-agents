# Contributing to Coding Agents Handbook

Thank you for your interest in contributing to this handbook! Whether you're fixing a typo, improving clarity, or proposing new content, your contributions are welcome.

## Before You Start

- **Read the handbook**: Familiarize yourself with the existing content and structure.
- **Check existing issues**: Someone may already be working on what you have in mind.
- **Review the Code of Conduct**: We're committed to a welcoming community. Please read [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md).

## How to Contribute

### Reporting Issues

Found an error, typo, or something unclear? [Open an issue](../../issues/new/choose) and select the appropriate template:

- **Bug Report**: For errors, typos, broken links, or inaccuracies
- **Feature Request**: For new chapters, topics, or structural improvements

### Submitting Changes

1. **Fork the repository** and create a branch from `main`
2. **Make your changes** following the guidelines below
3. **Submit a pull request** with a clear description of your changes

### Branch Naming

Use descriptive branch names:
- `fix/typo-in-chapter-3` - for corrections
- `content/new-prompt-patterns` - for new content
- `improve/restructure-part-2` - for improvements

### Commit Messages

Write clear, concise commit messages:
- Use the imperative mood ("Add section" not "Added section")
- Keep the first line under 72 characters
- Reference issues when relevant (`Fixes #12`)

## Writing Guidelines

This handbook has a specific voice and style. Please respect these conventions:

- **Preserve the author's voice**: Suggest structural or factual improvements, but avoid rewriting prose unnecessarily.
- **Be practical**: Content should be actionable and useful for working engineers.
- **Stay opinionated**: The handbook takes positions. Don't water down advice with excessive hedging.
- **Keep it readable on GitHub**: No build process. All content must render correctly as Markdown on GitHub.

### Repository Structure

- `README.md` - Entry point with table of contents
- `book/` - Book content organized by parts and chapters
  - Each part has a `README.md` with description and chapter links
  - Chapters are folders with their own `README.md`
- `skills/` - Companion files (skills, configurations, prompts) referenced from chapters

### For Companion Files (`skills/`)

Files in the `skills/` directory should be:
- Practical and ready to adapt for enterprise use
- Well-documented with clear usage instructions
- Tested in real-world scenarios when possible

## Review Process

1. All changes go through pull request review
2. Maintainers will review for accuracy, style consistency, and fit with the handbook's goals
3. Discussion and iteration are normal - don't be discouraged by feedback
4. Once approved, changes will be merged to `main`

## Licensing

**Important**: This project is licensed under [CC0 1.0 Universal](LICENSE) (public domain dedication).

By contributing, you agree that your contributions will be released under the same CC0 license. This means:
- Your contributions become part of the public domain
- Anyone can use, modify, and distribute them without restriction
- No attribution is required (though it's appreciated)

## Questions?

If you're unsure about anything, feel free to:
- Open an issue to discuss before starting work
- Ask questions in your pull request
- Reach out to the maintainers

Thank you for helping make this handbook better!
