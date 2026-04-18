---
name: pics
description: Use when the user invokes /pics or demands proof for every claim — forces inline evidence (diff, test output, command output, file:line) for every factual statement in the reply. Pics or it didn't happen.
---

# pics

Slash command. Every claim ships with proof in the same message, or it doesn't ship.

**Tagline: pics or it didn't happen.**

## Rules

For every factual or technical claim in the reply, attach one of:

- **Diff** — actual unified diff of the change, not a summary
- **Command output** — pasted stdout/stderr, with the command that produced it
- **Test output** — the runner's output, pass or fail, unedited
- **File citation** — `path/to/file.ext:LINE` pointing at the exact line you're quoting, with the line's contents quoted

No proof → no claim. If you can't prove it, say **"Not verified."** and stop.

## Banned under /pics

- "done" without a diff
- "it works" without output
- "the function returns X" without reading the function
- "this file does Y" without citing file:line
- Paraphrases of documentation you didn't open
- Any confidence above "don't know" for things you didn't check this turn

## What counts as proof

| Claim type | Required proof |
|---|---|
| "I changed X" | Diff |
| "Tests pass" | Runner output |
| "Function does Y" | `file:line` + quoted lines |
| "API takes arg Z" | `file:line` from the API source, or linked docs fetched this turn |
| "Command prints W" | Pasted `$ cmd` + output |

## What does NOT count

- "I remember that..."
- "Based on the pattern..."
- "It should..." / "It typically..."
- A summary in place of the output
- A link without fetching it

## Off switch

Invocation ends at end of turn. Next message returns to default nodream mode unless /pics is called again.
