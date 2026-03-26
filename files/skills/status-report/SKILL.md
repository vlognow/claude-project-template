---
description: Generate a weekly or monthly status report from project history files. Use `help` argument for usage docs.
argument-hint: "[week=<date>] [month=<month>] [help]"
---

# Skill: status-report

Generate a weekly or monthly status report from project history files.

## Invocation
```
/status-report [week=<date>] [month=<month>]
```
- `week` and `month` are mutually exclusive. If both are provided, stop and ask the user to specify only one.
- `week` accepts any date format (e.g., `3/23/26`, `March 23`, `2026-03-23`). Derives the Monday of that week.
- `month` accepts a month name or year-month (e.g., `March`, `March 2026`, `2026-03`). Defaults to current year if no year given.
- If neither is provided, default to the most recently completed Monday–Sunday week relative to today.

---

## Steps

### 0. Handle help invocation

If the argument is `help` (i.e., `/status-report help`), render the following usage documentation in chat and stop — do not generate a report.

---

**`/status-report` — Generate a weekly or monthly status report**

**Usage**
```
/status-report [week=<date>] [month=<month>] [help]
```

| Argument | Description |
|---|---|
| *(none)* | Report for the most recently completed Monday–Sunday week |
| `week=<date>` | Report for the week containing the given date (e.g., `3/23/26`, `March 23`, `2026-03-23`) |
| `month=<month>` | Report for a full calendar month (e.g., `March`, `March 2026`, `2026-03`) |
| `help` | Show this usage guide |

`week=` and `month=` are mutually exclusive.

**Requirements**

