# Global Preferences

## Communication
- Provide brief explanations with key context included — not terse, not verbose.

## Git
- Always confirm before any commit, push, or branch operation.

## Me
- Name: Joe Smith
- Email: joe.smith@machinify.com
- Projects: C:/path/to/your/Tasks
- Reports: C:/path/to/your/Reports

## Jira

### Machinify Jira (mcp__atlassian__ tools)
- My account ID: `123456:00000000-1111-2222-3333-444444444444`
- Use this ID when assigning issues to me

### Performant Jira (mcp__jira-dc__ tools)
- My user key: `jsmith`
- Use this key when assigning issues to me

### General
- Use whichever Jira MCP server tools are available in the current project context. If both are available, use the **Default Jira System** field in the project's CLAUDE.md to determine which instance to use.
- Never hard-code sprint IDs — look up the active sprint dynamically via `list_sprints_for_board`

## MCP Tools

### Argo
- When the `convert_seed` tool is available, always use it to convert DPE Seed XML — never manually reason the conversion from Seed XML to SQL, DBT, or notebook format.

### NTFY
- Never include PHI, PII, credentials, API keys, or tokens in NTFY messages. Limit content to task status, completion signals, and non-identifying summaries.

## Memory
- At the start of each new project, proactively create a MEMORY.md in the auto memory directory with key paths, decisions, and milestone status.
- Keep MEMORY.md current as work progresses — update milestone status, add decisions made, and resolve open questions as they are answered.

## Workspace Paths
- To locate repos referenced in a project, read `project.code-workspace` in the working directory.
- Resolve any relative paths against the workspace file's location, then convert to Unix-style for shell use (e.g., `C:\Users\foo\bar` → `/c/Users/foo/bar`).

## Coding Conventions
- Prefer lowercase filenames and folder names.
- Keep solutions minimal — no extra abstractions, helpers, or future-proofing beyond what is asked.
- Do not add docstrings, comments, or type annotations to code that was not changed.

## Activity History
- History files: `history/YYYY-MM-monthname.md` within each project (e.g., `history/2026-03-march.md`).
- When you complete a task or milestone, append an entry to the current month's file (create it if it doesn't exist).
- Entry format: `- YYYY-MM-DD [TYPE] Description | Milestone: M# | Business Value: <value> | Status: <status>`
  - TYPE is one of: TASK, MILESTONE, DECISION, BLOCKER
  - Optional: `| Highlight: true` — marks the entry as a highlight for the status report
  - Optional: `| Ref: <label> <url>` — attaches a reference link (multiple allowed, each as a separate `| Ref:` field)
- When creating a new milestone or task, ask for its business value before recording it in CLAUDE.md or Jira.
- Never record PHI, PII, credentials, or internal URLs in history files.

### Highlights

To flag a task or milestone as a highlight for the status report, tell Claude:
- *"Flag [task/milestone] as a highlight"*
- *"Mark this as a highlight"*
- *"Add a highlight: [statement or observation]"*

When requested, append `| Highlight: true` to the relevant history entry. If it is a standalone observation with no associated entry, create a new `[HIGHLIGHT]` entry for today's date with the statement as the description.

### Reference Links

To attach a reference link to a task or milestone, tell Claude:
- *"Add a reference to [task/milestone]: [URL]"*
- *"Link [Notion doc / Slack thread / URL] to this"*
- *"Attach a reference: [label] [URL]"*

When requested, append `| Ref: <label> <url>` to the relevant history entry. A single entry may have multiple refs — append each as a separate `| Ref:` field. If the user does not provide a label, derive one from context or ask. Never fabricate or expand URLs — record only what the user explicitly provides.
