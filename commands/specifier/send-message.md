---
description: Sends a message to the specifier agent
arguments:
  - name: message
    description: "An optional starting message"
    required: false
---

# Specifier - Start chat

Send a message to the agent to start a chat.

# User Input

```text
$ARGUMENTS
```

## Usage

- `/specifier:send-message` — starts a chat
- `/specifier:send-message message` — starts a chat with an initial message

## Send a message to the agent

<summary> = <message> truncated to 30 chars.

```
SendMessage({
  to: "specifier",
  summary: "<summary>",
  message: "<message>"
})
```
