# Setup — Claude Project Template

This file is a runnable workflow that handles both **fresh installs** and **upgrades** of the Claude Project Template. Launch Claude from any directory and say:

> *"Read /path/to/claude-project-template/setup.md and follow it"*

Claude will detect whether this is a new installation or an upgrade and proceed accordingly. All steps are idempotent — safe to re-run at any time.

---

<!-- WORKFLOW: Claude reads below and executes as a setup/upgrade workflow -->

## Instructions for Claude

You are running the setup workflow for the Claude Project Template. Derive the repo root from the path of this file.

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

If `Projects:` is not found, stop and tell the user:
> "I couldn't find a `Projects:` path in `~/.claude/CLAUDE.md`. Please add `- Projects: /path/to/your/Tasks` under `## Me` and re-run."

### Step 5 — Overwrite global files (safe)

Copy the following files from the repo to the user's Claude installation, overwriting existing versions:
- `files/start-claude.ps1` → `~/.claude/start-claude.ps1`
- `files/skills/status-report/SKILL.md` → `~/.claude/skills/status-report/SKILL.md`

### Step 6 — Merge ~/.claude/CLAUDE.md

Read `~/.claude/CLAUDE.md` and apply each check below. Skip silently if already correct.

#### 6a. ## Me section fields
Ensure all four fields are present under `## Me`. Add any that are missing with a `[fill in]` placeholder and flag them for the user:
- `Name:`
- `Email:`
- `Projects:`
- `Reports:`

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
Replace the existing `Start Claude` task in the project's `.vscode/tasks.json` with the current version from `_Template/.vscode/tasks.json`. Preserve any other tasks already present in the file.

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

Print a consolidated summary:
- Mode detected: Install or Upgrade
- Global files created/overwritten (Steps 2 or 5)
- `~/.claude/CLAUDE.md`: created (Install) or sections added/updated (Upgrade), or "already up to date"
- `_Template/` folder: copied, updated, or `report-template.md` removed (Step 8)
- For each project: list of changes applied, or "already up to date"
- Any items flagged for manual follow-up (missing placeholders, misplaced files, etc.)
