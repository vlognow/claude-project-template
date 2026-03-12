# Project Notes

Include a `CLAUDE.md` file. Claude Code (CC) will auto-load it into every session without needing to reference it manually. This CLAUDE file will define the project name, goals, status, scope, technical environment, key decisions, important constraints and open questions.

> Note: this `notes.md` file is specifically excluded from CC usage (per `.claudeignore`), so put CC directives in `CLAUDE.md` and personal notes here.

## Project-Specific Notes/Content

<!-- Insert Good-but-not-for-CC Stuff Here -->

## Global Notes/Tips

- Global CLAUDE.md file at `~/.claude/CLAUDE.md` contains CC directives that apply to all sessions (like use Auto Memory)
- Global MCP servers are defined in `~/.claude.json` (near the bottom)

<!-- Don't change below this point -->

### Tips for using the Atlassian MCP server

- When creating Jira stories, we can set these fields:
  - Summary
  - Description
  - Assignee (although `CLAUDE.md` automatically assigns to me)
  - Priority (High/Medium/Low)
  - Labels
  - Components
  - Issue type (Story/Task/Bug/Epic)
- When modifying Jira stories we can only add Comments (and, the MCP cannot delete)
- Thus, craft new Jira stories carefully using CC, then manage the stories in the Jira web UI
 
### Tips for *.claudeignore*

- For our project structure, we exclude `notes.md` and `*.code-workspace`
- CC honors the `.gitignore` (by default), so:
  - non-claude files in-git: put in `.claudeignore`
  - non-claude files not-in-git: put in `.gitignore`

### *CLAUDE\.md* Tips

- Keep it ***short*** and ***scannable*** — dense prose is less useful than bullets for CC context.
- Keep it purely operational content for Claude — no inline commentary, no personal notes.
- Use `notes.md` (this file) for personal notes; it is listed in `.claudeignore` so CC will not read it.
- Valid phases for **Status** within milestone tasks are:
  - Not Started
  - Planning
  - In Progress
  - On Hold
  - Complete
- **In Scope** define what is in scope
- **Out of Scope** list what is definitively **NOT** in scope
- **Key Decisions** a most valuable section — Record important choices and the reasoning behind them to prevent re-litigating them.
- **Important Notes** is where to put constraints, preferences, or instructions like "always use X library," "don't touch Y file," or "client requires Z format."
> Note that preferences that could apply **GLOBALLY** should be put in the global `~/.claude/CLAUDE.md` file
- Remove the **Tech Stack** section for non-code projects (writing, research, planning, etc.).
- HTML comments (`<!-- ... -->`) are NOT stripped — CC reads raw text, so they count against context just like everything else.

### Subfolder Conventions

- `links/` — .url files to related/relevant web pages/content
> Note: CC can read the links but can only access the content of public, non-authenticated pages (not say, github sites)
- `assets/` — images, data files, etc. (add to `.claudeignore` if it contains large binaries)
- `docs/` — reference material, specs, research
- `src/` — code (code projects only)
