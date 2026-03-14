# Prompt Engineering

Prompt engineering is the practice of crafting instructions that reliably produce the behavior you want from a language model. For coding agents, this means writing task prompts that lead to correct, complete implementations without excessive back-and-forth.

A good prompt is not about magic words or secret techniques. It is about clarity: telling the model what you want, what constraints apply, and what success looks like. The better you specify the task, the less the model has to guess—and guessing is where things go wrong.

## Why Prompts Matter for Coding Agents

When you use a coding agent, every task begins with a prompt. The prompt sets the direction for the entire interaction. A vague prompt leads to vague results; a precise prompt leads to focused execution.

Unlike chat interactions where you can course-correct through conversation, agent tasks often run autonomously. The agent reads your prompt, plans its approach, and executes—potentially making dozens of tool calls before you see the result. If the initial prompt was unclear, the agent may confidently build the wrong thing.

## What Makes a Good Task Prompt

Effective task prompts share common characteristics:

- **Specific outcome**: State what should exist when the task is complete, not just what activity should happen.
- **Bounded scope**: Define what is in scope and, when helpful, what is explicitly out of scope.
- **Acceptance criteria**: List the concrete conditions that determine success.
- **Relevant context**: Include pointers to files, patterns, or constraints the agent needs to know.

## Structure of This Chapter

The following articles cover prompt engineering in depth:

1. Introduction (this article)

---

[← Back to Part 3](../README.md)
