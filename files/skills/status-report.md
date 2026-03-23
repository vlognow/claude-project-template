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

### 1. Determine the report period

**Week mode** (default or `week=` provided):
- Establish the Monday (start) and Sunday (end) of the target week.
- Format the Monday as `Month D, YYYY` (e.g., `March 16, 2026`) — this is `{{week_of}}`.
- Output filename: `report-YYYY-MM-DD.md` (the Monday's date).

**Month mode** (`month=` provided):
- Derive the first and last day of the specified month.
- Format as `Month YYYY` (e.g., `March 2026`) — this is `{{week_of}}`.
- Output filename: `report-YYYY-MM.md`.

### 2. Locate history files
- History files live at `history/YYYY-MM-monthname.md` (e.g., `history/2026-03-march.md`).
- The target period may span two months (possible in week mode) — read both files if needed.
- If no `history/` directory exists, or no file covers the target period's date range, stop and tell the user:
  - What is missing (directory or specific file)
  - The expected path and file naming convention
  - That they need to create and populate history entries before running the skill

### 3. Parse entries for the target period
- Filter entries whose `YYYY-MM-DD` date prefix falls within the period's start and end dates (inclusive).
- Entry format: `- YYYY-MM-DD [TYPE] Description | Milestone: M# | Business Value: <value> | Status: <status>`
- Separate entries into two groups:
  - **Completed:** `Status: complete` — used for Updates section
  - **In-progress:** `Status: in-progress` — used for Coming Up section
- Track any completed entries where `Business Value` is absent or empty.

### 4. Resolve `{{prepared_by}}`
- Use the current user's full name from their global Claude settings (`~/.claude/CLAUDE.md`).

### 5. Load the template
- If `report-template.md` exists in the working directory, use it as the report structure.
- Otherwise, use the default template embedded at the bottom of this skill file.

### 6. Build report content

#### `{{team_objectives}}`
- Bulleted list of distinct project/objective names drawn from the completed entries.
- Order by perceived impact: business value magnitude first, volume of completed work second.

#### `{{weekly_updates}}`
- One `###` section per objective, in the same order as `{{team_objectives}}`.
- Each section:
  ```
  ### <Objective Name>
  **Status:** <On Track / At Risk / Complete / Blocked>

  - **<Bold title>** — plain description of what was done
    *Business value: one sentence on the concrete impact or why it matters*
  ```
- If an entry has no business value, omit the `*Business value:*` line for that entry.

#### `{{blockers}}`
- Bulleted list from entries with `TYPE: BLOCKER`.
- If none, use `- None`.

#### `{{coming_up}}`
- Bulleted list of descriptions from in-progress entries.
- If no in-progress entries exist, omit this section entirely (see warnings below).

### 7. Warnings (output to Claude Code terminal, not in the report)
- If any completed entries were missing business values:
  > ⚠️ Business value was missing for one or more history entries. For best results, add `Business Value:` to those entries and regenerate the report.
- If no in-progress entries were found:
  > ⚠️ No in-progress entries found — the "Coming Up" section was not included in the report.

### 8. Write the report file
- Use the output filename determined in Step 1.
- Write the file to the working directory.
- Render the report in the chat for review.
- Ask the user: "Does this look right? Let me know if you'd like any changes."

---

## Default Template

Use this structure when no `report-template.md` is found in the working directory:

```markdown
# Status Report
**Period:** {{week_of}}
**Prepared by:** {{prepared_by}}

---

## Team Objectives

{{team_objectives}}

---

## Updates

{{weekly_updates}}

---

## Blockers & Risks
{{blockers}}

## Coming Up
{{coming_up}}
```
