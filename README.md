# Claude Project Template

## Overview

This repository provides a reusable setup for working with [Claude Code](https://claude.ai/code) (CC) across multiple projects. It includes:

- **Global files** (`files/`) — a `CLAUDE.md` with your personal preferences and a helper PowerShell script, both installed to `~/.claude/`.
- **Project template** (`_Template/`) — a ready-to-copy project folder pre-configured with a VSCode workspace, Claude settings, milestone tracking, and a `.claudeignore`.

The pattern is one folder per project/task. Each folder opens as its own VSCode workspace, which automatically launches Claude Code in a dedicated terminal tab pointed at that folder.

---

## Installation

### Step 1 — Install global files

Run the install script from the repo root. It copies everything in `files/` into `~/.claude/`, prompting before overwriting any existing files.

**Mac / Linux / Git Bash on Windows:**
```bash
bash install.sh
```

**PowerShell on Windows:**
```powershell
bash install.sh
```
> Git Bash must be installed. Alternatively, manually copy `files/CLAUDE.md` and `files/start-claude.ps1` to `%USERPROFILE%\.claude\`.

After running, edit `~/.claude/CLAUDE.md` to fill in your personal details (email, Jira account ID, etc.).

> **Existing `CLAUDE.md` warning:** If you already have a `~/.claude/CLAUDE.md`, the script will prompt before overwriting. Choose **N** (skip) to preserve your existing file, then manually merge the relevant sections from `files/CLAUDE.md` into it rather than replacing it outright.

### Step 2 — Copy the `_Template` folder

Copy `_Template` to wherever you keep your projects and rename it for the new project:

```bash
cp -r _Template ~/Projects/my-new-project
```

On Windows (PowerShell):
```powershell
Copy-Item -Recurse _Template "$env:USERPROFILE\Projects\my-new-project"
```

---

## Setting Up a New Project

1. **Copy and rename** `_Template` as described above.
2. **Edit `CLAUDE.md`** in the new folder — see [How Claude remembers your project](https://code.claude.com/docs/en/memory#claudemd-files) for guidance on writing effective instructions.
   - Set the project name in the `# Project:` heading.
   - Fill in the **Overview**, **Status**, **Milestones**, **Scope**, **Tech Stack**, and **Key Decisions** sections.
   - Remove any placeholder sections that don't apply (e.g. **Tech Stack** for non-code projects).
3. **Rename `milestone1-xxx.md`** to match your first milestone (e.g. `milestone1-setup.md`) and update its contents.
4. **Update the Milestones table** in `CLAUDE.md` to link to your renamed milestone file.
5. Optionally add a `links/` subfolder for `.url` shortcut files to related pages.

> Personal project notes go in `notes.md` — it is listed in `.claudeignore` so Claude will never read it.

---

## Using a Project

### Opening the workspace

Open the project by double-clicking `project.code-workspace` (or `File > Open Workspace from File...` in VSCode). The workspace sets the window title to the folder name and pins the terminal to the project root (this way having multiple projects open at once won't be confusing - there won't be 4 'Claude Code' terminal windows).

### Auto-launching Claude Code

When the workspace opens, VSCode automatically runs the **Start Claude** task (defined in `.vscode/tasks.json`). This opens a new Windows Terminal tab titled with the project name and launches `claude` inside it, using `~/.claude/start-claude.ps1` to ensure a clean environment.

> On first open, VSCode may prompt you to allow automatic task execution. Click **Allow** (or set `task.allowAutomaticTasks` to `on` in your VSCode user settings).

### Working with milestones

Each milestone has its own `milestoneN-name.md` file tracking its goal, key decisions, open questions, and a task checklist.

- The **Milestones table** in `CLAUDE.md` gives Claude a quick status overview at the start of every session.
- Update `**Status:**` in the milestone file as work progresses (`Not Started` → `In Progress` → `Complete`).
- When starting a session, Claude will read `CLAUDE.md` automatically and pick up the active milestone and current status.
- You can tell Claude: *"Continue with the active milestone"* and it will orient itself from `CLAUDE.md` without further prompting.
- Add new milestone files and rows to the table as the project grows.

### Auto memory

The global `~/.claude/CLAUDE.md` installed by this template enables **auto memory** — Claude will automatically save notes (build commands, debugging insights, discovered preferences) to `~/.claude/projects/<project>/memory/MEMORY.md` and persist them across sessions. You can view, edit, or clear these notes at any time by running `/memory` inside a Claude session. See [Auto memory](https://code.claude.com/docs/en/memory#auto-memory) for full details on how it works and how to disable it if needed.

### Useful conventions

| Subfolder | Purpose |
|-----------|---------|
| `links/`  | `.url` shortcut files to related web pages |
| `assets/` | Images, data files (excluded from Claude by default) |
| `docs/`   | Reference material, specs, research |
| `src/`    | Source code (code projects only) |

---

Maintained by [John Moses](mailto:john.moses@machinify.com)
