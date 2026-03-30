# Update Projects — Claude Project Template

This file is a runnable upgrade workflow. Launch Claude from any directory and say:

> *"Read /path/to/claude-project-template/update-projects.md and follow it"*

Claude will check your installation against the latest template and apply any missing updates automatically. All steps are idempotent — safe to re-run at any time regardless of your current version.

---

<!-- WORKFLOW: Claude reads below and executes as an upgrade workflow -->

## Instructions for Claude

You are running the upgrade workflow for the Claude Project Template. Derive the repo root from the path of this file. Follow all steps in order. For each check: if the change is already applied, skip it silently. At the end, report a consolidated summary of what was updated and what was already current.

---

### Step 1 — Locate user configuration

Read `~/.claude/CLAUDE.md` and extract:
- `Projects:` path from the `## Me` section
- `Reports:` path from the `## Me` section (may be absent — that is okay)

If `Projects:` is not found, stop and tell the user:
> "I couldn't find a `Projects:` path in `~/.claude/CLAUDE.md`. Please add `- Projects: /path/to/your/Tasks` under `## Me` and re-run."

---

### Step 2 — Overwrite global files (safe)

Copy the following files from the repo to the user's Claude installation, overwriting existing versions:
- `files/start-claude.ps1` → `~/.claude/start-claude.ps1`
- `files/skills/status-report/SKILL.md` → `~/.claude/skills/status-report/SKILL.md`

---

### Step 3 — Merge ~/.claude/CLAUDE.md

Read `~/.claude/CLAUDE.md` and apply each check below. Skip silently if already correct.

#### 3a. ## Me section fields
Ensure all four fields are present under `## Me`. Add any that are missing with a `[fill in]` placeholder and flag them for the user:
- `Name:`
- `Email:`
- `Projects:`
- `Reports:`

#### 3b. ## Jira section structure
Ensure the `## Jira` section contains three subsections:
- `### Machinify Jira (mcp__atlassian__ tools)`
- `### Performant Jira (mcp__jira-dc__ tools)`
- `### General`

If the section exists but lacks this structure, restructure it using `files/CLAUDE.md` as the model — preserve any existing account IDs or user keys the user has already filled in.

#### 3c. ## Tasks section
If absent, add:
```
## Tasks
- Open tasks are tracked in milestone `.md` files. When asked about pending or open tasks, check those files rather than the conversation task list.
```

#### 3d. ## Workspace Paths section
If absent, add the `## Workspace Paths` section from `files/CLAUDE.md`.

#### 3e. ## Activity History section
If absent, copy the full `## Activity History` section (including `### Highlights` and `### Reference Links` subsections) from `files/CLAUDE.md`.

If the section exists but is missing the `### Highlights` or `### Reference Links` subsections, add the missing ones from `files/CLAUDE.md`.

---

### Step 4 — Update per-project files

Scan all immediate subdirectories of the `Projects:` path. A directory is a CPT project if it contains a `CLAUDE.md` with a `# Project:` heading. For each CPT project, apply the checks below.

#### 4a. Rename ## Status to ## Attributes
If the project's `CLAUDE.md` uses `## Status` as the heading for the Active Milestone / Default Jira System fields, rename it to `## Attributes`.

#### 4b. Remove Activity History from project CLAUDE.md
If the project's `CLAUDE.md` contains an `## Activity History` section, remove it — this content now lives in the global `~/.claude/CLAUDE.md`.

#### 4c. Ensure history/ folder exists
If the project does not have a `history/` folder, create it with an empty `.gitkeep` file.

#### 4d. Ensure ## Jira Story section in milestone files
For each `milestoneN-*.md` file in the project root, if the file does not contain a `## Jira Story` section, add it after the `## Goal` section with an empty value:
```
## Jira Story

```

#### 4e. Update .vscode/tasks.json — Start Claude task
Replace the existing `Start Claude` task in the project's `.vscode/tasks.json` with the current version from `_Template/.vscode/tasks.json`. Preserve any other tasks already present in the file.

---

### Step 5 — Update _Template/ folder

If a `_Template/` folder exists directly inside the `Projects:` path:
- Copy all files from the repo's `_Template/` into the user's `_Template/`, overwriting existing versions
- Do **not** delete any files in the user's `_Template/` that are not present in the repo — the user may have added custom content
- **Delete** `report-template.md` from the user's `_Template/` if it exists there — this file has moved to the repo root

If no `_Template/` folder exists in the Projects path, warn the user:
> ⚠️ No `_Template/` folder was found in your Projects directory. Your template was not updated — please copy the latest `_Template/` from the repo manually.

---

### Step 6 — Handle misplaced report-template.md in projects

If any CPT project folder contains a `report-template.md` file, tell the user:
> "`report-template.md` was found in: [list projects]. This file has moved to the repo root and belongs in your Reports folder (`[Reports path]`) if you want to customize report output. The project copies are no longer used — please move or delete them manually."

---

### Step 7 — Summary

Print a consolidated summary:
- Global files overwritten (Step 2)
- Sections added or updated in `~/.claude/CLAUDE.md` (Step 3), or "already up to date"
- `_Template/` folder: files updated, `report-template.md` removed if present (Step 5)
- For each project: list of changes applied, or "already up to date"
- Any items flagged for manual follow-up (missing placeholders, misplaced files, etc.)
