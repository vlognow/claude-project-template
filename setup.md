# Setup — Claude Project Template

This file is a runnable workflow that handles both **fresh installs** and **upgrades** of the Claude Project Template. Launch Claude from any directory and say:

> *"Read /path/to/claude-project-template/setup.md and follow it"*

Claude will detect whether this is a new installation or an upgrade and proceed accordingly. All steps are idempotent — safe to re-run at any time.

---

<!-- WORKFLOW: Claude reads below and executes as a setup/upgrade workflow -->

## Instructions for Claude

You are running the setup workflow for the Claude Project Template. Derive the repo root from the path of this file.

**Before proceeding, warn the user:**
> "⚠️ Please make sure all other VSCode windows and Claude sessions are closed before continuing. Setup will modify tasks.json files across your projects — open windows may reload stale versions or conflict with the changes."

Ask: "Are all other VSCode and Claude sessions closed? (yes to continue)"

If the user says no or asks why, explain and wait. Do not proceed until confirmed.

**Ask Claude Mode upfront:**

Ask:
> "How would you like Claude to launch when you open a project?
> - **terminal** *(default — type `y` to accept)* — opens Claude in the VSCode integrated terminal
> - **external** — opens Claude in a separate Windows Terminal window (uses start-claude.ps1)"

If the user types `y` or `terminal`, set `CLAUDE_MODE=terminal`. If the user types `external`, set `CLAUDE_MODE=external`.

**First, detect the mode:**
- If `~/.claude/CLAUDE.md` does **not** exist → **Install mode** (Steps 1–3b, then continue to Common)
- If `~/.claude/CLAUDE.md` **exists** → **Upgrade mode** (Steps 4–6, then continue to Common)

---

## Install Mode

### Step 1 — Gather user information

Tell the user:
> "I'll set up the Claude Project Template for you. I need a few details first."

Ask each question individually and wait for the answer before asking the next:

1. "What is your name?"
2. "What is your email address?"
3. "What is the full path to your Projects folder? (where you keep your work projects)"
4. "What is the full path to your Reports folder? (where status reports will be saved)"

### Step 2 — Create global file structure

Create the following directories if they don't exist:
- `~/.claude/`
- `~/.claude/skills/`
- `~/.claude/skills/status-report/`

Copy the following files from the repo:
- `files/start-claude.ps1` → `~/.claude/start-claude.ps1`
- `files/skills/status-report/SKILL.md` → `~/.claude/skills/status-report/SKILL.md`

### Step 3 — Create ~/.claude/CLAUDE.md

Copy `files/CLAUDE.md` from the repo to `~/.claude/CLAUDE.md`, then fill in the user's values:
- Replace the `Name:` placeholder with the name provided
- Replace the `Email:` placeholder with the email provided
- Replace the `Projects:` placeholder with the Projects path provided
- Replace the `Reports:` placeholder with the Reports path provided

### Step 3a — Copy report-template.md to Reports folder

Copy `report-template.md` from the repo to the user's Reports folder. If the file already exists there, skip silently.

*Continue to Common section.*

---

## Upgrade Mode

### Step 4 — Locate user configuration

Read `~/.claude/CLAUDE.md` and extract:
- `Projects:` path from the `## Me` section
- `Reports:` path from the `## Me` section (may be absent — that is okay)

If `Projects:` is not found, empty, or still contains a placeholder value (square brackets), do not stop — Step 6a will prompt for it interactively.

### Step 5 — Overwrite global files (safe)

Copy the following files from the repo to the user's Claude installation, overwriting existing versions:
- `files/start-claude.ps1` → `~/.claude/start-claude.ps1`
- `files/skills/status-report/SKILL.md` → `~/.claude/skills/status-report/SKILL.md`

### Step 6 — Merge ~/.claude/CLAUDE.md

Read `~/.claude/CLAUDE.md` and apply each check below. Skip silently if already correct.

#### 6a. ## Me section fields
For each of the four fields under `## Me`, treat it as missing if it is absent, empty, or still contains a placeholder value (e.g. `[fill in]`, `[your name]`, `[your email]`, or any value in square brackets). For each such field, ask the user for the value interactively — do not use a placeholder:
- `Name:`
- `Email:`
- `Projects:`
- `Reports:`

If all four fields are present and filled in, skip silently.

#### 6b. ## Jira section structure
Ensure the `## Jira` section contains three subsections:
- `### Machinify Jira (mcp__atlassian__ tools)`
- `### Performant Jira (mcp__jira-dc__ tools)`
- `### General`

If the section exists but lacks this structure, restructure it using `files/CLAUDE.md` as the model — preserve any existing account IDs or user keys the user has already filled in.

#### 6c. ## Tasks section
If absent, add:
```
## Tasks
- Open tasks are tracked in milestone `.md` files. When asked about pending or open tasks, check those files rather than the conversation task list.
```

#### 6d. ## Workspace Paths section
If absent, add the `## Workspace Paths` section from `files/CLAUDE.md`.

