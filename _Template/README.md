# Using the Claude/VSCode Template

> Note: This whole README.md file can be (and probably should be) overwritten with you specific project notes, install/usage information, etc. 

## How to Use This Template Project

1. **ASSUMPTION:** you have copied the _Template folder to wherever you keep your projects and renamed it.
2. **Edit `CLAUDE.md`** in the new folder:
   - **Most Critical** - Set the project name in the `# Project:` heading.
   - Edit the other sections - refer to [CLAUDE.md Tips](#claudemd-tips) below.
3. **Rename `milestone1-xxx.md`** to match your first milestone (e.g. `milestone1-setup.md`) and update its contents. Include the tasks related to your milestone/goal.
4. Add more milestones now, or sometime later.
5. **Update the Milestones table** in `CLAUDE.md` to link to your renamed milestone file(s).

### Now Run it, Live Long and Prosper...

#### Opening the workspace

Open the project by double-clicking `project.code-workspace` (or `File > Open Workspace from File...` in VSCode). The workspace sets the window title to the folder name and pins the terminal to the project root (this way having multiple projects open at once won't be confusing - there won't be 4 'Claude Code' terminal windows).

#### Auto-launching Claude Code

When the workspace opens, VSCode automatically runs the **Start Claude** task (defined in `.vscode/tasks.json`). This opens a new Windows Terminal tab titled with the project name and launches `claude` inside it, using `~/.claude/start-claude.ps1` to ensure a clean environment.

> :round_pushpin: On first open, VSCode may prompt you to allow automatic task execution. Click **Allow** (or set `task.allowAutomaticTasks` to `on` in your VSCode user settings).

#### Working with milestones

Each milestone has its own `milestoneN-name.md` file tracking its goal, key decisions, open questions, and a task checklist.

- The **Milestones table** in `CLAUDE.md` gives Claude a quick status overview at the start of every session.
- Update `**Status:**` in the milestone file as work progresses (`Not Started` → `Planning`→ `In Progress` → `Complete`) *(Use any values you want)*
- When starting a session, Claude will read `CLAUDE.md` automatically and pick up the active milestone and current status.
- You can tell Claude: *"Continue with the active milestone"* and it will orient itself from `CLAUDE.md` without further prompting.
- Add new milestone files and rows to the table as the project grows. *(Or, better yet, ask Claude to do it)*

#### Auto memory

The global `~/.claude/CLAUDE.md` installed by this template enables **auto memory** — Claude will automatically save notes (build commands, debugging insights, discovered preferences) to `~/.claude/projects/<project>/memory/MEMORY.md` and persist them across sessions. You can view, edit, or clear these notes at any time by running `/memory` inside a Claude session. See [Auto memory](https://code.claude.com/docs/en/memory#auto-memory) for full details on how it works and how to disable it if needed.

> :wine_glass: Between the project CLAUDE.md and auto memory, **CC** becomes very good at resuming work after you've closed your project and restart at a later time.

#### Useful conventions

| Subfolder | Purpose |
|-----------|---------|
| `links/`  | `.url` shortcut files to related web pages |
| `assets/` | Images, data files (excluded from Claude by default) |
| `docs/`   | Reference material, specs, research |
| `src/`    | Source code (code projects only) |



1. **Double-click `project.code-workspace`** to open VSCode. Claude Code (**CC**) will auto-start in a new terminal tab named after the project folder.
2. **Work** — use the VSCode IDE and Claude Code to add content, manage milestones, and drive your project forward.
   - Tell Claude: *"Continue with the active milestone"* and it will orient itself from `CLAUDE.md` without further prompting.
   - Update `**Status:**` in milestone files as work progresses (`Not Started` → `In Progress` → `Complete`).
   - Add new milestone files and rows to the table as the project grows.

> :round_pushpin: If you make key changes to your project CLAUDE.md, just exit **CC** and restart (type `claude --continue`) to reload the project in **CC** and continue your session.

### Subfolder Conventions
##### *(optional)*

- `links/` — shortcuts to other files/folders or `.url` files to related/relevant web pages (Claude can read the links but only access public, non-authenticated pages)
- `assets/` — images, data files, etc. (add to `.claudeignore` if it contains large binaries)
- `docs/` — reference material, specs, research
- `src/` — code (code projects only)

> :round_pushpin: This `README.md` is excluded from Claude Code context (per `.claudeignore`) — put Claude directives in `CLAUDE.md` and reference notes/material here.

---

## More Usage Tips

### CLAUDE.md Tips

- Keep it **short** and **scannable** — dense prose is less useful than bullets for Claude context.
- Keep it purely operational content for Claude — no inline commentary, no personal notes.
- Valid phases for **Status** within milestone tasks: `Not Started` / `Planning` / `In Progress` / `On Hold` / `Complete`
- **In Scope** — define what is covered; **Out of Scope** — list what is definitively not covered.
- **Key Decisions** — record important choices and the reasoning behind them to prevent re-litigating them.
- **Important Notes** — constraints, preferences, or instructions like "always use X library" or "don't touch Y file."
  > Preferences that apply globally should go in `~/.claude/CLAUDE.md` instead.
- Remove the **Tech Stack** section for non-code projects (writing, research, planning, etc.).
- HTML comments (`<!-- ... -->`) are NOT stripped — Claude reads raw text, so they count against context.
- Refer to [How Claude remembers your project](https://code.claude.com/docs/en/memory#claudemd-files) for additional guidance on writing effective instructions

### Global Configuration

- Global `CLAUDE.md` at `~/.claude/CLAUDE.md` contains directives that apply to all sessions (e.g., auto memory, coding conventions).
- Global MCP servers are defined in `~/.claude.json` (near the bottom).

### Atlassian MCP Tips

- When creating Jira stories via Claude, you can set: Summary, Description, Assignee, Priority, Labels, Components, Issue Type.
- Modifying existing stories is limited — you can only add Comments (the MCP cannot delete).
- Craft new Jira stories carefully using Claude, then manage them in the Jira web UI.

### .claudeignore Tips

- For this project structure, `README.md` and `*.code-workspace` are excluded from Claude context.
- Claude honors `.gitignore` by default, so:
  - Non-Claude files **in git** → put in `.claudeignore`
  - Non-Claude files **not in git** → put in `.gitignore`
