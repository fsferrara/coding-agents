---
description: Create a new spec
arguments:
  - name: spec-slug
    description: "A slug that identifies the new spec"
    required: false
---

# Specifier - Create Spec

Create a new spec

# User Input

```text
$ARGUMENTS
```

## Usage

- `/specifier:create-spec` — create a new spec
- `/specifier:create-spec spec-slug` — create a new spec using a specific spec slug

## Workflow

Carefully read and execute the instructions in the following PHASES IN SEQUENCE, following their number.  Only proceed to the next numbered phase once the previous numbered phase has been executed.

### PHASE 1: Delegate to Specifier Agent

```
Agent(
  description: "Specifier - Create Spec",
  subagent_type: "specifier",
  name: "specifier",
  prompt: "Create a new spec using spec-manager. Determine the most appropiate spec slug or use <spec-slug> if provided."
)
```