Projects must use [claude-project-template](https://github.com/vlognow/claude-project-template), which provides the `history/` file convention this skill depends on. Your global `~/.claude/CLAUDE.md` must have `Projects:` and optionally `Reports:` configured under `## Me`.

**History entry format**
```
- YYYY-MM-DD [TYPE] Description | Milestone: M# | Business Value: <value> | Status: <status>
```
- `TYPE`: `TASK`, `MILESTONE`, `DECISION`, or `BLOCKER`
- `Status: complete` → appears in the Updates section
- `Status: in-progress` → appears in the Coming Up section
- Optional: `| Highlight: true` — surfaces the entry in the Highlights section
- Optional: `| Ref: <label> <url>` — attaches an inline reference link (multiple allowed)

**Highlights**

Flag any task or milestone as a highlight to surface it above the detail in the report:
- *"Flag [task/milestone] as a highlight"*
- *"Mark this as a highlight"*
- *"Add a highlight: [statement]"*

**Reference links**

Attach a URL to any task or milestone to include it as an inline link in the report:
- *"Add a reference to [task/milestone]: [URL]"*
- *"Link [Notion doc / Slack thread / URL] to this"*
- *"Attach a reference: [label] [URL]"*

**Output**
- Weekly: `report-YYYY-MM-DD.md` (dated to the Monday of the target week)
- Monthly: `report-YYYY-MM.md`
- Written to the `Reports:` directory configured in `~/.claude/CLAUDE.md`, or the working directory if not set.

---

### 1. Determine the report period

**Week mode** (default or `week=` provided):
- Establish the Monday (start) and Sunday (end) of the target week.
- Format the Monday as `Month D, YYYY` (e.g., `March 16, 2026`) — this is `{{week_of}}`.
- Output filename: `report-YYYY-MM-DD.md` (the Monday's date).

**Month mode** (`month=` provided):
- Derive the first and last day of the specified month.
- Format as `Month YYYY` (e.g., `March 2026`) — this is `{{week_of}}`.
- Output filename: `report-YYYY-MM.md`.

### 2. Locate projects root and reports directory
- Read `~/.claude/CLAUDE.md` and find the `## Me` section.
  - Extract the `Projects:` value — this is the projects root.
  - Extract the `Reports:` value — this is the reports directory (used in Steps 6 and 9).
- If `Projects:` is not found, stop and tell the user:
  > ❌ `Projects` path is not configured. Add the following under `## Me` in your `~/.claude/CLAUDE.md`:
  > ```
  > - Projects: /path/to/your/Tasks
  > ```
  > This should be the folder that contains all your project subdirectories.
- If `Reports:` is not found, the reports directory falls back to the working directory.

### 3. Locate history files across all projects
- Scan all immediate subdirectories of the projects root.
- A subdirectory is a **CPT project** if it contains a `CLAUDE.md` with a `# Project:` heading. Silently skip any directory that does not meet this criterion (e.g., output folders, templates, non-project directories).
- For each CPT project:
  - Derive the project name: extract the value after `# Project:` on the first matching line of its `CLAUDE.md`.
  - Identify the history file(s) covering the target period (`history/YYYY-MM-monthname.md`). The target period may span two months — read both files if needed.
- If no CPT projects are found at all, stop and tell the user what path was scanned and that no CPT project directories were found.
- Track each CPT project in one of three states for Step 8:
  - **No history folder:** `history/` directory does not exist.
  - **No entries for period:** `history/` exists (even if only a placeholder like `.gitkeep`) but no entries fall within the target date range.
  - **Has entries:** one or more entries matched — included in the report.

### 4. Parse entries for the target period
- For each project, filter entries whose `YYYY-MM-DD` date prefix falls within the period's start and end dates (inclusive).
- Entry format: `- YYYY-MM-DD [TYPE] Description | Milestone: M# | Business Value: <value> | Status: <status>`
  - Optional: `| Highlight: true` — marks the entry as a highlight
  - Optional: `| Ref: <label> <url>` — one or more reference links (multiple allowed, each as a separate `| Ref:` field)
- Separate entries into two groups:
  - **Completed:** `Status: complete` — used for Updates section
  - **In-progress:** `Status: in-progress` — used for Coming Up section
- Track which project each entry belongs to.
- Track any completed entries where `Business Value` is absent or empty.
- Track all entries with `Highlight: true` — used for the Highlights section.
- For each entry, collect all `Ref:` fields into an ordered list of `(label, url)` pairs.

### 5. Resolve `{{prepared_by}}`
- Extract the `Name:` value from the `## Me` section of `~/.claude/CLAUDE.md`.

### 6. Load the template
- If `report-template.md` exists in the reports directory (from Step 2), use it as the report structure.
- Otherwise, use the default template embedded at the bottom of this skill file.

### 7. Build report content

#### `{{team_objectives}}`
- Bulleted list of distinct project/objective names drawn from the completed entries.
- Order by perceived impact: business value magnitude first, volume of completed work second.

#### `{{highlights}}`
- Bulleted list of all entries (across all projects) where `Highlight: true` is set.
- Order by business value magnitude first, then chronologically within the same priority tier.
- Format each item as: `- **[Project]** — <description>`
- If the entry has `Ref:` fields, append them inline as markdown links: ` ([label](url))` — multiple refs comma-separated.
- If no highlights exist, omit this section entirely (no heading, no placeholder).

#### `{{weekly_updates}}`
- One `###` section per objective, in the same order as `{{team_objectives}}`.
- Each section:
  ```
  ### <Objective Name>
  **Status:** <On Track / At Risk / Complete / Blocked>

  - **<Bold title>** — plain description of what was done ([label](url), [label](url))
    *Business value: one sentence on the concrete impact or why it matters*
  ```
- If an entry has no business value, omit the `*Business value:*` line for that entry.
- If an entry has `Ref:` fields, append them inline after the description as markdown links: ` ([label](url))`. Multiple refs are comma-separated on the same line.

#### `{{blockers}}`
- Bulleted list from entries with `TYPE: BLOCKER`.
- If none, use `- None`.

#### `{{coming_up}}`
- Bulleted list of descriptions from in-progress entries.
- If no in-progress entries exist, omit this section entirely (see warnings below).

### 8. Warnings (output to Claude Code terminal, not in the report)
- If any completed entries were missing business values:
  > ⚠️ Business value was missing for one or more history entries. For best results, add `Business Value:` to those entries and regenerate the report.
- If no in-progress entries were found:
  > ⚠️ No in-progress entries found — the "Coming Up" section was not included in the report.
- If any CPT projects had no `history/` folder:
  > ⚠️ The following projects were skipped — no `history/` folder found:
  > - `<project name>`
  >
  > To include these projects in future reports, add a `history/` folder and log activity using the entry format in your project's `CLAUDE.md`.
- If any CPT projects had a `history/` folder but no entries for the report period:
  > ⚠️ The following projects had no history entries for this period:
  > - `<project name>`

### 9. Write the report file
- Use the output filename determined in Step 1.
- Write the file to the reports directory (from Step 2), falling back to the working directory if not configured.
- Render the report in the chat for review.
- Ask the user: "Does this look right? Let me know if you'd like any changes."

---

## Default Template

Use this structure when no `report-template.md` is found in the reports directory:

```markdown
# Status Report
**Period:** {{week_of}}
**Prepared by:** {{prepared_by}}

---

## Team Objectives

{{team_objectives}}

---

## Highlights

{{highlights}}

---

## Updates

{{weekly_updates}}

---

## Blockers & Risks
{{blockers}}

## Coming Up
{{coming_up}}
```