#### 6e. ## Activity History section
If absent, copy the full `## Activity History` section (including `### Highlights` and `### Reference Links` subsections) from `files/CLAUDE.md`.

If the section exists but is missing the `### Highlights` or `### Reference Links` subsections, add the missing ones from `files/CLAUDE.md`.

*Continue to Common section.*

---

## Common

### Step 7 — Update per-project files

Scan all immediate subdirectories of the `Projects:` path. A directory is a CPT project if it contains a `CLAUDE.md` with a `# Project:` heading. For each CPT project, apply the checks below.

#### 7a. Rename ## Status to ## Attributes
If the project's `CLAUDE.md` uses `## Status` as the heading for the Active Milestone / Default Jira System fields, rename it to `## Attributes`.

#### 7b. Remove Activity History from project CLAUDE.md
If the project's `CLAUDE.md` contains an `## Activity History` section, remove it — this content now lives in the global `~/.claude/CLAUDE.md`.

#### 7c. Ensure history/ folder exists
If the project does not have a `history/` folder, create it with an empty `.gitkeep` file.

#### 7d. Migrate ## Jira section in milestone files
For each `milestoneN-*.md` file in the project root:
- If the file contains `## Jira Story`, replace it with:
  ```
  ## Jira
  - Epic:
  - Story: <existing value if any>
  ```
- If the file contains neither `## Jira Story` nor `## Jira`, add the following after the `## Goal` section:
  ```
  ## Jira
  - Epic:
  - Story:
  ```
- If `## Jira` already exists with `Epic:` and `Story:` sub-fields, skip silently.

#### 7e. Update .vscode/tasks.json — Start Claude task

If the project's `.vscode/tasks.json` does **not** contain a task with label `Start Claude`, skip this step silently — the user has customized their task and opted out of management.

If `Start Claude` exists, replace it with the appropriate version based on `CLAUDE_MODE`:

- **`terminal`** — use the task from the repo's `_Template/.vscode/tasks.json`:
  ```json
  {
      "label": "Start Claude",
      "type": "shell",
      "command": "claude --continue",
      "presentation": {
          "reveal": "always",
          "panel": "new"
      },
      "isBackground": true,
      "problemMatcher": [],
      "runOptions": {
          "runOn": "folderOpen"
      }
  }
  ```

- **`external`** — use this template (Windows Terminal + start-claude.ps1):
  ```json
  {
      "label": "Start Claude",
      "type": "process",
      "command": "wt",
      "args": [],
      "windows": {
          "command": "wt",
          "args": [
              "new-tab",
              "--title",
              "${workspaceFolderBasename}",
              "--startingDirectory",
              "${workspaceFolder}",
              "--suppressApplicationTitle",
              "--",
              "powershell",
              "-NoExit",
              "-ExecutionPolicy",
              "Bypass",
              "-File",
              "${env:USERPROFILE}/.claude/start-claude.ps1",
              "-name",
              "${workspaceFolderBasename}"
          ]
      },
      "osx": {
          "command": "osascript",
          "args": [
              "-e",
              "tell application \"Terminal\" to do script \"cd '${workspaceFolder}' && claude\""
          ]
      },
      "presentation": {
          "reveal": "silent"
      },
      "problemMatcher": [],
      "runOptions": {
          "runOn": "folderOpen"
      }
  }
  ```

Preserve any other tasks already present in the file.

### Step 8 — Update _Template/ folder

If a `_Template/` folder exists directly inside the `Projects:` path:
- Copy all files from the repo's `_Template/` into the user's `_Template/`, overwriting existing versions
- Do **not** delete any files in the user's `_Template/` that are not present in the repo — the user may have added custom content
- **Delete** `report-template.md` from the user's `_Template/` if it exists there — this file has moved to the repo root

If no `_Template/` folder exists in the Projects path, copy the repo's `_Template/` folder there and tell the user:
> "`_Template/` was not found in your Projects directory — copied it from the repo."

### Step 9 — Handle misplaced report-template.md in projects

If any CPT project folder contains a `report-template.md` file, tell the user:
> "`report-template.md` was found in: [list projects]. This file has moved to the repo root and belongs in your Reports folder (`[Reports path]`) if you want to customize report output. The project copies are no longer used — please move or delete them manually."

### Step 10 — Summary

Print a horizontal rule (`---`) to separate the summary from prior output, then print:

- **Mode:** Install or Upgrade
- **Claude Mode:** terminal or external
- **Global files:** created or updated (or "already up to date")
- **~/.claude/CLAUDE.md:** created (Install) or sections added/updated (Upgrade), or "already up to date"
- **_Template/:** copied, updated, or already up to date
- **Projects updated:** list project names on one line (or "none")
- **Projects unchanged:** list project names on one line (or "none")
- **⚠️ Action required:** list any items needing manual follow-up (missing placeholders, misplaced files, skipped projects, etc.) — omit this line if nothing to flag

If `CLAUDE_MODE` is `terminal`, add:
> "💡 To hide the VSCode running task indicator: press `Ctrl+Shift+P` → **Preferences: Open User Settings (JSON)** → add `\"task.showRunningTask\": false`"
