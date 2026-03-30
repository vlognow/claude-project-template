# Quick Start — Guided Project Setup

This file is a runnable workflow. Once your Claude session is open, say:

> *"Read quick-start.md and follow it"*

Claude will ask you a few questions and configure your project automatically.

---

<!-- WORKFLOW: Claude reads below and executes as an interactive setup -->

## Instructions for Claude

You are running the Quick Start setup workflow for a new project copied from the Claude Project Template. Follow these steps in order.

### Step 1 — Introduce yourself

Tell the user:
> "I'll help you configure this project in a few quick steps. I'll ask for the essentials now, then update your project files automatically."

### Step 2 — Gather project info

Ask each question individually and wait for the user's answer before asking the next:

1. Determine the current working directory's base folder name, then ask: "What is the project name? I'll use `<folder name>` — type a new name or `y` to confirm." — if the user says `y` or any confirmation, use the folder name.
2. "Give me a 1–2 sentence overview of the project's purpose and goals."
3. "Will you be using Jira for this project? (yes/no)"
4. If yes: "Which Jira system — `machinify` or `dcswins`?"
5. If yes: "What is the Jira project key? (e.g. `IDS (IDS)`)"

### Step 3 — Gather first milestone info

Ask each question individually and wait for the user's answer before asking the next:

1. "What is the name of your first milestone?"
2. "What is the goal — one sentence describing what completing this milestone achieves?"
3. "What is the business value — what concrete benefit does this milestone deliver?"
4. "Enter the first task as: `task name : brief description`"

After receiving the first task, tell the user:
> "Just one task is enough to get started — you can ask me to add more milestones and tasks at any time after setup is complete."

5. If Jira is enabled: "Do you have a Jira story ID for this milestone? (yes/no)"
6. If yes: "What is the Jira story ID? (e.g. `IDS-12345`)"

### Step 4 — Update CLAUDE.md

Edit `CLAUDE.md` in the project root:

- Replace `[ProjectName]` in the `# Project:` heading with the project name
- Replace the overview placeholder text with the overview provided
- Under `## Attributes`:
  - Set `Active Milestone` to the milestone name
  - Set `Default Jira System` to the Jira system provided (or leave as-is if skipped)
  - Set `Default Jira Project` to the Jira project key provided (or leave as-is if skipped)
- In the `## Milestones` table, update the single row:
  - Set the milestone name
  - Set status to `In Progress`
  - Derive a short lowercase hyphenated abbreviation from the milestone name (e.g. "Build Phase One" → `build-p1`) and update both the display text and filename link: `[milestone1-abbrev](milestone1-abbrev.md)`

### Step 5 — Update the milestone file

- Rename `milestone1-xxx.md` to `milestone1-<abbrev>.md` using the same abbreviation from Step 4
- In the renamed file:
  - Set the `# Milestone 1:` heading to the milestone name
  - Set the `## Goal` section to the goal provided
  - Set the `## Business Value` section to the business value provided
  - Replace the placeholder task with: `- [ ] **<task name>** — <task description>`
  - If a Jira story ID was provided, set the `## Jira Story` section to that value; otherwise leave it blank
  - Leave all other optional sections (Key Decisions, Open Questions, Background) in place with their placeholder text cleared but headings intact

### Step 6 — Write history

Append the following entries to `history/YYYY-MM-monthname.md` (create the file if it doesn't exist, using today's date to determine the filename):

- One `[MILESTONE]` entry for the first milestone, using the business value provided
- One `[TASK]` entry for the first task

Use this format for each:
```
- YYYY-MM-DD [MILESTONE] <milestone name> created | Milestone: M1 | Business Value: <business value> | Status: Not Started
- YYYY-MM-DD [TASK] <task name> — <task description> | Milestone: M1 | Business Value: <business value> | Status: Not Started
```

### Step 7 — Clean up

Delete `quick-start.md` from the project root — it is a one-time setup tool and is no longer needed.

### Step 8 — Wrap up

Summarize the changes made in 3–4 bullet points, then tell the user:

> "Setup complete. **Please exit this Claude session and reopen the workspace** so Claude reloads the updated CLAUDE.md before you start working."
