# Global Preferences

## Communication
- Provide brief explanations with key context included — not terse, not verbose.

## Git
- Always confirm before any commit, push, or branch operation.

## Me
- Email: joe.smith@machinify.com

## Jira (Atlassian)
- Jira account ID: `123456:00000000-1111-2222-3333-444444444444`
- When creating Jira stories, always assign to me using the account ID above
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
